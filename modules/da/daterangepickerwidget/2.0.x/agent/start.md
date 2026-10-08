<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery UI DateRangePicker Widget (daterangepickerwidget) — agent index

Integrates the comiseo **jQuery UI DateRangePicker** (a Google-Analytics-style two-calendar range
picker) into Drupal as a reusable **form element**, a **field type**, and a **Better Exposed
Filters** plugin. Package `Field types`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 2.0.x.

## Project layout

- **Base module `daterangepickerwidget`** — the `daterangepicker` form/render element and the
  shared `DateRangePickerTrait`; declares the JS asset libraries. Depends only on core `field`.
- **Sub-module `drpw_field`** — the `daterangepicker` field type + widget + formatter + Views
  filter/sort. Depends on the base module. Docs:
  `modules/da/daterangepickerwidget/modules/drpw_field/2.0.x/`.
- **Sub-module `drpw_bef`** — Better Exposed Filters plugin for core Date filters. Depends on the
  base module and `better_exposed_filters`. Docs:
  `modules/da/daterangepickerwidget/modules/drpw_bef/2.0.x/`.

## Base module — what it provides

- **Form element** `#[FormElement('daterangepicker')]` → `src/Element/DateRangePickerElement.php`
  (`DateRangePickerElement`, extends `FormElementBase`). Use as `'#type' => 'daterangepicker'`.
  Details, every `#option`, preset ranges and default value →
  [element/form-element.md](element/form-element.md).
- **Trait** `Drupal\daterangepickerwidget\DateRangePickerTrait` (`src/DateRangePickerTrait.php`) —
  the single source of the default option set, the Drupal→JavaScript option map, the shared options
  sub-form builder, the settings summary, and the drupalSettings writer. Reused by the element, the
  field widget, both Views filters and the BEF plugin. →
  [element/form-element.md](element/form-element.md).
- **Libraries** (`daterangepickerwidget.libraries.yml`): `jquery` (1.8.3), `jquery-ui` (1.9.2),
  `momentjs` (2.3.1), `jquery-ui-daterangepicker` (0.5.0 + `js/daterangepicker.js`). The comiseo
  plugin, jQuery UI theme, and libraries are expected under `/libraries/…` (installed via
  Asset Packagist / `bower-asset/jquery-ui-daterangepicker`).

## Facts an agent needs

- No routes, no permissions, no services, no config entities, no Drush, no hooks in the base module.
- No settings/config form — options are set **per element / per widget / per filter**, never
  site-wide.
- Storage format for a range is a JSON string `{"start":"yy-mm-dd","end":"yy-mm-dd"}`; the internal
  `alt_format` is hard-pinned to `yy-mm-dd` in code and must not be overridden.
- `js/daterangepicker.js` runs `jQuery.noConflict(true)` and binds the picker to any
  `input.daterangepicker`, reading its config from `drupalSettings.daterangepicker[<field name>]`.
