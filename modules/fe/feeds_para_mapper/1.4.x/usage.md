<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Paragraphs (`feeds_para_mapper`) extends the Feeds importer so you can map incoming source values **into fields that live inside Paragraphs**, including nested and multi-valued paragraph structures, instead of only into fields directly on the imported entity.

---

The module has **no configuration page, permissions, Drush commands, or config of its own** — it works entirely through the Feeds mapping UI. When a Feed Type's processor creates an entity that has a Paragraphs field (an `entity_reference_revisions` field), the module walks the referenced paragraph bundles and exposes each supported **leaf field** as its own Feeds mapping target, labelled with its host path (e.g. `Body (field_paragraph:field_nested)`); the raw `paragraphs` target that core Feeds would offer is removed automatically (with a "Mapping has been updated, please refresh the page" warning). It ships a single Feeds target plugin, `wrapper_target` (`field_types: entity_reference_revisions`), that wraps the leaf field's *own* target plugin: at import time it delegates value formatting to that real plugin but redirects the write into Paragraphs entities it creates, duplicates, or updates as needed. A per-mapping **Maximum Values** setting (shown only when both the host paragraph field and the target field are multi-valued) controls how many values one paragraph holds before a new paragraph is spun up for the overflow. Three services do the work: `Mapper` (discovers mappable sub-fields and builds each field's host `path`), `Importer` (slices values, creates/duplicates/updates the paragraph tree, sets values via the wrapped plugin), and `RevisionHandler` (on host-entity update, creates new paragraph revisions and prunes paragraphs that are no longer used). It requires Feeds `^3.0` and Paragraphs (which brings `entity_reference_revisions`). To split a single delimited source column into several paragraph values, combine it with Feeds Tamper.

---

- Import CSV/RSS/XML/JSON rows into an article's Paragraphs field, mapping each source column to a field inside a paragraph bundle.
- Populate a **nested** paragraph field (a paragraph referenced from another paragraph) directly from a feed.
- Fill a **multi-valued** paragraph field, letting the module create one paragraph per group of values.
- Cap how many values land in each paragraph with the per-mapping **Maximum Values** setting, overflowing the rest into new paragraphs.
- Update existing content on re-import so that changed paragraph values create new paragraph revisions rather than duplicating entities.
- Automatically prune paragraphs that a re-import no longer needs (unused paragraphs are removed from the host field).
- Map a plain text/long-text field inside a paragraph bundle from an imported column.
- Map a link, email, number, date, or boolean field inside a paragraph (anything whose field type has a Feeds target plugin).
- Import an image or file into a media/file field that sits inside a paragraph.
- Build a repeating "slide", "card", or "section" paragraph list on a node from tabular data.
- Migrate legacy multi-field records into a structured Paragraphs layout during a Feeds import.
- Keep JSON:API/decoupled-ready structured content in sync by periodically importing into Paragraphs.
- Map several columns that belong to the *same* paragraph so they co-populate one paragraph entity (fields "in common" on the same host).
- Import into a paragraph that is two or more levels deep, letting the module create the whole host chain of intermediate paragraphs.
- Combine with Feeds Tamper to explode a delimited cell (e.g. `a,b,c`) into multiple values across multiple paragraphs.
- Re-run a scheduled Feeds import to refresh paragraph content while preserving revision history.
- Seed demo or test content with realistic nested paragraph structures from a spreadsheet.
- Populate a paragraph-based FAQ/accordion (question + answer sub-fields) from a two-column source.
- Load a paragraph-based gallery where each row becomes a paragraph holding an image plus caption.
- Map to fields on selectively enabled paragraph bundles only (the module respects the host field's allowed/target bundles).
- Drive content for a headless front end whose editors model everything as Paragraphs, without hand-entering each item.
