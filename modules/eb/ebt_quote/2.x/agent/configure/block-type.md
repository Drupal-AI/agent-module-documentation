# Block type, displays, styles, templates and where the inline styles come from

Everything visible in this module is imported at install from `config/install/` (plus one PHP widget) —
there is **no settings form and no route**. The component is a `block_content` bundle whose edit form is
split into two tabs; at render, two Twig wrappers branch on a chosen style, add the EBT container, and
pull in inline CSS built by `ebt_core`.

## Entity and fields

**Block content type `ebt_quote`** (`block_content.type.ebt_quote.yml`, label "EBT Quote",
`revision: 0`, description "Extra Block Type (EBT): Quote") carries four configured fields plus the base
`info` field:

| Field | Type | Notes |
|---|---|---|
| `info` | base "Block description" | `string_textfield` widget; on the **Content** tab. The block's admin label. |
| `body` | `text_with_summary` | **Required** (`field.field.block_content.ebt_quote.body.yml` → `required: true`), label "Quote", `display_summary: false`. Storage `field.storage.block_content.body` from core `text`. |
| `field_ebt_quote_author` | `text_long` | Not required, label "Quote Author" ("Company name, Persona name and job position"). |
| `field_ebt_quote_image` | `entity_reference` → `media` | Not required, label "Quote Image". Target bundle `image` only. |
| `field_ebt_settings` | `ebt_settings` | Storage/field type provided by `ebt_core`. Holds the design/background options **and** the chosen quote style. Widget `ebt_settings_quote` (see [../plugins/widget.md](../plugins/widget.md)). |

See [../fields/structure.md](../fields/structure.md) for each field's filtering, the `quote_image`
image style, and every `ebt_settings` design-option key.

## Form and view displays

- **Form display** `core.entity_form_display.block_content.ebt_quote.default.yml` uses `field_group` to
  build a horizontal-tabs group `group_tabs` with two tabs:
  - `group_content` — tab **"Content"**: `info`, `body` (`text_textarea_with_summary`, `rows: 9`),
    `field_ebt_quote_author` (`text_textarea`, `rows: 5`), `field_ebt_quote_image`
    (`media_library_widget`).
  - `group_settings` — tab **"Settings"**: `field_ebt_settings` via widget **`ebt_settings_quote`**.
  - Declares module deps `ebt_quote`, `field_group`, `media_library`, `text` — so **`field_group`,
    `media_library` and `text` must be enabled** for the module to install (they are absent from
    `ebt_quote.info.yml`, which lists only `ebt_core`).
- **View display** `core.entity_view_display.block_content.ebt_quote.default.yml`:
  - `field_ebt_quote_image` → `media_thumbnail` (label hidden) with image style **`quote_image`** and
    `image_loading: lazy`.
  - `body` and `field_ebt_quote_author` → `text_default` (labels **hidden**).
  - `field_ebt_settings` → `ebt_settings_default` (label **above**). Its formatter output is consumed by
    `ebt_core`'s preprocess to build CSS/JS; the template does not print the raw settings.
  - Requires modules `ebt_core`, `media`, `text`.

## The five styles

The chosen style is stored at `field_ebt_settings[0]['ebt_settings']['styles']` by the custom widget
(default `persona`). Both templates branch on it with `{% if … styles == '<key>' %}`:

| Style key | Library attached | Layout |
|---|---|---|
| `persona` (default) | `ebt_quote/persona` | Round persona image, quote+author in an offset card. |
| `company` | `ebt_quote/company` | Company logo image + quote/author block. |
| `persona_with_small_icon` | `ebt_quote/persona_with_small_icon` | Small round image beside the author, quote below. |
| `with_square_image` | `ebt_quote/with_square_image` | Quote/author beside a square image. |
| `with_frame_and_background_image` | `ebt_quote/with_frame_and_background_image` | Quote framed over a background image. |

Any unknown/empty style falls through to the `{% else %}` branch, which only `attach_library`s
`ebt_quote/persona` (no markup). Each library maps to one static component CSS file under `css/`
(`persona.css`, `company.css`, …) declared in `ebt_quote.libraries.yml`.

## Templates and theme-hook suggestions

Two Twig templates in `templates/`. They are **not** registered by this module directly — `ebt_core`'s
`EbtCoreHooks::themeRegistryAlter()` registers `block__block_content__ebt_quote` and
`block__inline_block__ebt_quote` pointing at these files, and `themeSuggestionsBlockAlter()` inserts the
matching suggestions.

- `block--block-content--ebt-quote.html.twig` (reusable / library blocks) and
  `block--inline-block--ebt-quote.html.twig` (Layout Builder inline blocks). Both:
  1. Build classes `block ebt-block ebt-block-<plugin_id|clean_class> block-<provider|clean_class>
     block-<plugin_id|clean_class> plugin-id-<plugin_id|clean_class> ebt-quote-<style>` — the
     inline-block variant also adds `block-revision-id-<configuration.block_revision_id>`. The
     `ebt-quote-<style>` class is what scopes the shipped component CSS.
  2. `{{ attach_library('ebt_quote/<style>') }}` for the matching branch.
  3. `<div{{ attributes.addClass(classes) }}>` → `.bg-inner` + `.ebt-container`.
  4. Optional `<h2{{ title_attributes }}>{{ label }}</h2>` (auto-escaped) when a label is shown.
  5. Print the fields in style-specific wrappers: `{{ content.field_ebt_quote_image }}`,
     `{{ content.body }}`, `{{ content.field_ebt_quote_author }}` (each is a render array from its
     configured formatter — the settings field is **not** printed).
  6. End with `{{ styles|raw }}` — see next section.

## Where `{{ styles|raw }}` comes from

`styles` is **not** produced here; it is set by `ebt_core`'s `hook_preprocess_block`
(`EbtCoreHooks::preprocessBlock`) for any block whose bundle starts `ebt_` and that has non-empty
`field_ebt_settings.design_options`. It calls `ebt_core.generate_css`
(`GenerateCSS::generateFromSettings($design_options, $block_class)`), which returns an inline
`<style>.<block_class>{ … } … </style>` string. Every value interpolated into that CSS (margins,
borders, padding, colours, radius, positions, container width) is passed through
`\Drupal\Component\Utility\Html::escape()`, and the box/colour inputs are validated numeric/hex in the
widget — so the `|raw` print is design CSS built from escaped, privileged-editor input, not arbitrary
markup. The same preprocess also attaches `drupalSettings.ebtCore` (breakpoints, parallax/background
video data) and libraries as needed.

## Install / uninstall

- `ebt_quote_requirements($phase == 'install')` returns a hard error unless a **Media type with id
  `image`** exists (message: "The EBT Quote needs to be created 'Image' Media type"). The shipped
  `config/install/…` referencing `media.type.image` assumes that type is present.
- `ebt_quote_update_9101` sets the block type description to "Extra Block Type (EBT): Quote" on existing
  sites (no-op if the type is absent).
- `ebt_quote_uninstall()` logs a status notice and **keeps** the `ebt_quote` block type and any existing
  blocks (so content is not lost); delete them manually under **Structure » Block layout » Custom block
  library** if you really want them gone.

## Place a quote block

Enable the module (with `ebt_core`, `field_group`, `media_library`, `media`, `text` present and a Media
"image" type existing), then add a block of type "EBT Quote" at `admin/content/block/add/ebt_quote`, or
drop an inline "EBT Quote" block into a **Layout Builder** section, or place a reusable block via
**Structure » Block layout**. Fill the **Content** tab (description, quote body, author, image), pick a
look and tune spacing/background/width on the **Settings** tab.
