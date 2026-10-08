<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk Copy Fields adds a core Action that copies the value of one field into another compatible field across the content entities you select on a bulk-operations listing such as /admin/content, driven by a four-step confirmation form and Batch API.

---

The need arrives with a content-model change, which on a long-lived site is more or less constant. A plain-text field becomes rich text; a single-value field becomes multi-value; two fields are consolidated; a field is "renamed", which in Drupal means creating a new one and moving the data because fields cannot actually be renamed. The schema change is the easy part; moving the existing content is the work, and the alternatives are a full migration (correct, but disproportionate for one field) or a throwaway `drush php:script` loop nobody reviews. Bulk Copy Fields puts the move in the interface. On install it walks every entity type and auto-creates one configured action per type — `bulk_copy_fields_on_<entity_type>`, labelled *Bulk Copy \<Label\> Fields* — and re-creates any missing ones on `hook_entity_operation_alter`. You select rows on a Core Bulk Operations listing, choose the action, and are redirected to `/admin/bulk_copy_fields`, a step-through form: (0) choose which installed languages/translations to operate on, (1) choose the source field(s), (2) map each source field to a destination field of the *same type*, (3) confirm. A Batch then copies each source value into the destination field on every selected entity and saves it (nodes get a new revision). Type matching is loosened in a few sensible ways — `created`/`changed`/`date`/`daterange` are grouped as `datetime`, `entity_reference_revisions` maps onto `entity_reference`, and `string_long` maps onto `text_with_summary` — and entity-reference copies validate that source and destination share a `target_type`, dropping referenced items whose bundle the destination field forbids (with a warning). The whole thing sits behind the restrict-access permission **administer bulk_copy_fields** and, per the maintainer's own note, is built for **Core Actions only — not the contrib Views Bulk Operations module**. It is explicitly **experimental**, version **8.x-1.0-alpha6**, on `^8 || ^9 || ^10 || ^11`. Three cautions, because this writes content in bulk. **Field types must be compatible, and the interesting failures are the partial ones** — rich text copied into a plain field loses markup silently, a multi-value field copied into a single-value one keeps the first delta and discards the rest. **There is no undo**; previous values are gone unless revisions were being kept, so run it on a database copy first (the form itself warns you). And **saving entities in bulk fires everything that hooks entity save** — search reindexing, cache invalidation, workflow transitions, outbound webhooks — so a copy across ten thousand nodes is a far larger operation than it looks.

---

- Move field data after "renaming" a field (create-new-then-copy).
- Copy a plain-text field into a new rich-text (`text_with_summary`) field.
- Consolidate two fields into one before deleting the redundant one.
- Backfill a newly added field from an existing one across selected content.
- Populate a new field from an old one during a phased model refactor.
- Copy a body/summary into a dedicated teaser or display field.
- Move a plain date value into a `datetime` or `daterange` field.
- Copy an `entity_reference` field into an `entity_reference_revisions` field.
- Migrate a taxonomy reference into a differently configured reference field.
- Copy values only for a selected subset of nodes chosen on /admin/content.
- Copy field values for specific translations by choosing languages in step 0.
- Move legacy field data forward before removing the legacy field.
- Copy a title-like string field into another string field for display.
- Move data between compatible Paragraph fields.
- Duplicate a field's values into a parallel field for A/B display.
- Copy `created`/`changed` timestamps into a configurable date field.
- Reshape content in place instead of writing a one-off `drush php:script`.
- Apply a field copy to any entity type (users, terms, media, custom) via its auto-created action.
- Stage a field migration on a copied database, verify, then repeat on production.
- Fill a required new field so existing content validates after a model change.
