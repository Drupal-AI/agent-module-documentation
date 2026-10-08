<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Columns / Container (ebt_columns) — agent index

Ships one `block_content` bundle, **`ebt_columns`**, that renders its child blocks in a 1-6 column
CSS grid. Part of the **Extra Block Types (EBT)** family. Package *Extra Block Types*. Version
**2.0.0** (dir `2.0.x`). Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later.

- Dependencies: **`ebt_core:ebt_core`** (shared `ebt_settings` field type/widget/formatter + design
  layer) and **`block_field:block_field`** (the nested-block field type). From `composer.json`:
  `drupal/ebt_core:^2.0`, `drupal/block_field:^1.0`.
- No `.module`, no `.install`, no `*.services.yml`, no `*.routing.yml`, no `*.permissions.yml`, no
  `config/schema/`. No settings form (`configure: null`), no permissions, no Drush, no hooks.

## What it actually provides

- **Bundle** `block_content.type.ebt_columns` ("EBT Columns / Container"), installed from
  `config/install/` — see [config/block-type.md](config/block-type.md).
- **Fields** on that bundle: `field_ebt_columns_blocks` (multi-value `block_field`, the columns'
  contents), `field_ebt_settings` (ebt_core `ebt_settings` design layer), and core `body`.
- **One plugin**: field widget **`ebt_settings_columns`** in
  `src/Plugin/Field/FieldWidget/EbtSettingsColumnsWidget.php` (extends ebt_core's
  `EbtSettingsDefaultWidget`) — adds the layout + column-width form elements. See
  [fields/widget.md](fields/widget.md).
- **Two theme overrides** (`block--block-content--ebt-columns.html.twig`,
  `block--inline-block--ebt-columns.html.twig`) + library `ebt_columns/ebt_columns`
  (`css/styles.css`) that map layout/width classes to `grid-template-columns`. See
  [theming/templates.md](theming/templates.md).

## How it renders (from source)

The widget stores `layout` (1-6) and `column_width_two|three|four` into the `ebt_settings` map.
Each template reads those from `content.field_ebt_settings['#object'].field_ebt_settings.ebt_settings`
and merges `column-N` / `columns-X-Y` classes onto the wrapper, then prints
`{{ content|without('field_ebt_settings') }}` — so `field_ebt_columns_blocks` is rendered by the
block_field formatter (each referenced block keeps its own render/access). The trailing
`{{ styles|raw }}` is the design CSS produced by **ebt_core**'s `GenerateCSS` service, not by this
module.

## Solution docs

- [config/block-type.md](config/block-type.md) — install/enable, the bundle, fields, form & view
  displays, field_group tabs.
- [fields/widget.md](fields/widget.md) — the `ebt_settings_columns` widget: options, `#states`,
  `massageFormValues`.
- [theming/templates.md](theming/templates.md) — templates, library, the grid CSS class map.
