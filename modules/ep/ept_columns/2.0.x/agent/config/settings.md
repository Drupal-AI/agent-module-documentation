<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Columns — the `ept_columns` paragraph type, widget, and layout classes

## Install / enable
`drush en ept_columns -y` (pulls `ept_core` + `paragraphs`). On install the config below is imported,
creating the `ept_columns` Paragraphs bundle. There is **no settings form** in this module; the
site-wide EPT defaults (primary/secondary colors, mobile/tablet/desktop breakpoints) live on
`ept_core`'s configuration form. To use the type, add/enable a Paragraphs (entity_reference_revisions)
field on a node (or other entity) and allow the `ept_columns` bundle.

## Config shipped (config/install)
- `paragraphs.paragraphs_type.ept_columns` — bundle `id: ept_columns`, label
  `EPT Columns / Container`, no behavior plugins.
- `field.storage.paragraph.field_ept_columns` — `entity_reference_revisions`, `target_type:
  paragraph`, **cardinality -1** (unlimited), translatable. (The other three fields' storages —
  `field_ept_settings`, `field_ept_text`, `field_ept_title` — are provided by `ept_core`.)
- `field.field.paragraph.ept_columns.field_ept_columns` — the nested-paragraphs field: handler
  `default:paragraph`, `target_bundles: { ept_columns: ept_columns }` (so it nests EPT Columns and,
  in practice, any paragraph you allow via drag-drop), optional, label **Columns**.
- `field.field.paragraph.ept_columns.field_ept_settings` — `ept_settings` (shared design tab).
- `field.field.paragraph.ept_columns.field_ept_text` / `field_ept_title` — `text_long`, optional,
  `allowed_formats: {}` (any text format available to the editor).
- `core.entity_form_display.paragraph.ept_columns.default` — `field_group` **Tabs**:
  - **Content** tab (`group_content`): `field_ept_title` (text_textarea, 2 rows), `field_ept_text`
    (text_textarea, 5 rows), `field_ept_columns` (the `paragraphs` widget — `edit_mode: open`,
    `add_mode: dropdown`, `collapse_edit_all` + `duplicate` features).
  - **Settings** tab (`group_settings`, closed by default): `field_ept_settings` with widget
    **`ept_settings_columns`**.
- `core.entity_view_display.paragraph.ept_columns.default` — `field_ept_columns` via
  `entity_reference_revisions_entity_view` (view_mode `default`); `field_ept_settings` via
  `ept_settings_default`; `field_ept_text`/`field_ept_title` via `text_default`; all labels hidden.

## The layout widget — `EptSettingsColumnsWidget`
`src/Plugin/Field/FieldWidget/EptSettingsColumnsWidget.php`, `@FieldWidget(id =
"ept_settings_columns", field_types = {"ept_settings"})`, extends
`Drupal\ept_core\Plugin\Field\FieldWidget\EptSettingsDefaultWidget`.

`formElement()` = `parent::formElement()` (the shared design options) **plus** these four elements,
all keyed under `ept_settings`:

| key | #type | options / default | shown when |
|---|---|---|---|
| `layout` | radios | `1`..`6` (1 = "One column (Container)"), default `1` | always |
| `column_width_two` | select | `50-50`(def), `33-67`, `67-33`, `25-75`, `75-25` | `layout == 2` |
| `column_width_three` | select | `25-50-25`, `33-34-33`(def), `25-25-50`, `50-25-25` | `layout == 3` |
| `column_width_four` | select | `25-25-25-25`(def), `40-20-20-20`, `20-20-20-40` | `layout == 4` |
| `equal_height` | checkbox | default `1` | always |

Visibility is via Form-API `#states` (`:input[name$="[ept_settings][layout]"]` value 2/3/4). Five-
and six-column layouts have no width preset (equal columns only). `massageFormValues()` only ensures
each delta has an `ept_settings` array; it does no filtering. **All inputs are constrained
radios/selects/checkbox — there is no free-text layout/class/style field here.**

## Rendering — template classes and the CSS grid
`templates/paragraph--ept-columns--default.html.twig`:
- `{{ attach_library('ept_columns/ept_columns') }}`.
- Wrapper `<div>` classes: `paragraph`, `paragraph--type--ept-columns`,
  `ept-paragraph--type--ept-columns`, view-mode class, `ept-paragraph`, `ept-paragraph-columns`,
  `paragraph-id-<id>`, plus conditionally `column-<layout>`, `columns-<column_width_*>`, and
  `columns-equal-height` — each read from
  `content.field_ept_settings['#object'].field_ept_settings.ept_settings.*`.
- Optional heading from `field_ept_title` wrapped per the shared `title_options.title_wrapper`
  (`h1`-`h5`, `none`, or default `h2`); when `title_options.strip_tags` is set the rendered title is
  `striptags`'d to an allowlist. The title is rendered through its text format first
  (`content.field_ept_title|render`), so it is format-filtered markup.
- Body: `{{ content|without('field_ept_settings', 'field_ept_title') }}` — i.e. the nested
  `field_ept_columns` and `field_ept_text`, inside `.ept-container`.
- Ends with `{{ styles|raw }}` — the scoped inline `<style>.paragraph-id-N{…}</style>` that
  `ept_core`'s `GenerateCSS` assembles from `field_ept_settings` (margins/padding/border, background
  color/image, edge-to-edge, container width). This is `ept_core`'s output, not this module's.

`css/styles.css` (library `ept_columns/ept_columns`) turns the classes into a grid:
- `.ept-paragraph-columns .field--name-field-ept-columns { display:grid; grid-column-gap:15px;
  grid-row-gap:15px }`.
- `.column-2/3/4/5/6 …` set equal `grid-template-columns` (e.g. `1fr 1fr 1fr`), and each
  `.column-N.columns-<preset>` overrides with the ratio (`.column-2.columns-33-67 -> 1fr 2fr`,
  `.column-3.columns-25-50-25 -> 1fr 2fr 1fr`, `.column-4.columns-40-20-20-20 -> 2fr 1fr 1fr 1fr`,
  etc.). `.columns-equal-height` aligns row heights. Responsive collapse is handled by the CSS /
  ept_core breakpoints.

## Notes for agents
- Nesting: because `field_ept_columns` targets the `ept_columns` bundle (and whatever you enable on
  the field), columns can contain columns — build multi-row layouts by stacking column paragraphs.
- The module adds no behavior plugins, hooks, or services; layout is 100% CSS driven by the
  constrained class set above.
- To restyle, override `css/styles.css` or the template in your theme; to change gap/breakpoints,
  adjust the CSS or ept_core's responsive settings.
