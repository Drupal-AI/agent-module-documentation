<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Castorcito date (castorcito_date) — agent index

Sub-module of **[Castorcito](../../../../1.2.x/agent/start.md)**. Adds one cfield type. Package
`Castorcito`, version 1.2.1-beta5, core `^10.2 || ^11`, GPL-2.0-or-later.

## Dependency

- `castorcito:castorcito` only.

## What it provides

- **cfield plugin** `date` — `src/Plugin/CastorcitoComponentField/Date.php`, class `Date` extends
  `Drupal\castorcito\ConfigurableComponentFieldBase` (a `CastorcitoComponentField` plugin; the
  plugin *type* is defined by the parent module).
  - `defaultModel()`: `['value' => '']`.
  - `defaultConfiguration()`: adds `date_type` (default `datetime`) and
    `display.format_type` (default `medium`).
  - `buildConfigurationForm()`: a `date_type` select (`datetime` = date and time / `date` = date
    only) and a `display.format_type` select populated from `date_format` config entities, each
    option previewed by formatting `now` with `date.formatter`.
  - `submitConfigurationForm()`: persists `date_type` and `display`.
- **Config schema** `castorcito.field.date` (`config/schema/castorcito_date.schema.yml`):
  `date_type` (string), `display.format_type` (string).
- **SDC** `components/castorcito_date/` — rendering markup; override with
  `replaces: 'castorcito_date:castorcito_date'`.

No permissions, routes, services, hooks, install hooks, or Drush commands.

## Usage

Enable it, then add a **Date** cfield when building a component
(route `castorcito.component_field_add_form`). See the parent plugin doc:
[../../../../1.2.x/agent/plugins/component-fields.md](../../../../1.2.x/agent/plugins/component-fields.md).
