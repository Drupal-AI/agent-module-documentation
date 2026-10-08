Color Palette provides a field widget that lets editors pick from a curated set of pre-approved colors (managed as taxonomy terms) instead of a free-form color picker, optionally filtered per field by "filter tag" categories such as Light or Dark.

---

Installing the module creates two vocabularies: `colorpalette_colors` (each term is a color, storing a
`field_colorpalette_hexcode` value with a native HTML color input and a uniqueness validator) and
`colorpalette_filter_tags` (labels like Light/Dark used to group colors). The `colorpalette` field widget
applies to `entity_reference`, `string`, and `text` fields; on an entity form it renders a hidden input plus
a "launch" button (via a theme suggestion) that opens the palette in a modal. The palette itself is a
route/form (`colorpalette.colors`, permission `access content`) showing published colors filtered by the
field's configured filter tags; clicking a swatch writes the hexcode (or `"Label (tid)"` for entity-reference
fields) back into the field via an AJAX response, and a Clear button empties it. Users with the module's
`administer palette` permission also get a "New Color" action (route `colorpalette.new_color`) to create a
color on the fly or reuse/publish an existing one, merging filter tags. A taxonomy overview action adds a
"Reset colorwise" confirmation form that re-sorts the Colors vocabulary by HSV. The module provides a config
schema for the widget's `filter_tags` setting and ships default field/display config for both vocabularies.
It has no global settings page (`configure` is null).

---

- Restrict a field's color input to a pre-approved brand palette instead of any hex value.
- Manage the approved colors as taxonomy terms (add/edit/unpublish via the Colors vocabulary).
- Store a picked color as a hexcode string on a `string`/`text` field.
- Store a picked color as a taxonomy term reference on an `entity_reference` field.
- Filter which colors appear for a given field using filter-tag categories (e.g. Light-only).
- Group colors with tags like Light, Dark, Primary, Accent via the Filter Tags vocabulary.
- Give editors a modal swatch picker launched from a button next to the field.
- Let privileged users create a brand-new approved color on the fly while editing content.
- Reuse (and auto-publish) an existing color when an editor picks an already-defined hexcode.
- Enforce unique hexcodes so the same color isn't defined twice in the palette.
- Clear a previously selected color from a field with a Clear button.
- Show only published colors in the palette (unpublished colors are hidden).
- Search within the palette modal via the built-in search box.
- Apply the widget to node, user, taxonomy, media, or paragraph fields.
- Use the native HTML5 color input for entering new hexcodes.
- Re-sort the Colors vocabulary automatically into a color-wise (HSV) order.
- Gate on-the-fly color creation behind the `administer palette` permission.
- Merge field-level filter tags with tags chosen when creating a new color.
- Provide a consistent, governed color vocabulary shared across many content types.
- Keep editors on-brand by removing arbitrary color choices from the UI.
