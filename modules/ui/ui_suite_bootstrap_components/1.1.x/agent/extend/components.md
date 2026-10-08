<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Suite Bootstrap components — component & icon reference

All components are SDC: `components/<name>/<name>.component.yml` (metadata/props/slots) +
`<name>.twig` (markup). No PHP is involved in rendering. Install/enable:

```bash
composer require drupal/ui_suite_bootstrap_components
drush en ui_suite_bootstrap_components -y
```

`.info.yml` declares **no** module dependencies. In practice you use this with the UI Suite /
UI Patterns / Display Builder stack (`require-dev`: `ui_patterns ^2.0.16`, `ui_icons ^1.1`,
`sdc_devel ^1.0.2`), and the `header` / `menu` components require **`ui_suite_bootstrap` >= 5.1**
(composer `conflict: drupal/ui_suite_bootstrap <5.1`) because their Twig `include`s templates from it.

## button ("Button with icon") — group *Button*

`components/button/button.twig`. Renders an `<a>` when a `url` (or `attributes.href`) is present,
otherwise a `<button type="button">`.

- **Slot:** `label` (maxItems 1).
- **Props:** `icon` (`ui-patterns://icon`), `icon_position` (`before`|`after`, default `before`),
  `disabled` (bool), `label_visually_hidden` (bool → wraps label in `.visually-hidden`),
  `url` (`ui-patterns://url`).
- **Variants (~60):** built from `variant|split('__')` → each part becomes `btn-<part>` plus a base
  `btn` class. Colours `primary secondary success danger warning info light dark link`, their
  `outline_*` forms, and size suffixes `__sm` / `__lg` (e.g. `outline_danger__lg` → `btn btn-outline-danger btn-lg`).
  `default` adds **no** `btn` class.
- When an `icon` is set the button gains `d-inline-flex align-items-center gap-2` and the icon is
  emitted via the SDC `icon(pack_id, icon_id, settings)` function, placed before or after the label.
- `disabled`: on the link form sets `href=false`, `tabindex=-1`, `aria-disabled`, `.disabled`; on
  the button form sets the `disabled` attribute.
- Stories: `stories/button.icon_before.story.yml`, `stories/button.icon_after.story.yml`.

## card ("Card teaser") — group *Card*

`components/card/card.twig`. Two variants:

- **`default` (horizontal):** `.card` > `.row` (`row_attributes`, default `g-0`) with an image column
  (`image_col_attributes`, default `col-md-4`) and a content column (`content_col_attributes`,
  default `col-md-8`). `image_right: true` adds `order-md-last` to the image column. Defaults are
  applied in-template only when the attribute has no stored classes.
- **`overlay`:** `.card` with `{{ image|add_class('card-img') }}` and a `.card-img-overlay`
  (`overlay_attributes`) holding header/content/footer.
- **Slots:** `image` (first only), `header`, `content`, `footer`. Header/footer render inside
  `.card-header` / `.card-footer` (with `header_attributes` / `footer_attributes`) only when present.

## features ("Features") — group *Snippets* (`status: experimental`)

`components/features/features.twig`, ships `features.css`. Outer `.container.px-4.py-5`; optional
`<h2>` from `title` and `<p class="lead">` from `lead`; a grid of `items` (slot).

- **Props:** `title`, `lead`, `variant` (`columns`|`hanging`|`icon_grid`, default `columns`),
  `column_count` (int 1–6, default 3).
- Grid classes: default `row g-4 py-5 row-cols-1 row-cols-lg-<column_count>`; the `icon_grid`
  variant overrides to `row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4 py-5`.

## header ("Header") — group *Snippets*

`components/header/header.twig`, ships `header.css`. Builds a Bootstrap navbar wrapped in a grid row.
Delegates to `ui_suite_bootstrap:navbar`, `:navbar_nav`, `:grid_row_1` (so **requires ui_suite_bootstrap**).

- **Slots:** `logo`, `title`, `subtitle` (rendered together as `.navbar-brand`, optionally wrapped
  in `<a href="{{ url }}">`), `navigation_collapsible` (extra content, e.g. a search form, that
  collapses with the menu).
- **Props:** `items` (`ui-patterns://links`, the inline main menu via `navbar_nav`), `items_position`
  (`left`/`center`/`right` → `me-auto`/`mx-auto`/`ms-auto`), `url` (brand link), `toggler_position`
  (`start`/`end`/`none`), `toggle_action` (`collapse`/`offcanvas`), `offcanvas_position`
  (`start`/`end`, default `end`), `container` (Bootstrap container width, default `container-fluid`),
  `col_attributes`.
- **Variants:** `default`, `expand_sm`/`expand_md`/`expand_lg`/`expand_xl`/`expand_xxl` (passed through
  as the navbar's expand breakpoint). `navbar_id` defaults to `random()`.

## hero ("Hero") — group *Snippets*

`components/hero/hero.twig`. Two layouts selected by variant name (`'horizontal' in variant`), each
with a light/`__dark` form (`'dark' in variant` → `data-bs-theme="dark"`).

- **Slots:** `title`, `header`, `primary`, `secondary`, `buttons`.
- **Props:** `fluid` (bool → `container-fluid` vs `container`), `border` (adds `border rounded-3`),
  `shadow` (adds `shadow-lg`), `switch` (bool — centered: swap primary/secondary; horizontal: move
  text to the right).
- **Centered** (`default`/`default__dark`): title `<h2 class="display-4">`, primary in a centered
  column, optional CTA `buttons`, and `secondary` shown below in a capped-height container.
- **Horizontal** (`horizontal`/`horizontal__dark`): a two-column row, text (title `display-5`,
  primary, buttons) beside the `secondary` visual; `switch` flips the sides.
- Stories: `components/hero/stories/hero.{default,default_dark,horizontal,horizontal_dark}.story.yml`.

## menu ("Menu") — group *Navs and tabs*

`components/menu/menu.twig`. Renders `<nav class="nav ...">` iterating the `items` prop
(`ui-patterns://links`).

- **Variants:** `default`, `pills`, `pills__fill`, `pills__justified`, `underline`. Non-default variant
  parts become `nav-<part>` classes; any `pills` variant also adds `card-header-pills`.
- Each item → `.nav-item` / `.nav-link` (`href` from `item.url`; a `disabled` class also sets
  `aria-disabled`). Items with `item.below` render a dropdown via `ui_suite_bootstrap:dropdown`
  (so `menu` with sub-items also **requires ui_suite_bootstrap**).

## Consuming

- **UI Patterns / UI Suite / Display Builder / Layout Builder:** components are selected by their
  group and name in the UI; props/slots are filled from the UI (links, attributes, icons come from
  the matching UI Patterns sources).
- **Direct Twig / SDC:**
  `{{ include('ui_suite_bootstrap_components:card', { header: '…', content: '…' }) }}`.
- **CSS overrides:** every component declares a `libraryOverrides` fake library so a sub-theme can
  attach or override its styles (`features` and `header` ship their own `.css`).

## Icons (`ui_suite_bootstrap_components.icons.yml`)

Registers two Icon API packs, selectable wherever the Icon API / icon-picker is used:

- **`core`** — `extractor: path`; sources are the module's `icons/*.png` plus several Drupal.org
  logo PNGs, an external PHP logo SVG, and core logo/icon SVGs. Settings: `width`/`height`
  (default 32), `alt`, `title`; `<img>` template with `role="presentation"`/`aria-hidden` when alt
  is empty.
- **`navigation`** — `extractor: svg`; sources core Navigation module icons
  (`/core/modules/navigation/assets/icons/*.svg`). Settings: `size` (default 32), `class`; inline
  `<svg>` template.

`config/schema/ui_suite_bootstrap_components.schema.yml` defines `ui_icons.icon_pack_options.core`
and `…navigation` (typed config for those pack settings) — the module ships **no** config object of
its own and no settings form.
