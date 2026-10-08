<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Explorer shows where a content entity is referenced across the site.

---

Drupal knows the relationships between entities but does not surface them in one place, so the everyday question "is anything still using this?" has no direct answer. Entity Usage Explorer answers it by scanning entity-reference fields, menu links, and (when Paragraphs is present) Paragraphs Library items for references to a given entity, then presenting them on an overview page at `/admin/usage/{entity_type}/{entity_id}`. It also ships a Views field, `Base Entity Usage`, that renders the total usage count for each row as plain text or as a link to that overview page, and it adds a "Usage" operations link to every content entity's row for people who hold the `access entity usage dashboard` permission. It requires nothing beyond Drupal core; Views integration uses core Views, and Paragraphs support activates only when the Paragraphs module is installed.

---

- Find out where a specific node, term, media item, or user is referenced.
- Decide whether an entity is safe to delete before removing it.
- Assess the blast radius before editing a widely shared asset.
- Locate orphaned content that nothing references.
- Understand why a taxonomy term or media item cannot be removed.
- Audit media reuse across articles, blocks, and paragraphs.
- Add a `Base Entity Usage` count column to a content-admin View.
- Render that usage count as a link straight to the per-entity overview.
- Export usage counts as CSV, JSON, or XML via Views Data Export.
- Jump to an entity's usage from its row using the "Usage" operations link.
- Trace a paragraph back to the parent node or entity that embeds it.
- Find which Paragraphs Library items reuse a shared paragraph.
- Detect references coming from menu links (`entity:` or `internal:` URIs).
- Support a content cleanup or retirement programme with concrete data.
- Plan a migration by mapping reference relationships first.
- Review reference coverage during a periodic site audit.
- Give editors a self-service way to check reuse before unpublishing.
- Gate access to the usage overview per role with a dedicated permission.
- Confirm an entity is unused before archiving it.
- Build a reporting View of high-usage vs. zero-usage entities.
