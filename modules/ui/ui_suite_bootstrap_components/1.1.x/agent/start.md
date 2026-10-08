<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Suite Bootstrap components (ui_suite_bootstrap_components) — agent index

**Opinionated Bootstrap 5 Single-Directory Components (button, card, features, header, hero, menu) plus an Icon API pack, for the UI Suite / UI Patterns / Display Builder ecosystem.**

- **Version:** 1.1.x (1.1.0)
- **Core:** `^10 || ^11 || ^12`
- **Package:** UI Suite
- **Type:** presentational SDC library — **no** PHP runtime, routes, services, permissions, config forms or hooks. Only PHP is a kernel test (`tests/src/Kernel/ComponentValidatorTest.php`, extends `sdc_devel`).
- **Dependencies:** none declared in `.info.yml`. `composer.json` `require-dev` = `ui_patterns ^2.0.16`, `ui_icons ^1.1`, `sdc_devel ^1.0.2`; `conflict: ui_suite_bootstrap <5.1`. The `header` and `menu` templates `include('ui_suite_bootstrap:...')`, so `ui_suite_bootstrap` >= 5.1 must be present for those two.

## Components (`components/<name>/<name>.component.yml` + `<name>.twig`)

- **button** — group *Button*. Bootstrap button/link with optional icon. Slot `label`; props `icon` (`ui-patterns://icon`), `icon_position` (before/after), `disabled`, `label_visually_hidden`, `url` (`ui-patterns://url`). ~60 colour/size/outline **variants** (`primary`, `outline_danger__lg`, `link__sm`, …). Renders `<a>` when a url is set, else `<button type="button">`. Stories: `button.icon_before`, `button.icon_after`.
- **card** — group *Card*. Variants `default` (horizontal) and `overlay`. Slots `image` (first only), `header`, `content`, `footer`. Attribute props `header_attributes`, `footer_attributes`, `overlay_attributes`, `row_attributes` (default `g-0`), `image_col_attributes` (`col-md-4`), `content_col_attributes` (`col-md-8`), and boolean `image_right`.
- **features** — group *Snippets*, `status: experimental`. Props `title`, `lead`, `variant` (columns/hanging/icon_grid), `column_count` (1–6, default 3); slot `items`. Ships `features.css`.
- **header** — group *Snippets*. Full navbar/site-header. Slots `logo`, `title`, `subtitle`, `navigation_collapsible`; props `items` (`ui-patterns://links`), `items_position`, `url` (brand link), `toggler_position`, `toggle_action` (collapse/offcanvas), `offcanvas_position`, `container`, `col_attributes`, plus expand-breakpoint variants. Delegates to `ui_suite_bootstrap:navbar`, `:navbar_nav`, `:grid_row_1`. Ships `header.css`.
- **hero** — group *Snippets*. Variants `default`, `default__dark`, `horizontal`, `horizontal__dark`. Slots `title`, `header`, `primary`, `secondary`, `buttons`; props `fluid`, `border`, `shadow`, `switch`. Stories under `components/hero/stories/`.
- **menu** — group *Navs and tabs*. Variants default/pills/pills__fill/pills__justified/underline. Prop `items` (`ui-patterns://links`); dropdown sub-items delegate to `ui_suite_bootstrap:dropdown`.

## Icons & config

- `ui_suite_bootstrap_components.icons.yml` registers two Icon API packs (`core`, `navigation`) via path/svg extractors (Drupal core logos + core navigation icons).
- `config/schema/ui_suite_bootstrap_components.schema.yml` provides `ui_icons.icon_pack_options.{core,navigation}` schema only — **no** module config object of its own.

## Security

Presentation-only module: no server-side code, routes, endpoints or credential handling. No Twig template uses `|raw`; all slot/prop output goes through standard autoescaping and the UI Patterns attribute/url/link APIs. Nothing to gate. **No security findings.**

## See also

- [extend/components.md](extend/components.md) — full component/prop/variant reference, consuming patterns, and the icon pack.
