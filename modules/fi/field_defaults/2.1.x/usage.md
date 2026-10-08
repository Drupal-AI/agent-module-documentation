<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Defaults pushes a field's configured default value onto **existing** content in bulk — either filling only empty fields or overwriting every entity of that field's entity type and bundle — from the field's *Manage fields* edit form or a Drush command.

---

Drupal only applies a field's default value to *new* entities; existing content is never touched when you set or change a default. Field Defaults closes that gap. It works one field at a time. On the field's *Manage fields → Edit* page it adds an **"Update existing content"** section (visible to users with the *administer field defaults* permission) with an "Overwrite existing content with the selected default value(s)" checkbox, an optional per-language checklist for translations, and a "Keep existing values" checkbox that limits the update to empty fields only. Saving the field then runs a batch that loads every entity of the field's target entity type/bundle (10 at a time) and writes the field's `default_value[0]` into each one, optionally skipping non-empty fields. The same operation is available headless via the `field_defaults:bulk-update` Drush command (alias `fdbu`) and via the `field_defaults.processor` service (`processFieldForm()`). A single site setting, `retain_changed_date` (default on), preserves each entity's original *changed* timestamp during the update by decorating core's `ChangedItem` field type with a `PreserveChangedItem` that skips bumping the timestamp when a `preserve` flag is set.

---

- Backfill a newly added field on hundreds of existing nodes with its default value in one pass.
- Set a default "Published region" or "Category" on all existing Article nodes at once.
- Fill only the entities where a field is still empty (leave manually entered values intact) using "Keep existing values".
- Overwrite a field's value on every entity of a bundle when a business default changes.
- Apply a default value from the command line as part of a deploy/update hook via `drush field_defaults:bulk-update`.
- Bulk-update a boolean field (e.g. set an "Active" flag to 1) across all existing users or nodes.
- Push a default entity reference (e.g. a default taxonomy term or media item) onto existing content.
- Update a default value across specific translations of translatable content, language by language.
- Retain the original "changed"/updated timestamp so a mass default update does not re-sort content by date.
- Re-run a default across content after importing legacy data that lacked the field.
- Set a standard link or address on all existing content of a type.
- Give every existing entity a default string/text value without editing each one by hand.
- Seed a numeric or list field with a sensible default on old content before enabling validation.
- Script a repeatable field backfill in CI using the `fdbu` alias.
- Apply defaults programmatically from custom code via the `field_defaults.processor` service.
- Populate a required field on legacy content so it passes validation on next edit.
- Standardise a field value across a content type after a content model change.
- Update the default only for empty fields to avoid clobbering editor-entered data (`no_overwrite`).
- Apply a media or file default (the processor normalises `media:` handler target IDs) to existing entities.
- Bulk-set a default on user entities (which have no bundle) — the processor handles bundle-less entity types.
- Keep audit/changed dates stable during mass updates by leaving "Retain original entity updated time" enabled.
- Roll out a new default value to production content as a controlled batch instead of a manual edit marathon.
- Reset a field back to its intended default everywhere after an erroneous bulk edit.
