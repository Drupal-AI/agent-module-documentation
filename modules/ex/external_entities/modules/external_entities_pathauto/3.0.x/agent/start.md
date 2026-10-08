<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# external_entities_pathauto — agent index

Submodule of **[external_entities](../../../../3.0.x/agent/start.md)**. Enables **Pathauto URL-alias
generation for external entities**. It adds a per-type "Automatically generate aliases" checkbox and
generates an alias when an external entity is loaded (external entities have no local save event to
hook, so aliases are created on `hook_entity_storage_load`). Core `^9 || ^10 || ^11`. Depends on
`external_entities` and `pathauto:pathauto`. No settings page of its own, no permissions.

- **Turn on and use alias generation** → [configure/pathauto.md](configure/pathauto.md)

Key facts:
- Per-type third-party setting: `generate_aliases` (namespace `external_entities_pathauto`), added to the type form.
- Pathauto alias-type plugin class: `Plugin/pathauto/AliasType/ExternalEntityAliasTypeBase` (extends core pathauto `EntityAliasTypeBase`).
- Hooks: `hook_pathauto_alias_types_alter`, `hook_config_schema_info_alter`, `hook_form_alter`, `hook_entity_storage_load`.
- Provides no config schema file (schema key added via hook).
