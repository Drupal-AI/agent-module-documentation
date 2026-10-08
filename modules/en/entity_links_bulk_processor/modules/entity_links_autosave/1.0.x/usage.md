<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Links Auto-Save automatically runs Entity Links Bulk Processor's link/HTML conversion on entity save, for the entity types, bundles, and fields you enable.

---

Entity Links Auto-Save is a submodule of Entity Links Bulk Processor. Its `hook_entity_presave()` calls the parent module's `entity_links_bulk_processor_process_attributes()` on each configured text field, so links are normalized to UUID-based entity links (plus all the other configured transformations) at the moment content is saved — not just during bulk runs. It reads all conversion rules (domains, path aliases, CSS mappings, media conversion, multilingual settings) from the parent's `entity_links_bulk_processor.settings`, and its own `entity_links_autosave.settings` config selects which entity types, bundles, and fields to process and whether to log or show user feedback. It skips processing while a bulk/Drush run is in progress (state flag `entity_links_bulk_processor.processing`). Configuration lives at `/admin/config/content/entity-links-autosave/settings` behind the `administer entity links autosave` permission.

---

- Keep newly authored or edited content links in entity-link format automatically.
- Normalize links on save without running a bulk job.
- Apply the parent module's rules (aliases, domains, CSS, media) continuously.
- Limit auto-processing to specific entity types (node, paragraph, media, etc.).
- Restrict processing to selected bundles per entity type.
- Restrict processing to selected text fields.
- Prevent editors from pasting stale `/node/N` links that break when IDs change.
- Enforce clean markup during ongoing editorial work after a migration.
- Show editors warnings about links that could not be validated.
- Enable debug logging to trace what the presave hook changed.
- Respect the parent module's multilingual language filters on save.
- Avoid double-processing by deferring to bulk runs when one is active.
- Preserve text-format and summary values on `text_with_summary` fields.
- Turn automatic conversion on or off globally with one setting.
- Complement one-time bulk cleanup with ongoing quality control.
