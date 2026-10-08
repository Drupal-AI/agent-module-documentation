<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the term-hierarchy tamper

## Where
On a Feeds Tamper source within a Feed type, add the **Import Taxonomy Terms Hierarchy** tamper (`import_term_hierarchy`) to the column that carries the hierarchy path, and target a taxonomy term-reference field with the tampered output.

## Settings
- `delimiter` (required, default `>`) — separates hierarchy levels; validated non-empty on save.
- `vocabulary` (required) — the vocabulary in which terms are looked up/created.
- `allow_autocreate` (default on) — create missing terms; when off, a missing term throws `SkipTamperDataException` and the row is skipped.
- `match_anywhere` (default off) — allow the FIRST path segment to match an existing term at any depth (for partial paths like "B > C" under an existing "A > B > C"); first match wins. Deeper segments are always resolved under the previously resolved parent.

## Processing (`tamper()`)
1. Non-string input throws `TamperException`; null/empty returns null.
2. `array_filter(array_map('trim', explode(delimiter, data)), 'strlen')` — trims and drops empty segments (guards against nameless terms).
3. Walk segments; for each: build a cache key `vid:parent|*:name`; on cache miss `loadByProperties(['name','vid'(,'parent')])`.
4. Reuse found term; else create under `parent` (if autocreate) with `create()+save()`; else skip.
5. `parent = tid = term id`; cache it. Return the deepest `tid`.

Idempotent across re-imports (existing terms are reused). No raw SQL; all via the taxonomy_term entity storage.
