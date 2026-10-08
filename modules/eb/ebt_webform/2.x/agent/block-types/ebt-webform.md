<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "EBT Webform" block type

## Install & enable

```bash
composer require drupal/ebt_webform
drush en ebt_webform -y
```

Dependencies (`ebt_webform.info.yml`): `ebt_core`, `paragraphs`, `webform`. EBT Core uses the
Media module (Media *Image* type) for background images — create that media type first if you
plan to use background images. There is **no settings route for this module**; the only
configuration form in the family is EBT Core's, at
*Administration » Configuration » Content authoring » Extra Block Types (EBT) settings*
(`ebt_core.settings`: primary/secondary colors, mobile/tablet/desktop breakpoints, container
widths). Those apply to every EBT block by default.

## What enabling creates (config/install)

A `block_content` bundle **`ebt_webform`** (`block_content.type.ebt_webform.yml`, label
*"EBT Webform"*) with three fields:

| Field | Machine name | Type | Notes |
|---|---|---|---|
| Form | `field_ebt_webform_form` | `webform` (entity reference to `webform`) | **Required**, cardinality 1. The webform to embed. |
| Text | `body` | `text_with_summary` | Optional intro copy; summary display off. |
| Block settings | `field_ebt_settings` | `ebt_settings` (from ebt_core) | Shared EBT design options. |

Field storage `field.storage.block_content.field_ebt_webform_form.yml` targets `webform`,
`translatable: true`, `cardinality: 1`. `ebt_webform.install` provides update
**`ebt_webform_update_9101()`**, which loads `FieldConfig::loadByName('block_content',
'ebt_webform', 'field_ebt_webform_form')` and calls `setRequired(TRUE)->save()` so upgraded sites
get the required Form field.

### Form display (`core.entity_form_display…default`)

- `field_ebt_webform_form` → widget **`webform_entity_reference_select`** (settings
  `default_data: true`, `webforms: {}`), weight 28.
- `body` → `text_textarea_with_summary`, weight 26.
- `field_ebt_settings` → widget **`ebt_settings_default`** (from ebt_core), weight 29.
- `info` (block description) → `string_textfield`.

### View display (`core.entity_view_display…default`)

- `field_ebt_webform_form` → formatter **`webform_entity_reference_entity_view`**
  (`source_entity: true`), weight 2, label hidden. This is Webform's own renderer, so the form's
  own access, handlers and confirmation apply unchanged.
- `body` → `text_default`, weight 0.
- `field_ebt_settings` → formatter `ebt_settings_default`, weight 3 (but hidden from markup by
  the template, see below).

> If the **Field Layout** module is on, it auto-applies Layout Builder to new block types;
> disable Layout Builder for this bundle's display at
> `/admin/structure/block/block-content/manage/ebt_webform/display/default` so the fields render
> normally (per the module README).

## How it renders (templates + ebt_core)

Two templates, `templates/block--block-content--ebt-webform.html.twig` (placed/reusable blocks)
and `block--inline-block--ebt-webform.html.twig` (Layout Builder inline blocks), are registered
for the bundle by ebt_core's `theme_registry_alter`. Both:

- Build a `.block .ebt-block .ebt-block-<plugin_id> …` class list.
- Wrap output in `<div class="bg-inner">` + `<div class="ebt-container">`, print `label` in an
  `<h2>`, then render `{{ content|without('field_ebt_settings') }}` — so the raw settings field
  is **not** printed; only the webform and body show.
- End with `{{ styles|raw }}`.

`styles` is produced by ebt_core's `EbtCoreHooks::preprocessBlock()` for any `ebt_*` block that
has a non-empty `field_ebt_settings['design_options']`. It calls the **`ebt_core.generate_css`**
service (`Drupal\ebt_core\Services\GenerateCSS::generateFromSettings($design_options,
$block_class)`), which returns a string like
`<style>.<block_class>{ …rules… } …global rules… </style>`. Inside that service the design-option
values are sanitized before concatenation — e.g. margins/padding/border widths, border color,
border style, border radius, background color, container-width class and custom
background-position/size all go through `Html::escape()`, overlay RGB via `hexdec()`, overlay
alpha via `floatval()`. `preprocessBlock()` also:

- attaches `drupalSettings.ebtCore` breakpoints and, if a `spacing` option is set, adds that class
  and the `ebt_core/ebt_styles` library;
- adds `ebt-edge-to-edge` / `ebt-width-<name>` classes when those options are set;
- hands background parallax/video options to `ebt_core.generate_js` and attaches the relevant JS
  libraries.

## Operating notes

- **Choosing the form:** edit the block, pick a webform in the required *Form* select, optionally
  add *Text*, and set design options under *Block settings*. Place via Layout Builder, the block
  layout, or reuse as an inline/reusable custom block.
- **Access:** creating/editing these blocks is governed by core block-content / Layout Builder
  permissions; the embedded webform enforces its own access and submission handling. This module
  adds no permissions and no access logic of its own.
- **No config schema here:** the `ebt_settings` schema (`field.value.ebt_settings`, the
  `ebt_core.settings` object) is defined in **ebt_core**, not in this module.
- The `description` in `block_content.type.ebt_webform.yml` reads "Extra Paragraph Type (EPT):
  Webform" — a copy-paste label from the EPT sibling; cosmetic only.
