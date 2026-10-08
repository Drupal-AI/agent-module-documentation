<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Columns / Container (ept_columns) — agent index

Paragraphs bundle **`ept_columns`** that lays other paragraphs out in a **1-to-6 column CSS grid**
(one column = a plain container/section), built on **`ept_core`** and **`paragraphs`**. Version
**2.0.0**. Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Maintainer: levmyshkin.

## What it actually is
- **One PHP class only:** a field widget, `EptSettingsColumnsWidget`, subclassing
  `ept_core`'s `EptSettingsDefaultWidget`. Everything else is Paragraphs bundle + field/display
  config, one Twig template, and one CSS file. No install/module hooks, no services.
- **Hard dependencies:** `ept_core:ept_core`, `paragraphs:paragraphs`. Config also pulls in
  `field_group` (form-display tabs), `entity_reference_revisions`, `text`.
- **No permissions, no routes, no `configure` link, no Drush, no config schema of its own.**

## Fields on the `ept_columns` bundle (config/install)
- **`field_ept_columns`** — `entity_reference_revisions` (Paragraphs), cardinality **-1**
  (unlimited), target bundle `ept_columns` itself. Holds the nested paragraphs. (Its own storage
  ships here: `field.storage.paragraph.field_ept_columns`.)
- **`field_ept_title`** — `text_long`, optional; rendered as a configurable heading in the template.
- **`field_ept_text`** — `text_long`, optional.
- **`field_ept_settings`** — `ept_settings` (from `ept_core`); the shared Design tab. Storages for
  title/text/settings come from `ept_core`, not this module.

## The layout widget (the only code)
`src/Plugin/Field/FieldWidget/EptSettingsColumnsWidget.php` (`@FieldWidget id =
"ept_settings_columns"`, for `ept_settings` field type). `formElement()` calls
`parent::formElement()` then adds:
- `ept_settings[layout]` — **radios** 1-6 (1 = "One column (Container)"), default 1.
- `ept_settings[column_width_two|three|four]` — **select** presets, each shown via `#states`
  only when `layout` == 2/3/4. Options: two = 50-50/33-67/67-33/25-75/75-25; three =
  25-50-25/33-34-33/25-25-50/50-25-25; four = 25-25-25-25/40-20-20-20/20-20-20-40.
- `ept_settings[equal_height]` — **checkbox**, default 1.

All four are constrained radios/selects/checkbox — no free-text — so the layout is a closed set of
values. `massageFormValues()` just ensures each item has an `ept_settings` key. See
`agent/config/settings.md`.

## Rendering (template + CSS)
- `templates/paragraph--ept-columns--default.html.twig` attaches `ept_columns/ept_columns`, builds a
  wrapper `<div>` with classes including `ept-paragraph-columns`, `column-<layout>`,
  `columns-<width-preset>`, and `columns-equal-height` (all derived from the constrained settings),
  prints an optional heading from `field_ept_title`, then the nested content
  (`content|without('field_ept_settings','field_ept_title')`), and ends with `{{ styles|raw }}` —
  the scoped inline `<style>` that `ept_core`'s `GenerateCSS` builds from `field_ept_settings`.
- `css/styles.css` maps the layout classes to `display:grid` + `grid-template-columns`
  (e.g. `.column-2.columns-33-67 .field--name-field-ept-columns { grid-template-columns: 1fr 2fr }`),
  and `.columns-equal-height` for equal rows. Declared in `ept_columns.libraries.yml`.

## Config shipped
- `paragraphs.paragraphs_type.ept_columns` — the bundle (no behavior plugins).
- Field instances + the `field_ept_columns` storage (above).
- `core.entity_form_display…default` — `field_group` **Tabs**: **Content** tab (title, text, the
  nested `field_ept_columns` Paragraphs widget) and **Settings** tab (`ept_settings_columns` widget).
- `core.entity_view_display…default` — nested paragraphs via
  `entity_reference_revisions_entity_view`; settings via `ept_settings_default`; title/text via
  `text_default` (labels hidden).

## Solution docs
- `agent/config/settings.md` — the bundle, fields, the `ept_settings_columns` widget options, form/
  view displays, template classes, and the CSS class-to-grid mapping.

## Relation to the EPT family
Same shape as other EPT paragraph types (`ept_block`, `ept_text`, …); all share `ept_core`'s design
settings and the `{{ styles|raw }}` scoped-style emission. The EBT family (`ebt_*`, incl.
`ebt_columns`) is the block-plugin equivalent.
