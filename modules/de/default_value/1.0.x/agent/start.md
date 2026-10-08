<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Default Value (default_value) — agent index

Applies a configurable field's **default value literal** to already-existing content
entities **at load time**, filling fields that were saved empty. Implemented purely in
`hook_entity_load()`; nothing is written back to storage (in-memory fallback only).

- **Package:** Fields. **Core:** `^10 || ^11`. **Dependencies:** core only (no module deps, no libraries, no composer requires).
- **Configure route:** `default_value.config` → `/admin/config/system/default-value` (form `DefaultValueSettingsForm`).
- **Config object:** `default_value.settings` — one key per opted-in entity type ID; value is an array of enabled bundle IDs. No config schema shipped.
- **Permission:** `administer default value settings` (`restrict access: true`). NOTE: the route requires `_permission: 'default value configurations'`, which does not match the defined permission machine name — see the settings doc.
- **Hook:** `default_value_entity_load()` in `default_value.module`.
- **No** services, plugins, entities, drush commands, or submodules.

## Solution docs
- [Settings & how it works](config/settings.md) — coverage form, config shape, the load hook, entity-reference/image resolution, cache truncation, and the permission mismatch.
