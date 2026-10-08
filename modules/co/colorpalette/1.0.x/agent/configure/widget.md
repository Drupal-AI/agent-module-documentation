# Color Palette — widget, vocabularies & routes

## Vocabularies (created at install, `config/install`)
- `colorpalette_colors` — one term per approved color. Fields: `field_colorpalette_hexcode` (rendered as a
  native `#type => color` input via `hook_form_FORM_ID_alter`, validated unique by
  `_colorpalette_validate_unique_color`) and `field_colorpalette_filter_tags` (entity_reference to filter
  tags). Only **published** terms appear in palettes.
- `colorpalette_filter_tags` — labels (Light, Dark, …) used to filter colors per field.

## The `colorpalette` field widget
Plugin id `colorpalette` (`FieldWidget`), `field_types = {entity_reference, string, text}`.
- Widget setting: `filter_tags` (entity_autocomplete, `#tags`, target bundle `colorpalette_filter_tags`).
  Schema: `field.widget.settings.colorpalette` → `filter_tags` sequence. Set on *Manage form display* (gear).
- `formElement()` renders a hidden `entity_autocomplete` (for entity_reference) or hidden `textfield` (for
  string/text) carrying `data-filter-tags`, `data-field-type`, `data-twig-suggestion=colorpalette`; attaches
  library `colorpalette/palette`.
- `colorpalette_theme_suggestions_input_alter` swaps in the `colorpalette_launch_button` template, building a
  launch link to the `colorpalette.colors` route with the field selector, type, filter tags, and current
  hexcode.

## Routes / forms

| Route | Path | Permission | Form | Does |
|---|---|---|---|---|
| `colorpalette.colors` | `/colorpalette/colors/{field_selector}/{field_type}/{filter_tags}/{js}` | `access content` | `ColorPaletteForm` | Renders the palette of published colors (filter tags cast to int, used in the term query). Clicking a swatch or Clear returns an AJAX response that writes the value into the field. Read-only server-side (submit is a no-op; AJAX only updates the DOM/field). Shows "New Color" link only to `administer palette` users. |
| `colorpalette.new_color` | `/colorpalette/new-color/{...}` | `administer palette` | `ColorPaletteNewColorForm` | Create a color (`#type => color` + name + filter tags) or, if the hexcode already exists, reuse it — publishing it if unpublished and merging filter tags — then apply it to the field via AJAX. |
| `colorpalette.reset_colorwise_confirm_form` | `/admin/structure/taxonomy/manage/colorpalette_colors/reset_colorwise` | `access content` | `CustomColorReset` | Confirm form that calls `resetColorWise()` to re-weight all Colors terms by HSV. |

A "Reset colorwise" submit button is also injected into the `colorpalette_colors` taxonomy overview form
(`colorpalette_form_taxonomy_overview_terms_alter`) when the vocabulary has >1 term and the user may reset
weights; it redirects to the confirm form above.

## Permission
- `administer palette` — "create new or apply any of the existing colors" (gates the New Color flow). This is
  the module's only defined permission.
