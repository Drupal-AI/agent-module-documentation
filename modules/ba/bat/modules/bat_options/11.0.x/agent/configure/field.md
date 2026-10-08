# BAT Options — field type, operations, widget, formatters

## Field type `bat_options` (`BatTypeOptions`)

`@FieldType(id = "bat_options", default_widget = "bat_options_combined", default_formatter =
"bat_options_default")`. Multi-value; stored columns:

| Column | SQL | Meaning |
|---|---|---|
| `name` | varchar(255), NOT NULL | Option label (e.g. "Breakfast"). |
| `quantity` | int | Quantity available/applied. |
| `operation` | varchar(255) | Price operation (see below). |
| `value` | float | Amount / percentage for the operation. |
| `type` | varchar(255) | Availability/type (optional/mandatory/on request). |

`isEmpty()` treats an item as empty when `name` or `quantity` is empty.

## Price operations

From `bat_options.module` constants and `bat_options_price_options()`:

| Constant / value | Label |
|---|---|
| `BAT_OPTIONS_ADD` = `add` | Add to price |
| `BAT_OPTIONS_ADD_DAILY` = `add-daily` | Add to price per night |
| `BAT_OPTIONS_SUB` = `sub` | Subtract from price |
| `BAT_OPTIONS_SUB_DAILY` = `sub-daily` | Subtract from price per night |
| `BAT_OPTIONS_REPLACE` = `replace` | Replace price |
| `BAT_OPTIONS_INCREASE` = `increase` | Increase price by % |
| `BAT_OPTIONS_DECREASE` = `decrease` | Decrease price by % |
| `BAT_OPTIONS_NOCHARGE` = `no_charge` | No charge |

Availability/type modifiers: `BAT_OPTIONS_OPTIONAL` (`optional`), `BAT_OPTIONS_MANDATORY`
(`mandatory`), `BAT_OPTIONS_ONREQUEST` (`on_request`).

## Widget & formatters

- Widget `bat_options_combined` (`BatOptionsCombined`) — combined multi-row add/edit UI (attaches the
  `bat_options/options-widget` CSS library).
- Formatters: `bat_options_default` (`BatOptionsDefault`), `bat_options_admin` (`BatOptionsAdmin`),
  `bat_options_price` (`BatOptionsPrice` — renders the price effect using Commerce price).
- Render element `BatOption` (`src/Element/BatOption.php`) for use in custom forms; controller
  `BatOptions` (`src/Controller/BatOptions.php`).

## Resolving a type's options

`bat_options_get_type_options(\Drupal\bat_unit\Entity\UnitType $type)` returns the value of the type's
`field_addons` (statically cached). Attach a `bat_options` field (commonly `field_addons`) to a
`bat_unit_type` bundle to give each unit type its own extras.

Depends on Commerce because option values are applied as Commerce price adjustments.
