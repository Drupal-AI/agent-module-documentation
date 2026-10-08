<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Field Capitalization (entity_field_capitalization) — agent index

Title-cases selected **entity field values at write time** via `hook_entity_presave()`, skipping an
admin-defined exclusion list. NOT a display formatter — it rewrites the **stored** value on entity
create/update. Version **1.0.1**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
No composer.json, no module dependencies, no libraries.

- **The presave hook + the service (how the transform runs, the regex, exclusions)** →
  [api/mechanism.md](api/mechanism.md)
- **Settings form, config object, keys, route & permission** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- One hook: `entity_field_capitalization_entity_presave()` in
  `entity_field_capitalization.module`. Runs on every `ContentEntityBase` presave; if the entity's
  `entity_type`+`bundle` is configured, each listed field's `->getString()` value is passed through
  the service and written back with `$entity->set()`.
- One service: `entity_field.capitalization` → `Drupal\entity_field_capitalization\CapitalizationService`
  (implements `CapitalizationInterface`), constructed with `@config.factory`. Defined in
  `entity_field_capitalization.services.yml`.
- One config object: `entity_field.capitalization_config` with keys `entity_and_fields` (multiline
  `ENTITY_TYPE,BUNDLE,FIELD_NAME` lines) and `exclude_strings` (comma list). Default install file is
  effectively empty. **No config schema shipped.**
- One form/route: `EntityCapitalizationConfigForm` at route `entity_field.capitalization_settings`,
  path `/admin/config/field-capitalization-settings`, requirement `_permission: administer site
  configuration` (a **core** permission — the module defines **no** permissions.yml). Menu link in
  `entity_field_capitalization.links.menu.yml` under `system.admin_config_ui`.
- No entities, no field plugins, no widgets/formatters, no Drush, no other hooks besides `_help`.
