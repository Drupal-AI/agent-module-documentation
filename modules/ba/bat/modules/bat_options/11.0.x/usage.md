BAT Options adds a `bat_options` field type that stores bookable add-ons/extras with a name, quantity, price-adjustment operation and value — e.g. breakfast, parking, a cleaning fee — that modify a unit type's booking price. It integrates with Drupal Commerce pricing.

---

The `bat_options` field type (`BatTypeOptions`, `@FieldType id = "bat_options"`) stores columns
`name`, `quantity`, `operation`, `value`, and `type`. The `operation` is one of the module's price
operations — `bat_options_price_options()` defines *Add to price*, *Add to price per night*,
*Subtract*, *Subtract per night*, *Replace price*, *Increase/Decrease by %*, and *No charge*
(constants `BAT_OPTIONS_ADD`, `..._ADD_DAILY`, `..._SUB`, `..._REPLACE`, `..._INCREASE`, etc.), plus
availability modifiers *optional* / *mandatory* / *on request*. It ships a combined multi-value widget
(`bat_options_combined`) and three formatters — `bat_options_default`, `bat_options_admin`, and
`bat_options_price` (which renders the price effect) — a `BatOption` form element, and a
`BatOptions` controller. `bat_options_get_type_options(UnitType $type)` reads a unit type's
`field_addons` to resolve its options. Because pricing is expressed as Commerce price adjustments, the
module depends on `commerce` (and `bat`). Attach a `bat_options` field to a unit type (or its
`field_addons`) to let each type carry its own list of paid extras applied at booking time.

---

- Add a list of bookable extras/add-ons (breakfast, parking, spa) to a unit type.
- Store each option's name, quantity, price operation and value in one field.
- Add a fixed amount to a booking's price per option (*Add to price*).
- Add an amount per night/day for an option (*Add to price per night*).
- Subtract an amount from the price (per booking or per night).
- Replace the base price entirely with an option's value.
- Increase or decrease the price by a percentage.
- Mark an option as *no charge* (included).
- Mark an option as optional, mandatory, or on-request.
- Edit multiple options at once with the combined widget (`bat_options_combined`).
- Render options for guests with the default formatter (`bat_options_default`).
- Render options with price effects using the price formatter (`bat_options_price`).
- Render an admin-oriented view of options (`bat_options_admin`).
- Resolve a unit type's configured options via `bat_options_get_type_options()`.
- Integrate booking extras with Drupal Commerce pricing.
- Offer per-type add-on catalogs (each unit type has its own extras).
- Use the `BatOption` render element in custom forms.
- Build package/upsell pricing on top of BAT bookings.
- Apply percentage surcharges (e.g. peak-season markup) via the increase operation.
- Present mandatory fees (cleaning, resort fee) that always apply.
