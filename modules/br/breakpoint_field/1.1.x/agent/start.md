<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Breakpoint Field (breakpoint_field) — agent index

Field API module (version 1.1.0, core `^10 || ^11 || ^12`, package "Field types"). Provides one field type that stores a single breakpoint machine id chosen from a site-builder-selected breakpoint group.

## Dependencies
- `drupal:field`, `drupal:field_ui` (declared in `breakpoint_field.info.yml`).
- Uses core service `breakpoint.manager` (`\Drupal\breakpoint\BreakpointManagerInterface`). No Composer requirements, no libraries, no submodules.

## What it provides
- **Field type** `breakpoint_field_item` — `src/Plugin/Field/FieldType/BreakpointItem.php`. Single `value` property; storage is a `text`/`tiny` column (nullable).
- **Widget** `breakpoint_field_widget` (default) — `src/Plugin/Field/FieldWidget/BreakpointWidget.php`. Settings form picks one breakpoint group; form element is a select of that group's breakpoints; server-side `validate()` regex-checks the value.
- **Formatter** `breakpoint_field_formatter` (default) — `src/Plugin/Field/FieldFormatter/BreakpointFormatter.php`. Renders `<p>The breakpoint is @group</p>` per item.
- **Config schema** — `config/schema/breakpoint_field.schema.yml` (field value + widget settings).

## What it does NOT provide
No routes, no `*.permissions.yml`, no `*.services.yml`, no settings/config route (`configure` is null), no `.module`/`.install` hooks, no `config/install`, no Drush, no custom plugin types.

## Solution docs
- `agent/fields/field-type.md` — the field type, widget (group setting + option building + validation), and formatter, with install/enable and operating notes.
