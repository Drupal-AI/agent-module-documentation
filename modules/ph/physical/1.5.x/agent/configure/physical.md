# Configure — adding a physical field + widget

Physical Fields has **no module settings form, routes, or permissions**. You configure it
entirely by adding fields through the standard Field UI (or config/code). It provides two
field types:

| Field type id | Stores | Default widget | Default formatter |
|---|---|---|---|
| `physical_measurement` | one `number` + `unit` | `physical_measurement_default` | `physical_measurement_default` |
| `physical_dimensions` | `length` / `width` / `height` + shared `unit` | `physical_dimensions_default` | `physical_dimensions_default` |

## Add a measurement field (UI)

1. **Structure → (entity) → Manage fields → Add field.**
2. Pick **Measurement** (the `physical_measurement` type). Each measurement type is also
   exposed as its own preconfigured option (Weight, Length, Area, Volume, Temperature,
   Pressure) via `getPreconfiguredOptions()`.
3. **Storage setting** `measurement_type` (radios: area/length/temperature/volume/weight/
   pressure) fixes which unit set the field uses. It is locked once the field has data.
   Default is `length`.
4. Save. For **Dimensions**, choose the **Dimensions** field type instead (its unit set is
   always length units).

## Widget settings (`physical_*_default`)

Configured under **Manage form display**:

- `default_unit` — unit pre-selected on the form (defaults to the type's base unit).
- `allow_unit_change` — whether editors may change the unit; if off, the field is locked to
  the default unit. Default `TRUE`.
- `available_units` — checkboxes limiting which units appear; select none to show all.

## Formatter settings

Under **Manage display**, both default formatters expose one setting:

- `output_unit` — render the stored value converted to this unit.

## Config / schema

Settings live in the field/widget/formatter config (schema in
`config/schema/physical.schema.yml`): storage key `measurement_type`; widget keys
`default_unit`, `allow_unit_change`, `available_units`; formatter key `output_unit`.
These export with `drush config:export` like any field config. Storage columns:
`number` (numeric 19,6) + `unit` (varchar 255) for measurement; `length`/`width`/`height`
(numeric 19,6) + `unit` for dimensions.
