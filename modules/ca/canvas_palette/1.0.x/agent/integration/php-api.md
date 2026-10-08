<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Palette — PHP integration (hooks, services, route, base fields)

Almost all PHP is in `canvas_palette.module` (editor + rendering integration), plus a handful of
`src/` classes and `canvas_palette.install`. No permissions/config-form/schema/Drush.

## Install / enable

`ddev drush en canvas_palette -y` (deps `canvas`, `image`, `views`, `webform` must be present;
Composer installs the ~10 front-end libraries into `web/libraries/*`). `canvas_palette_install()`
installs the two Canvas-page base fields (see below); `canvas_palette_update_10001`/`_10002` install
them on existing sites. `canvas_palette_modules_installed()` re-runs `installOptionalConfig()` so the
shipped `config/optional/canvas.pattern.accordion.yml` pattern installs after Canvas has derived the
components it depends on. Uninstall (`canvas_palette_uninstall()`) removes both base fields and their
stored data.

## The one route

`canvas_palette.media_dimensions` (`canvas_palette.routing.yml`):
`GET /canvas-palette/media/{media}/dimensions`, `_format: json`, `{media}` upcast to `entity:media`,
`media: \d+`. Gated by `_permission: 'edit canvas_page'` (a Canvas permission — the module defines
none of its own). `Controller\ImageDimensionsController::dimensions()` returns
`{"width": int, "height": int}` — read from the media source field's stored width/height, falling
back to `@getimagesize()` on the managed file's realpath. Used by `js/image-dimensions.js` to
pre-fill the Image component's Width/Height props. (Media loaded by numeric id from an access-checked
route; no request-supplied path, no external fetch.)

## Twig extensions (`canvas_palette.services.yml` → `src/Twig/`)

- `CanvasPaletteImageStyleExtension::imageStyleUrl()` — Twig fn **`canvas_palette_image_style_url(src, style)`**.
  Recovers a `public://` URI from a rendered image URL (via `file_url_generator` + the public stream
  wrapper) and returns the image-style derivative URL; returns `src` unchanged for empty/unknown
  styles or non-public/external URLs.
- `CanvasPaletteViewsExtension::renderView()` — Twig fn **`canvas_palette_view(view_id, display_id='default', arguments=null)`**.
  Builds a `#type => view` render array; **checks `$view->access($display_id)`** and returns `[]` when
  the view/display is missing or access is denied. `arguments` is a `/`-separated string exploded into
  contextual-filter args.
- `CanvasPaletteWebformExtension` — Twig fns **`canvas_palette_webform(webform_id)`** (a `#type => webform`
  render array) and **`canvas_palette_webform_url(webform_id)`** (the form's canonical URL, for the
  popup's AJAX dialog link). Both tolerate an empty/unknown id.

## Service provider + SDC plugin-manager swap

`CanvasPaletteServiceProvider::alter()` swaps `plugin.manager.sdc` to
`Plugin\CanvasPaletteComponentPluginManager`, but **only if the current class is already Canvas's
`ComponentPluginManager`** (guards against Canvas dropping its own swap). The subclass's
`processDefinition()` injects `SECTION_MAX_CELLS = 36` `cell_N` slots into `canvas_palette:section`
(runtime-dynamic slots are blocked upstream; core fires no SDC-definition alter hook). Slot names/
titles are part of Canvas's component-version hash — changing the count forks a new version.

## Slot image defaults (`Render\SlotImageDefaults`, TrustedCallback)

`hook_element_info_alter()` prepends `SlotImageDefaults::preRender` to the core `component` render
element's `#pre_render` (ahead of `ComponentElement::preRenderComponent()`, before slots fold into
the inline template). For container components (`carousel`, `images`, `slider`, `image_gallery`,
`video_gallery`) it recursively back-fills each slotted `*_item` child's `image_style` (only when the
item set none — item wins) and forces its lightbox prop on when the container's is on (effective OR).

## Editor form restructuring (`hook_form_component_instance_form_alter`)

Acts only on `sdc.canvas_palette.*` components (read from the form's hidden `form_canvas_tree`).
`canvas_palette_move_style_prop_first()` gives the `style` prop `#weight -1000`. Per-component
handlers (`_section_inputs_form`, `_cta_inputs_form`, `_webform_popup_inputs_form`,
`_carousel_inputs_form`, `_slider_inputs_form`, `_modal_inputs_form`) group props into collapsible
`<details>` via `canvas_palette_group_props()`. Grouping uses **`#group`** (relocates at render time
only, leaving `#parents` — and thus submitted values — untouched); physically nesting would break the
mapping back to props. `canvas_palette_section_design_box()` nests the twelve margin/border/padding
props as an inspector-style box model (margin > border > padding > content), attaching the
`canvas_palette/design_box` library.

## Widget enhancements (`hook_field_widget_single_element_form_alter`)

Gated on `$form_state->get('is_canvas_static_prop_source')`, except the page-level
`canvas_palette_background_color` base field handled before the gate. It:

- attaches the **Coloris color picker** to any prop in `CANVAS_PALETTE_COLOR_PROPS` (binds via a
  `data-coloris` attribute so it survives Canvas's React re-renders; `canvas_palette/color_picker` →
  `canvas_palette/coloris`);
- converts `image_style` / `webform_id` / `view_id` text fields into **selects** of the entities on
  the site (stored value stays the machine name);
- turns bounded numeric props (`CANVAS_PALETTE_SLIDER_PROPS`) into **range sliders** (sets `#step`,
  attaches `canvas_palette/range_slider`);
- hides the Basic-button hover-color fields until "Custom hover colors" is checked (a CSS `:has()`
  rule via `canvas_palette/button_hover_visibility`, since React defeats `#states`);
- wires the custom container-width control (`canvas_palette/container_width`) and the Image
  Width/Height auto-fill (`canvas_palette/image_dimensions`).

## Whole-page settings for Canvas pages

`hook_entity_base_field_info()` adds two base fields to the `canvas_page` entity
(`Page::ENTITY_TYPE_ID`):

- **`canvas_palette_page_template`** — a `list_string` whose allowed values come from
  `canvas_palette_page_template_allowed_values()` (scans `templates/page/page--canvas--*.html.twig`,
  `$cacheable = FALSE`). `hook_theme()` registers one `page__canvas__<token>` suggestion per template
  (`'base hook' => 'page'`, so all page variables flow through);
  `hook_theme_suggestions_page_alter()` appends the chosen token's suggestion (plus a
  `…--custom` variant for theme overrides) so Drupal prefers `page--canvas--STYLE.html.twig`.
  `hook_block_access()` forbids the core `page_title_block` when a template is selected (varies by
  `route` cache context) so the auto `<h1>` does not duplicate the page's own heading.
- **`canvas_palette_background_color`** — a `string` (max 32) CSS color.
  `hook_preprocess_html()` paints it onto the `<body>` inline style **only** when it matches
  `/^(#[0-9a-fA-F]{3,8}|(?:rgb|hsl)a?\([0-9.,%\s\/]+\)|[a-zA-Z]+)$/` — a hex, `rgb()/rgba()`,
  `hsl()/hsla()`, or a keyword; anything containing quotes, semicolons or braces is rejected.

## Extension point (`canvas_palette.api.php`)

`hook_canvas_palette_page_templates_alter(array &$info)` — any module or theme can add, relabel or
remove a selectable page template. Each entry is keyed by a lowercase dash-separated **style token**
(→ stored value, `page--canvas--<token>.html.twig` filename, and `page__canvas__<token>` theme hook)
with `label`, optional `template`, and a `path` (relative to the Drupal root) that must resolve or the
entry is dropped. Overriding just the file — placing `page--canvas--<token>.html.twig` in a theme's
own templates dir — needs no hook.

## Editor JS injection

`hook_library_info_alter()` extends Canvas's `canvas/canvas-ui` library with
`canvas_palette/editor_layers` (the editor is a hand-built response, so `hook_page_attachments`
never runs for it — extending its UI library is the one reliable entry point).
