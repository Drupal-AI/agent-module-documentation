# Block type, displays, templates and where the inline styles come from

Everything in this module is imported at install from `config/install/` — there is **no settings form
and no route**. The component is a `block_content` bundle whose edit form is split into two tabs; at
render, two Twig wrappers add the EBT container and pull in inline CSS built by `ebt_core`.

## Entity and fields

**Block content type `ebt_text`** (`block_content.type.ebt_text.yml`, label "EBT Text", `revision: 1`)
carries two configured fields plus the base `info` field:

| Field | Type | Notes |
|---|---|---|
| `info` | base "Block description" | `string_textfield` widget; on the **Content** tab. The block's admin label. |
| `body` | `text_with_summary` | **Required** (`field.field.block_content.ebt_text.body.yml` → `required: true`; also set by `ebt_text_update_9101`). Storage `field.storage.block_content.body` from core `text`. `display_summary: false`. |
| `field_ebt_settings` | `ebt_settings` | Storage/field type provided by `ebt_core`. Holds the design/background options. Widget `ebt_settings_default` (see [../fields/structure.md](../fields/structure.md)). |

See [../fields/structure.md](../fields/structure.md) for the WYSIWYG body's filtering and every
`ebt_settings` design-option key.

## Form and view displays

- **Form display** `core.entity_form_display.block_content.ebt_text.default.yml` uses `field_group` to
  build a horizontal-tabs group `group_tabs` with two tabs:
  - `group_content` — tab **"Content"**: `info` (weight 0), `body` via `text_textarea_with_summary`
    (weight 1; `rows: 9`, `summary_rows: 3`, `show_summary: false`).
  - `group_settings` — tab **"Settings"**: `field_ebt_settings` (weight 2) via widget
    `ebt_settings_default`.
  - Declares module deps `ebt_core`, `field_group`, `text` — so **`field_group` and `text` must be
    enabled** for the module to install (they are absent from `ebt_text.info.yml`).
- **View display** `core.entity_view_display.block_content.ebt_text.default.yml`:
  - `body` → `text_default` (label **hidden**).
  - `field_ebt_settings` → `ebt_settings_default` (label **hidden**). The settings field is present in
    the render array but the template removes it from printed content (see below); its formatter output
    is otherwise consumed by `ebt_core`'s preprocess to build CSS/JS.

## Templates and theme-hook suggestions

Two Twig templates in `templates/`. They are **not** registered by this module directly — `ebt_core`'s
`EbtCoreHooks::themeRegistryAlter()` registers `block__block_content__ebt_text` and
`block__inline_block__ebt_text` pointing at these files, and `themeSuggestionsBlockAlter()` inserts the
matching suggestions.

- `block--block-content--ebt-text.html.twig` (reusable / library blocks) and
  `block--inline-block--ebt-text.html.twig` (Layout Builder inline blocks). Both:
  1. Build classes `block ebt-block ebt-block-<plugin_id|clean_class> block-<provider|clean_class>
     block-<plugin_id|clean_class>` — the block-content variant also adds
     `plugin-id-<plugin_id|clean_class>`, the inline-block variant also adds
     `block-revision-id-<configuration.block_revision_id>`.
  2. `<div{{ attributes.addClass(classes) }}>` → `.bg-inner` + `.ebt-container`.
  3. Optional `<h2{{ title_attributes }}>{{ label }}</h2>` (auto-escaped) when a label is shown.
  4. `{% block content %}{{ content|without('field_ebt_settings') }}{% endblock %}` — prints the body
     but **omits** the settings field.
  5. Ends with `{{ styles|raw }}` — see next section.

## Where `{{ styles|raw }}` comes from

`styles` is **not** produced here; it is set by `ebt_core`'s `hook_preprocess_block`
(`EbtCoreHooks::preprocessBlock`) for any block whose bundle starts `ebt_` and that has a non-empty
`field_ebt_settings.design_options`. It calls `ebt_core.generate_css`
(`GenerateCSS::generateFromSettings($design_options, $block_class)`), which returns an inline
`<style>.<block_class>{ … } … </style>` string. Every value interpolated into that CSS (margins,
borders, padding, colours, radius, positions, container width) is passed through
`\Drupal\Component\Utility\Html::escape()`, and the box/colour inputs are validated numeric/hex in the
widget — so the `|raw` print is design CSS built from escaped, privileged-editor input, not arbitrary
markup. The same preprocess also attaches `drupalSettings.ebtCore` (breakpoints, parallax/background
video data) and libraries as needed.

## Install / uninstall

- No `hook_requirements`, no update path beyond `ebt_text_update_9101` (sets `body` required on
  existing sites).
- `ebt_text_uninstall()` logs a status notice and **keeps** the `ebt_text` block type and any existing
  blocks (so content is not lost); delete them manually under **Structure » Block layout » Custom block
  library** if you really want them gone.

## Place a text block

Enable the module (with `ebt_core`, `field_group`, `text` present), then add a block of type "EBT Text"
at `admin/content/block/add/ebt_text`, or drop an inline "EBT Text" block into a **Layout Builder**
section, or place a reusable block via **Structure » Block layout**. Fill the **Content** tab
(description + WYSIWYG body) and tune spacing/background/width on the **Settings** tab.
