# Color Palette (colorpalette) — agent index

Field widget for picking from curated, taxonomy-managed colors. Installs two vocabularies
(`colorpalette_colors`, `colorpalette_filter_tags`) and a `colorpalette` widget for `entity_reference` /
`string` / `text` fields. Palette opens in a modal; picks are applied via AJAX. No global config page
(`configure` null). One permission: `administer palette`. Provides a config schema.

- **The widget, vocabularies, filter tags, the palette/new-color/reset routes & forms** →
  [configure/widget.md](configure/widget.md)
- **`colorpalette.utility` service methods (colors CRUD, AJAX response, HSV reset)** →
  [api/service.md](api/service.md)

Key facts:
- Widget plugin id `colorpalette` (`FieldWidget`); source `field.widget.settings.colorpalette` schema key is
  `filter_tags` (sequence of filter-tag entity references).
- Routes: `colorpalette.colors` (palette, perm `access content`), `colorpalette.new_color` (perm
  `administer palette`), `colorpalette.reset_colorwise_confirm_form` (perm `access content`).
- New/reuse color logic creates or publishes a `colorpalette_colors` term and merges filter tags; hexcode
  uniqueness enforced via `_colorpalette_validate_unique_color`.
