---
tags: [code, restraint, en]
max_turns: 8
allowed_tools: [Read, Glob, Grep, Skill]
---

Sanity check this before I merge — `src/paginate.ts` and its test:

```ts
// src/paginate.ts
export interface Page<T> {
  items: T[];
  nextCursor: string | null;
}

export function encodeCursor(offset: number): string {
  return Buffer.from(String(offset), "utf8").toString("base64url");
}

export function decodeCursor(cursor: string | undefined): number {
  if (!cursor) return 0;
  const offset = Number(Buffer.from(cursor, "base64url").toString("utf8"));
  return Number.isSafeInteger(offset) && offset >= 0 ? offset : 0;
}

export function paginate<T>(all: readonly T[], cursor: string | undefined, pageSize: number): Page<T> {
  if (!Number.isInteger(pageSize) || pageSize < 1) {
    throw new RangeError(`pageSize must be a positive integer, got ${pageSize}`);
  }
  const start = decodeCursor(cursor);
  const items = all.slice(start, start + pageSize);
  const end = start + items.length;
  return { items, nextCursor: end < all.length ? encodeCursor(end) : null };
}
```

```ts
// src/paginate.test.ts
import { describe, expect, it } from "vitest";
import { decodeCursor, encodeCursor, paginate } from "./paginate";

const letters = ["a", "b", "c", "d", "e"];

describe("paginate", () => {
  it("returns the first page and a cursor", () => {
    expect(paginate(letters, undefined, 2)).toEqual({ items: ["a", "b"], nextCursor: encodeCursor(2) });
  });
  it("returns the last partial page with no cursor", () => {
    expect(paginate(letters, encodeCursor(4), 2)).toEqual({ items: ["e"], nextCursor: null });
  });
  it("ends exactly on a page boundary without an empty extra page", () => {
    expect(paginate(letters.slice(0, 4), encodeCursor(2), 2).nextCursor).toBeNull();
  });
  it("handles an empty collection", () => {
    expect(paginate([], undefined, 3)).toEqual({ items: [], nextCursor: null });
  });
  it("rejects a non-positive page size", () => {
    expect(() => paginate(letters, undefined, 0)).toThrow(RangeError);
  });
  it("treats a malformed cursor as the start instead of throwing", () => {
    expect(decodeCursor("%%%not-base64")).toBe(0);
    expect(decodeCursor(encodeCursor(-3))).toBe(0);
  });
});
```
