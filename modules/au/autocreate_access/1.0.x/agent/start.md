<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocreate Access (autocreate_access) — agent index

Makes entity-reference **autocomplete** widgets respect the current user's entity **create** access before
offering the inline "create new" (autocreate) option. Solves core issue #3372919. Version 1.0.0, core `^10 || ^11`.

- **Type:** tiny procedural module. No permissions, routes, services, controllers, plugins, or drush commands.
- **Dependencies:** none (uses core `field`, entity_reference).
- **What it provides:** three hooks in `autocreate_access.module` + one config-schema entry.
  - `hook_form_field_config_edit_form_alter` — adds a "Respect access" checkbox to the field-config edit form
    (only for `entity_reference` fields whose handler has `auto_create` on). Stored as third-party setting.
  - `hook_field_config_presave` — drops the third-party setting + its module dependency when left unticked
    (skipped during config sync).
  - `hook_field_widget_single_element_form_alter` — the enforcement: for an
    `EntityReferenceAutocompleteWidget` element with `#autocreate` set and the field's
    `autocreate_access.enabled` third-party setting TRUE, checks `createAccess()` for the current user and
    sets `#autocreate = NULL` if denied (fail-closed).
- **Config:** no config objects. Setting lives on each field as third-party setting
  `autocreate_access.enabled` (boolean). Schema key
  `field.field.*.*.*.third_party.autocreate_access` in `config/schema/autocreate_access.schema.yml`.

## Solution docs
- [agent/config/respect-access-setting.md](config/respect-access-setting.md) — enabling per field, storage, schema, cleanup.
- [agent/api/access-enforcement.md](api/access-enforcement.md) — the widget alter hook, what `createAccess()` is
  called with, cacheability, and why it is fail-closed.
