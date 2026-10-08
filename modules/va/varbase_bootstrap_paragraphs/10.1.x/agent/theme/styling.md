# Theming & the per-paragraph styling mechanism

The visual layer is Twig templates + one preprocess + CSS libraries. No behavior plugins are defined
(every bundle's `behavior_plugins: {}`).

## `hook_preprocess_paragraph` (`varbase_bootstrap_paragraphs.module`)

Runs for every paragraph and populates a single `VBP` template variable (via the
`varbase_bootstrap_paragraphs__add_template_variable()` helper in `includes/helpers.inc`) with:

- **`VBP.background_image.url`** — from `bp_image_field` → its referenced media's
  `field_media_image` file. If `drimage_improved` is enabled, builds `/drimage/1600/0/{fid}/-/{ext}`;
  else if `drimage` is enabled, a Drimage edge-to-edge URL; otherwise no URL. Rendered as an inline
  `style="background-image: url(...)"`.
- **`VBP.bp_width.value`** — maps `bp_width` option to Bootstrap classes via `$width_map`:
  `tiny → col-md-4 offset-md-4 col-sm-8 offset-sm-2`, `narrow → col-md-6 offset-md-3 …`,
  `medium → col-md-8 offset-md-2`, `wide → col-md-10 offset-md-1`, `full → col-12`,
  `bg-edge2edge → bg-edge2edge col-12 p-0`. Default `col-12`.
- **`VBP.bp_classes.value`**, **`VBP.bp_gutter.value`** (bool), **`VBP.bp_title_status.value`** (bool)
  — passed through for the template to use.

## Templates (`templates/`)

`hook_theme()` registers `paragraph__default` plus per-bundle suggestions (`paragraph__bp_accordion`,
`bp_carousel`, `bp_tabs`, `bp_columns_two_uneven`, `bp_columns_three_uneven`, `bp_image`, `bp_modal`)
and field templates (`field__entity_reference_revisions`, `field__paragraph__bp_column_content`,
`field__paragraph__bp_image__image`), all with `base hook => paragraph`.

`paragraph--default.html.twig` is the pattern the others follow:
- attaches `vbp-default` + `vbp-colors` libraries;
- builds the outer `<div>` class list = `paragraph`, `paragraph--type--<bundle>`,
  `paragraph--view-mode--<mode>`, plus the `bp_background` class and each sanitised `bp_classes`
  token (`|striptags|lower` → split on space → `|clean_class`);
- adds a `.container` wrapper when a background/gutter is set, `bg-edge2edge`/`background-style` for
  background image/color;
- prints `bp_title` as `<h2 class="text-center">{{ paragraph_title|striptags }}</h2>` only when a
  title exists **and** `bp_title_status` is falsy;
- prints remaining content with `content|without(...)` excluding the styling fields.

All editor-supplied strings are escaped (`striptags`/`clean_class`) or run through Drupal's normal
field render pipeline (text fields honor their text format); the background-image URL derives from a
managed file URI, not raw input.

## Libraries (`varbase_bootstrap_paragraphs.libraries.yml`)

| Library | What |
|---|---|
| `vbp-default` | Base CSS (`css/base/vbp-default.base.css`), depends on `core/jquery`. |
| `vbp-default-admin` | Admin CSS + `js/vbp-scripts.admin.js` (colors radio-label preview); attached by the widget/form alters. Depends on `core/drupal`, `core/jquery`, `core/drupal.debounce`, `vbp-colors`. |
| `vbp-colors` | The `background_colors` classes (`css/theme/vbp-colors.theme.css`). Override in your theme to rebrand. |
| `vbp-accordion` / `vbp-carousel` / `vbp-image` / `vbp-modal` / `vbp-tabs` | Per-component CSS, attached by the matching template. |

SCSS sources live in `scss/`; compiled CSS is what ships. To restyle the color options, override the
`vbp-colors` library in your own theme (see [../configure/settings.md](../configure/settings.md)).
