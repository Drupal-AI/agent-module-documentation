# bootstrap_layouts — configure

The module ships **no admin form, route, permission or default config** (`configure` is `null`).
You configure a Bootstrap layout wherever you pick it — a Layout Builder section, a Display Suite
layout, or a Panels/Page Manager variant. The settings are stored by that consumer (LB section
config, DS third-party settings under `ds`, or a Panels variant), not by this module.

## The layouts it registers (`bootstrap_layouts.layouts.yml`)

Category **Bootstrap**, `type: partial`, all using class `BootstrapLayoutsBase`:

| Layout id | Regions (default class) |
|---|---|
| `bs_1col` | main (`col-sm-12`) |
| `bs_1col_stacked` | top, main, bottom (all `col-sm-12`) |
| `bs_2col` | left, right (`col-sm-6`) |
| `bs_2col_stacked` | top, left, right, bottom |
| `bs_2col_bricked` | top, top_left, top_right, middle, bottom_left, bottom_right, bottom |
| `bs_3col` | left, middle, right (`col-sm-4`) |
| `bs_3col_stacked` | top, left, middle, right, bottom |
| `bs_3col_bricked` | top + top_{left,middle,right} + middle + bottom_{left,middle,right} + bottom |
| `bs_4col` | first, second, third, fourth (`col-sm-3`) |
| `bs_4col_stacked` | top, first…fourth, bottom |
| `bs_4col_bricked` | top + top_{first…fourth} + middle + bottom_{first…fourth} + bottom |

"stacked" adds full-width top/bottom bands; "bricked" interleaves full-width bands between
column rows.

## Per-layout and per-region settings (config form on `BootstrapLayoutsBase`)

For the **layout** container and for **each region** you can set:

- **Wrapper** element: `div`, `span`, `section`, `article`, `header`, `footer`, `aside`, `figure`.
- **Classes** — a grouped multi-select built by `BootstrapLayoutsManager::getClassOptions()`:
  - *Columns*: `col-{xs,sm,md,lg}-{1..12}` — e.g. `col-md-8`, `col-lg-4` to set widths per breakpoint.
  - *Hidden* / *Visible*: `hidden-{xs,sm,md,lg}`, `visible-{xs,sm,md,lg}`.
  - *Background*: `bg-{primary,danger,info,warning,success}`.
  - *Text color*: `text-{primary,danger,info,warning,success,muted}`.
  - *Text alignment*: `text-left|right|center|justify|nowrap`.
  - *Text transformation*: `text-lowercase|uppercase|capitalize`.
  - *Utility*: `clearfix`, `row`.
- **Additional attributes** — comma-separated `key|value` pairs, e.g. `id|hero,role|banner,data-bs-x|y`.
  Passed through `Xss::filter()`; token-replaced if the **Token** module is enabled.
- Layout-only: **Add layout specific class** checkbox → adds e.g. `bs-1col` to the container
  (default on). The container defaults to classes `['row']` and wrapper `div`.
- Region-only: **Add region specific classes** checkbox → adds `bs-region` and
  `bs-region--{region}` (default on).

Config is stored as `layout.{wrapper,classes,attributes,add_layout_class}` plus
`regions.{name}.{wrapper,classes,attributes,add_region_classes}`. There is no drush config to set;
values live in the display/section entity you edit in the UI. A Bootstrap-based theme (or one
providing `.row`/`.col-*`) is required for the classes to render visually.
