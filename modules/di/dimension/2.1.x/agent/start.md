# Dimension — agent index

Three **calculated** field types — Length, Area, Volume — where editors enter components
(width, height, …) and the module stores/renders the derived product. No config UI
(`configure: null`), no permissions, no Drush. Depends only on core `field`.

- **The field types, widgets, formatters, and the calculation model (factor/scale)** →
  [plugins/field-types.md](plugins/field-types.md)
- **Per-component field & storage settings (factor, min, max, prefix/suffix, precision, scale)** →
  [configure/field-settings.md](configure/field-settings.md)

Key facts:
- Field type ids: `length_field_type`, `area_field_type`, `volume_field_type`.
- Components: length → `length`; area → `width`, `height`; volume → `length`, `width`, `height`.
- Stored `value` = product of (component × its `factor`), rounded to `value_scale` (computed in
  `preSave()`).
- Formatters: `<t>_field_formatter` (computed value) and `area_components_field_formatter` /
  `volume_components_field_formatter` (raw components via Twig).
- Widgets extend core NumberWidget; a disabled live total uses the `dimension/widget` JS library.
