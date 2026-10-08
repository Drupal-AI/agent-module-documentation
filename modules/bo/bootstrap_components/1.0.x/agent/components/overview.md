<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SDC components — invocation, props, slots

All 21 components live at `components/<machine>/<machine>.component.yml` (metadata) + `<machine>.twig` (Bootstrap 5 markup). Machine id in Twig is `bootstrap_components:<machine>`.

## How to invoke
Render element:
```twig
{{ render({
  '#type': 'component',
  '#component': 'bootstrap_components:alert',
  '#props': { message: 'Saved', variant: 'success', dismissible: true },
  '#slots': { }
}) }}
```
Or from another template: `{{ include('bootstrap_components:button', { label: 'Go', variant: 'primary' }, with_context = false) }}`.

Component metadata is standard SDC: `variants:` (each becomes a CSS modifier), `slots:` (renderable content regions), `props: {type: object, properties: {...}}` (typed scalars). Most `*_attributes` props are typed `string` but the templates pass them through `create_attribute(...)`, so an associative array or an `Attribute` also works; scalars become a class string.

## Component reference (notable slots / props / variants)
- **accordion** — slot `content`; props `keep_open` (bool), `accordion_id`. Variants default, flush. Adds js/accordion.js (core/drupal, core/once).
- **accordion_item** — building block placed in `accordion.content`.
- **alert** — slots `heading`, `message`; props `variant` (primary…dark), `dismissible`, `heading_level`, `heading_attributes`, `attributes`. Emits `role="alert"`; includes `close_button` when dismissible.
- **blockquote** — quote with source alignment variants (start/center/end).
- **breadcrumb** — breadcrumb trail (stories: 1/2/3 items).
- **button** — slot `label`; props `disabled`, `label_visually_hidden`, `url`. Huge variant list: `{color}`, `{color}__sm`, `{color}__lg`, `outline_{color}`(+`__sm`/`__lg`) for primary/secondary/success/danger/warning/info/light/dark/link. Renders `<a>` when `url`/`attributes.href` set, else `<button type=button>`; `disabled` link gets `aria-disabled` + `.disabled`.
- **card**, **card_body**, **card_group**, **card_overlay** — card family. `card` slots image/header/content/footer; props `image_position`, `header_attributes`, `footer_attributes`, and (horizontal variant) `row_attributes`/`image_col_attributes`/`content_col_attributes` with Bootstrap defaults (`g-0`, `col-lg-4`, `col-lg-8`). Variants default, horizontal.
- **carousel** + **carousel_item** — slides; autoplay/captions variants; carousel JS.
- **close_button** — standalone `.btn-close`; prop `aria_label`/`visually_hidden_text`; dark/light variants. Used internally by modal & alert.
- **dropdown** — split/single button, directions, dark, header/divider menu content, responsive alignment, sizing variants.
- **modal** — slots `title`, `body`, `footer`; props `animation`, `static`, `centered`, `scrollable`, `fullscreen` (enum modal-fullscreen[-{bp}-down]), `heading_level` (1–6), `modal_id`, and `*_attributes` (wrapper/dialog/header/heading/body/footer). Variants sm/default/lg/xl. Auto-generates `modal-<random>` id and `aria-labelledby` when a title is set; includes `close_button` with `data-bs-dismiss=modal`.
- **nav** — tab/pill nav; alignment center/end/vertical, custom content variants.
- **navbar** + **navbar_nav** — responsive navbar: brand text/image, color, dark, offcanvas, scrolling, responsive/collapsible variants.
- **offcanvas** — placement, backdrop, body-scrolling, responsive, dark variants.
- **pagination** — sizing (small/large), alignment (center/end), states.
- **tooltip** — Bootstrap tooltip; ships a built `public/js/tooltip.js` + css bundle (source under `src/`).

## Rendering notes
Templates build classes/attributes with core `create_attribute(...)` and the module's `to_attributes` (see `api/to_attributes.md`); slots and prop values are emitted through normal Twig auto-escaping (no `|raw`). IDs default to `<component>-<random>()` when the `*_id` prop is empty. Each `*.component.yml` exposes a `libraryOverrides` map so a sub-theme can attach/override css/js without redefining the component.
