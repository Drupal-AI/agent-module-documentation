# BAT Options — agent index

Adds a `bat_options` field type for bookable add-ons/extras with Commerce-style price adjustments
(name + quantity + operation + value). Combined widget + three formatters + a render element. Depends
on `bat` + `commerce`. No config entities, permissions, or routes of note.

- **Field type, operations, widget, formatters, element** → [configure/field.md](configure/field.md)

Key facts:
- Field type `bat_options` (`BatTypeOptions`): columns `name`, `quantity`, `operation`, `value`, `type`.
- Price operations (`bat_options.module` constants / `bat_options_price_options()`): add, add-daily,
  sub, sub-daily, replace, increase (%), decrease (%), no_charge; plus optional/mandatory/on_request.
- Widget `bat_options_combined`; formatters `bat_options_default`, `bat_options_admin`,
  `bat_options_price`; render element `BatOption`.
- `bat_options_get_type_options(UnitType $type)` reads a type's `field_addons`.
