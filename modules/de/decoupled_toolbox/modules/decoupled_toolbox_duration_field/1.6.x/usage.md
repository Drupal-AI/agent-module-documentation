Decoupled Toolbox for Duration Field adds a decoupled field formatter so duration fields can be exposed as JSON through Decoupled Toolbox.

---

A one-plugin sub-module of Decoupled Toolbox. It provides the `decoupled_duration_field` field formatter (class `DurationFieldDecoupledFormatter`, extending `GenericDecoupledFormatter`) which you select on the **Decoupled** view mode for duration fields. `viewFieldItem()` returns the field's `duration` property value (the ISO-8601 duration string), or NULL when empty. Requires the contrib module(s): `duration_field`. All the common decoupled formatter settings (decoupled field key, location, hide-if-empty, force-multiple) apply.

---

- Enable so duration fields appear with a decoupled formatter option on *Manage display → Decoupled*.
- Expose a duration field value in the `/decoupled-api/{type}/{bundle}/collection` JSON output.
- Rename the field to a clean API key via the Decoupled field key setting.
- Relocate the value in the JSON tree via the Decoupled field location setting.
- Omit the field when empty via the hide-if-empty setting.
