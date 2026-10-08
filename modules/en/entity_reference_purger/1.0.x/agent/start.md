<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Purger — agent index

Removes orphaned `entity_reference` values from parent entities when the referenced entity is
deleted. Enabled **per field** via third-party settings; no admin page, no configure route, no
permissions, no Drush. Reacts in `hook_entity_delete()`; can defer to a cron queue.

- **Turn it on for a field (config field UI + base field code) & where it's stored** →
  [configure/field-setting.md](configure/field-setting.md)
- **How purging works (delete hook flow, immediate vs queued, queue worker)** →
  [api/purge-mechanism.md](api/purge-mechanism.md)

Key facts:
- Two settings, both booleans: `remove_orphaned` (turn purging on) and `use_queue`
  (defer to cron instead of purging immediately; the form defaults it to TRUE, shown only when
  `remove_orphaned` is ticked).
- Config field: stored on `FieldConfig` third-party settings →
  `field.field.<entity>.<bundle>.<field>` → `third_party_settings.entity_reference_purger.{remove_orphaned,use_queue}`.
- Base field: `->setSetting('entity_reference_purger', ['remove_orphaned'=>TRUE,'use_queue'=>FALSE])`.
- Queue worker plugin id **`entity_reference_purger`** (cron time 60s) drains queued purges.
- Only non-computed `entity_reference` fields whose `target_type` equals the deleted entity's type are processed.
