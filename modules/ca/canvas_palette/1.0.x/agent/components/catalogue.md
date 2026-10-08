<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Palette — component catalogue & conventions

Every component lives in `components/<id>/` as `<id>.component.yml` + `<id>.twig` + optional
co-located `<id>.css` / `<id>.js`. Canvas derives a versioned Component config entity
`sdc.canvas_palette.<id>` from each. They are placed and edited in the Canvas editor.

## The component convention

- SDC auto-generates the asset library `core/components.canvas_palette--<id>` from the co-located
  CSS/JS. **`core/drupal` is injected only when the component declares `libraryOverrides`** — so any
  component whose JS uses `Drupal.behaviors`/`once`, or needs a third-party lib
  (e.g. `canvas_palette/glightbox`), must list it under `libraryOverrides.dependencies`.
- The **variant selector** is one enum string prop, named `style` on most components
  (labelled Style / Columns / Layout). The Twig interpolates it verbatim into a BEM modifier —
  `class="cp-<comp> cp-<comp>--{{ style }}"` — and the CSS keys on `.cp-<comp>--<value>`. There is
  no per-style Twig/JS branching. `canvas_palette_move_style_prop_first()` floats `style` to the
  top of the editor form (see [../integration/php-api.md](../integration/php-api.md)).
- **Container + item** pairs use static SDC slots: a container component holds child `*_item`
  components (Carousel/Carousel item, Tabs/Tabs item, Image gallery/Image gallery item, Sticky
  menu/link/sublink, Stats/Stats item, Counter/Counter item, Tiles/Tiles item, Timeline/Timeline
  item, Slider/Slider item, Images/Images item, Video gallery/Video gallery item, Accordion/
  Accordion section).

## Component list (top-level, from `components/`)

- **Design & layout:** `section` (the design wrapper — see below), `columns`, `text`.
- **Buttons / CTA:** `basic_button`, `cta` (image + up to two styled buttons), `hero`,
  `modal` (accessible dialog, no library), `webform_popup` (opens a webform in a dialog).
- **Media:** `image` (caption/link/lightbox), `images` (grid), `image_gallery` (GLightbox),
  `video` (poster), `video_gallery` (YouTube/Vimeo/MP4/local, GLightbox).
- **Interactive / sliders:** `accordion`, `tabs` (no jQuery), `carousel` (tiny-slider),
  `slider` (Splide), `sticky_menu`.
- **Content / data:** `quote`, `stats`, `counter` (countUp.js), `countdown`, `tiles`, `timeline`.
- **Site integrations:** `webform` (embed a form), `views` (embed a view display).
- **Item children:** `carousel_item`, `slider_item`, `tabs_item`, `accordion_section`,
  `images_item`, `image_gallery_item`, `video_gallery_item`, `stats_item`, `counter_item`,
  `tiles_item`, `timeline_item`, `sticky_menu_link`, `sticky_menu_sublink`.

## Section — the design wrapper

`section` carries spacing/background/border/layout so other components stay content-only. Wrap any
component (or a group) in a Section to add: margins & paddings (edited as a DOM box), background
image (position/size/repeat), background video (loop/mute/cover/mobile fallback), background color,
two-stop gradients, background slideshow, overlays with opacity, borders (per-edge width, style,
colour, radius), and a **CSS grid (up to 6×6) or flexbox** layout.

- Section needs many child cell slots, but Canvas blocks runtime-dynamic slots and core fires no
  SDC-definition alter hook. Workaround: `CanvasPaletteServiceProvider` swaps `plugin.manager.sdc`
  to `Plugin\CanvasPaletteComponentPluginManager`, whose `processDefinition()` injects
  `SECTION_MAX_CELLS = 36` (6×6) `cell_N` slots into `canvas_palette:section`. Changing that count
  changes slot names and **forks a new Canvas component version** — keep it in lock-step with the
  `grid_columns`/`grid_rows` maxima in `section.component.yml` and the render loop in `section.twig`.
- `section.twig` interpolates the design values into inline `style="…"` attributes (autoescaped by
  Twig) and a `design.style()` macro; grid takes precedence over flex when both are enabled.

## Shared "Colorful" / "Eyebrow" conventions

Several components (Text, CTA, Carousel, Tabs, Slider…) share a **`colorful`** `style` value and an
optional **`eyebrow`** kicker string, matching a landing-page design system. Because that system's
CSS custom properties are not present on the front end, the Colorful CSS inlines resolved token
values (brand `#7333e5`, tint `#ede8fa`, text `#241a3d`/`#786a9c`, radii, shadows). Eyebrow renders
as `<span class="cp-<comp>__eyebrow">` inside a `.cp-<comp>__header` wrapper. Preview-only editor
chrome is gated on Canvas's `canvas_is_preview` Twig flag (emits a `cp-<comp>--preview` modifier that
never reaches published pages); `window.frameElement?.dataset?.canvasPreview === 'true'` is the
JS-side equivalent (used to skip slider/carousel init inside the editor).

## Extending the kit (external modules/themes) — see `styles.md`

- **Add CSS/JS to an existing component's style:** `hook_library_info_alter()` on the
  `core/components.canvas_palette--<id>` library.
- **Add a new editor-selectable style variant:** SDC **component replacement** (`replaces:` in your
  own component's `.component.yml`), since core has no `hook_component_info_alter()`.
- **Add/relabel a whole-page template:** `hook_canvas_palette_page_templates_alter()`
  (see [../integration/php-api.md](../integration/php-api.md)).

## Canvas component-versioning gotchas (from the module's own CLAUDE.md/TROUBLESHOOTING.md)

- Editing a `*.component.yml` does **not** live-update the active version: new props/enum values
  appear on newly placed instances and after a hard editor reload; existing instances keep their
  pinned version, and `drush cr` still reports the old schema.
- **Additive changes are safe** (new enum value, new optional prop). **Changing an existing prop's
  field *type* is not** — it throws `LogicException` and disables the whole component (it vanishes
  from the editor). Revert the type, regenerate via
  `ComponentSourceManager::generateComponents()`, and re-enable the component entity if disabled.
