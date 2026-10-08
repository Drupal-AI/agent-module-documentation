<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Repeat (entity_repeat) — agent index

Repeats entities based on time criteria. It is **not** a field type or formatter: it ships one
**field widget** for `date_recur` fields plus a **save-time event subscriber** that clones the base
entity once per recurrence occurrence (via the **Replicate** module). Generated clones are ordinary
content governed by normal entity access. No settings form, no routes, no config schema.

- **Dependencies:** `date_recur`, `date_recur_modular`, `replicate`. Core `^9.3 || ^10 || ^11`.
  License GPL-2.0-or-later. Version 1.1.4 (version-dir 1.1.x).
- **Submodule:** `entity_repeat_group` (optional; needs contrib `group`) — see
  [modules/entity_repeat_group](../../modules/entity_repeat_group/1.1.x/agent/start.md).

## What it provides

- **Widget** `EntityRepeatWidget` (id `entity_repeat`, `field_types = { date_recur }`), extends
  `date_recur_modular`'s `DateRecurModularAlphaWidget`. Adds an "enable repeat" checkbox and drops
  the infinite-recurrence option. → [fields/widget.md](fields/widget.md)
- **Generation flow** `EntityRepeatEventSubscriber::onSave` (on `DateRecurEvents::FIELD_VALUE_SAVE`)
  + procedural helpers in `entity_repeat.module` (batch clone, key/value tracking, alter hooks).
  → [api/generation.md](api/generation.md)
- **Permissions** dynamic per-bundle `repeat own …` / `repeat any …` via
  `EntityRepeatPermissions::permissions` (permission callback). → [permissions/permissions.md](permissions/permissions.md)
- **Theme** `entity_repeat_widget` (`templates/entity-repeat-widget.html.twig`); **hooks**
  `hook_entity_repeat_generate_alter`, `hook_entity_repeat_create_entity_alter` (`entity_repeat.api.php`).
