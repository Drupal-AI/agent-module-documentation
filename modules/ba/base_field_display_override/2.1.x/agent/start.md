<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base Field Display Configurability Override (base_field_display_override) — agent index

Site-builder tool that forces an entity type's **base fields** to be display-configurable in
Field UI ("Manage display"), regardless of what the entity class declared. It does this by
storing a per-entity-type / per-field override map and applying it via
`hook_entity_base_field_info_alter()` → `BaseFieldDefinition::setDisplayConfigurable('view', ...)`.

- **Package:** Fields. **Core:** `^8 || ^9 || ^10 || ^11`. **License:** GPL-2.0-or-later.
- **Dependencies:** none (core only). No composer requirements, no libraries, no submodules.
- **Drush commands:** none. **Config schema:** none shipped. **Permissions:** none defined (uses core `access administration pages`).

## What it provides
- **Route / form:** `base_field_display_override.base_field_display_override_form` at
  `/admin/structure/base-field-display-override/manage` — `Form\BaseFieldDisplayOverrideForm`
  (extends `ConfigFormBase`), requires permission `access administration pages`, `_admin_route: TRUE`.
  Menu link under *Structure* (`*.links.menu.yml`). Also the `configure` route in `*.info.yml`.
- **Config object:** `base_field_display_override.overrides` (key `display`), the only editable config.
- **Service:** `base_field_display_override.manager` →
  `Service\BaseFieldDisplayOverrideManager` (implements `BaseFieldDisplayOverrideManagerInterface`).
- **Logger channel:** `logger.channel.base_field_display_override` (declared, not used in shipped code).
- **Hooks:** `hook_help()` and `hook_entity_base_field_info_alter()` in `base_field_display_override.module`.

## Key behavior (important)
- The override map is applied at **field-definition build time** for `view` display only
  (form display is not touched). Values per field: `visible`, `hidden`, `none` (no override).
- It only flips the *configurability* flag; it does **not** change field access or default rendering.
  Protected base fields (e.g. user `pass`/`mail`/`init`) still obey their access handlers when rendered.
- Saving the form **deletes and rebuilds** the whole config from submitted values, then calls
  `EntityFieldManager::clearCachedFieldDefinitions()` so overrides take effect immediately.

## Solution docs
- Config form, config object, routing & permission, apply mechanism, service API:
  [`agent/config/settings.md`](config/settings.md)
