<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Bootstrap — SDC component catalog

All 16 components live under `components/<dir>/` as a `*.component.yml` (metadata + prop schema) plus
a `*.twig` template. They are core **Single Directory Components**; Canvas lists them under the
component group **"Canvas Bootstrap"**. Plugin id = `canvas_bootstrap:<name>` where `<name>` is the
`.component.yml` file's basename (NOT always the directory name — see Alert/Badge below). Twig
auto-escapes every prop; only Bootstrap utility-class strings and slot render arrays reach the markup.
The module ships no CSS framework — classes assume the active theme provides Bootstrap 5.

## Component reference (plugin id → dir → purpose → key props / slots)

- `canvas_bootstrap:accordion` — dir `accordion/` (name **"Accordion item"**). Collapsible item for
  use inside an accordion container. Props: `title`, `heading_level`, `item_id`, `accordion_id`,
  `open_by_default`, `custom_class`. Slot: `accordion_body`.
- `canvas_bootstrap:accordion-container` — dir `accordion-container/`. Wrapper grouping accordion
  items, optional `flush` style. Props: `attributes`, `accordion_id`, `flush`, `custom_class`.
  Slot: `accordion_content`.
- `canvas_bootstrap:canvas_bootstrap_alert` — dir `alert/`, file
  `canvas_bootstrap_alert.component.yml` (name **"Alert"**). Contextual feedback box. Props:
  `attributes`, `variant` (primary…dark), `heading`, `heading_level` (h2–h6), `dismissible`,
  `custom_class`. Slot: `alert_body`. Has a `canvas_bootstrap.ui_groups` block.
- `canvas_bootstrap:canvas_bootstrap_badge` — dir `badge/`, file
  `canvas_bootstrap_badge.component.yml` (name **"Badge"**). Inline label/count. Props: `attributes`,
  `text`, `variant`, `pill`, `visually_hidden_text`, `custom_class`. Has `ui_groups`.
- `canvas_bootstrap:blockquote` — dir `blockquote/`. Quote with optional footer/citation. Props:
  `attributes`, `text`, `footer`, `cite`, `alignment`, `italic`, `opacity`, `text_color`,
  `blockquote_class`, `footer_class`, `custom_class`. Has `ui_groups`.
- `canvas_bootstrap:button` — dir `button/`. Bootstrap button; renders `<a>` when `url` is set, else
  `<button>`. Required props: `text`, `variant`. Other props: `url` (uri-reference), `size`
  (default/sm/lg), `outline` (bool), `custom_class`.
- `canvas_bootstrap:card` — dir `card/`. Card with header/image/body/footer slots and extensive
  layout controls (orientation + justify/align per breakpoint, rounding, border/bg color). Slots:
  `card_header`, `card_image`, `card_body`, `card_footer`. Toggles: `show_header`/`show_image`/
  `show_footer`, `reverse_order`, `body_orientation[_sm..xxl]`. Has a multi-tab `ui_groups` block.
- `canvas_bootstrap:carousel` — dir `carousel/`. Slideshow. Props include `carousel_id`,
  `show_controls`, `show_indicators`, `slide_count`, `crossfade`, `dark_theme`, `ride`, `touch`,
  `wrap`, `keyboard`, `pause`, `custom_class`. Slot: `slides`. Has `ui_groups`.
- `canvas_bootstrap:carousel-item` — dir `carousel-item/`. A single slide for the carousel `slides`
  slot. Props: `attributes`, `active`, `interval`, `caption_heading`, `caption_text`,
  `custom_class`. Slot: `slide_content`. Has `ui_groups`.
- `canvas_bootstrap:column` — dir `column/`. Bootstrap column with per-breakpoint sizes. Props:
  `col`, `col_sm`, `col_md`, `col_lg`, `col_xl`, `col_xxl`, `custom_class`. Slot: `column`.
- `canvas_bootstrap:heading` — dir `heading/`. `<h1>`–`<h6>` heading. Props: `text`, `level`
  (h1–h6, default h2), `alignment`, `text_color`, `custom_class`.
- `canvas_bootstrap:image` — dir `image/`. Responsive `<figure>` image via Bootstrap ratio/rounding
  utilities; embeds core `canvas:image`. Props: `media` (object: src/alt/width/height), `size`
  (16:9 / 4:3 / 1:1), `width_class`, `height_class`, `radius`, `caption`, `url`, plus a large set of
  per-breakpoint `margin_*` / `padding_*` spacing props, `custom_class`. Has `ui_groups`.
- `canvas_bootstrap:link` — dir `link/`. Anchor with optional stretched-link / button styling. Props:
  `attributes`, `url`, `text`, `aria_label`, `target` (same→`_self`, new→`_blank` + adds
  `rel="noopener noreferrer"`), `stretched_link`, `as_button`, `button_variant`, `width_class`,
  `link_classes`, `button_classes`, `custom_class`. Has `ui_groups`.
- `canvas_bootstrap:paragraph` — dir `paragraph/`. `<p>` with spacing + text color. Props: `text`,
  `text_color`, the `margin_*` / `padding_*` spacing set, `custom_class`. Has `ui_groups`.
- `canvas_bootstrap:row` — dir `row/`. Bootstrap row with per-breakpoint gap and `row-cols`. Props:
  `gap[_x|_y][_sm..xxl]`, `row_cols[_sm..xxl]`, `custom_class`. Slot: `row`. Has `ui_groups`.
- `canvas_bootstrap:wrapper` — dir `wrapper/`. Generic container: chooses `html_tag`
  (div/section/article/aside/main/header/footer/nav), optional Bootstrap container, width/height,
  flex utilities, and full `margin_*`/`padding_*` spacing. Slot: `content` (required). Has `ui_groups`.

## Notes for an agent

- To render a component from your own Twig/render array outside Canvas, use the core SDC syntax, e.g.
  `{{ include('canvas_bootstrap:button', { text: 'Go', variant: 'primary', url: '/path' }) }}` or a
  `#type => 'component'` / `'#component' => 'canvas_bootstrap:button'` render element. Pass slots via
  the `#slots` key (or Twig `{% embed %}` blocks named after the slot, e.g. `card_body`).
- Overriding a component in a theme: give your theme an SDC with the **same machine name** (e.g.
  `mytheme:button`); the active theme's version then supersedes the module's inside Canvas (see
  [../hooks/form-and-discovery.md](../hooks/form-and-discovery.md)).
- All prop enums are Bootstrap utility-class tokens; free-text props (`custom_class`, `*_class`,
  `text`, `url`, `caption`, etc.) are editor-supplied and rendered through Twig auto-escaping.
