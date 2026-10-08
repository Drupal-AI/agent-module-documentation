<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dependent List (dependent_list) — agent index

Makes a core list field's options depend on the value chosen in another list field on the **same** entity, filtered live via AJAX on entity edit forms. No entities, no plugins, no permissions, no routes of its own — it is entirely hook-driven field behaviour.

## What it is
- Field type support: `list_string`, `list_integer`, `list_float`.
- Widget support: `select`, `radios`, `checkboxes`.
- Config storage: a `dependent_list` **third-party setting** on the child field's `FieldConfig` — `parent_field` (machine name) + `value_map` (parent value => array of allowed child keys). Schema in `config/schema/dependent_list.schema.yml`.
- Works inside field groups, paragraphs, and nested inline entity forms.

## Dependencies
- Core modules: `options`, `field_ui` (declared in `dependent_list.info.yml`). No composer requirements, no library deps.

## Provides
- Service `dependent_list.ajax_handler` -> `Drupal\dependent_list\Ajax\DependentListAjaxHandler` (args: `@entity_field.manager`, `@entity_type.manager`).
- Ajax command `Drupal\dependent_list\Ajax\UpdateOptionsCommand` (`updateOptionsCommand`) + JS `js/update-options-command.js` (library `dependent_list/dependent_list`, depends on `core/drupal.ajax`).
- Procedural hooks in `dependent_list.module`: `hook_form_field_config_edit_form_alter` (config UI), `hook_field_widget_single_element_form_alter` + `hook_field_widget_complete_form_alter` (runtime option filtering + AJAX wiring), `hook_options_list_alter` (empty-option dedup), an entity builder, and process/element-validate callbacks.

## Solution docs
- [Configure a dependent field](config/dependent-field.md) — the field-settings UI, third-party settings, schema, entity builder.
- [Runtime AJAX option filtering](api/ajax-filtering.md) — how parent/child widgets are altered, the AJAX handler, validation helpers, and JS.
