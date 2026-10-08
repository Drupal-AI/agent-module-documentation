Dimension provides three calculated field types — Length, Area, and Volume — that let editors enter component measurements (e.g. width and height) and automatically store and display the derived product (e.g. area = width × height).

---

The module defines three `@FieldType` plugins — `length_field_type` (component: length), `area_field_type` (width, height), and `volume_field_type` (length, width, height) — all extending core's `DecimalItem`. Each stores its raw component values plus a computed `value` column; on `preSave()` the `value` is calculated as the product of each component multiplied by that component's configurable **factor**, rounded to the configured scale (`calculate()`). Per-component **field settings** cover `factor`, `min`, `max`, `prefix`, and `suffix`, and per-component **storage settings** cover numeric `precision` and `scale`; component constraints (Regex for numeric input, Range for min/max) are enforced via `getConstraints()`. The matching widgets extend core's `NumberWidget` and render one number input per component plus a disabled, live-updating "Dimension" total powered by the `dimension/widget` JS library (`js/dimension.js`, using drupalSettings factors/scales). Formatters come in two flavours: the plain formatters (`length_field_formatter`, `area_field_formatter`, `volume_field_formatter`, extending `DecimalFormatter`) render the computed value with the value prefix/suffix, while the "Components" formatters (`area_components_field_formatter`, `volume_components_field_formatter`, extending `StringFormatter`) render the raw components through Twig templates like `{{ width }} x {{ height }}`. It has no configuration UI, permissions, or services — it depends only on core `field`, and requires PHP 8.1+.

---

- Store a product's area by entering width and height; the square area is computed automatically.
- Capture package volume from length × width × height for shipping calculations.
- Record a simple length/distance measurement with a Length field.
- Multiply components by a factor (e.g. cm → m) so the stored value is in a canonical unit.
- Display an area as "12 x 8" using the Area Components formatter.
- Show a volume's three components with the Volume Components template.
- Render the computed dimension with a unit suffix like " m²" or " L".
- Add a prefix/suffix to component inputs (e.g. "cm") on the entry form.
- Enforce a minimum/maximum on a component (e.g. height between 1 and 300).
- Give editors a live-updating total as they type width and height.
- Control decimal precision and scale of stored measurements per component.
- Use singular/plural prefix or suffix strings (e.g. "inch|inches").
- Build a furniture catalog with width/height/depth volume fields.
- Compute floor area for real-estate listings from entered dimensions.
- Keep derived measurements consistent by calculating them instead of trusting manual entry.
- Add a canonical `value` you can sort or facet on in Views (it is a stored decimal).
- Model fabric or material sizing where area drives pricing.
- Provide a length field with a conversion factor for imperial/metric normalisation.
- Show only components (not the computed total) using the Components formatters.
- Validate that component inputs are numeric via the built-in Regex constraint.
- Standardise measurement entry across content types with reusable dimension fields.
- Capture screen or canvas sizes (width × height) with automatic area.
- Support engineering/CAD-style data entry where a total is derived from parts.
