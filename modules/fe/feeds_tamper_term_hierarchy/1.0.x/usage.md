<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Tamper Term Hierarchy is a Tamper plugin (`import_term_hierarchy`) that converts a delimited path such as "Food > Fruit > Apple" into a taxonomy term id, resolving or creating each level under its parent so the imported term lands in the right place in the hierarchy.
---
The module solves hierarchical taxonomy import from feeds where a source column carries a full or partial path in one string. During a Feeds import the plugin splits the incoming value on a configurable delimiter (default `>`), trims and drops empty segments, then walks the path left-to-right: for each name it looks up an existing term by name + vid (+ parent), and either reuses it, auto-creates it under the current parent (when "Allow terms to be auto created" is on), or skips the row with a `SkipTamperDataException` (when auto-create is off and the term is missing). The resolved term id of the deepest segment is returned as the tampered value, ready to feed a taxonomy term-reference field. A per-instance cache (`termIdCache`) avoids repeated identical lookups across many rows.

Operational and security notes: configuration (delimiter, target vocabulary, allow-autocreate, match-anywhere) is set on the Tamper plugin within a Feed type by users with Feeds/Tamper admin rights; the plugin exposes no routes, permissions or public endpoints of its own. All term lookups and creation go through the entity storage API (`loadByProperties`, `create`, `save`) — no raw SQL — and empty segments are filtered to avoid nameless terms that would abort the import. The "Match the first term anywhere in the hierarchy" option lets a partial path (e.g. "B > C") match an existing "B" at any depth (first match wins). The typical setup task is: add the "Import Taxonomy Terms Hierarchy" tamper to the source feeding a term-reference field, pick the vocabulary and delimiter, and decide whether missing terms should be created.
---
- Import "Parent > Child > Grandchild" strings into nested taxonomy terms.
- Choose the delimiter that separates hierarchy levels (default `>`).
- Target a specific vocabulary for the created/looked-up terms.
- Auto-create missing terms at each level during import.
- Skip rows whose terms don't exist instead of creating them.
- Reuse existing terms rather than duplicating them.
- Match a partial path against an existing subtree via "match anywhere".
- Map a source category column to a taxonomy term reference field.
- Handle trailing or doubled delimiters without breaking the import.
- Trim whitespace around each path segment automatically.
- Return the deepest term's id to a term-reference target.
- Cache repeated lookups to speed up large imports.
- Build a category tree incrementally across many feed rows.
- Keep imported terms correctly parented under their ancestors.
- Import product taxonomies with multi-level categories.
- Import geographic hierarchies (Country > Region > City).
- Enforce a strict vocabulary by disabling auto-create.
- Combine with other Tamper plugins in the same source pipeline.
- Re-run imports idempotently, reusing already-created terms.
- Validate the delimiter is non-empty on the plugin settings form.
