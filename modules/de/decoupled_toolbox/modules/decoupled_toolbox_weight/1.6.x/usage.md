Decoupled Toolbox for Weight adds a decoupled field formatter so weight fields can be exposed as JSON through Decoupled Toolbox.

---

A one-plugin sub-module of Decoupled Toolbox. It provides the `decoupled_weight` field formatter (class `WeightDecoupledFormatter`, extending `GenericDecoupledFormatter`) which you select on the **Decoupled** view mode for weight fields. `viewFieldItem()` casts the weight value to an integer (`(int) $item->getString()`). Requires the contrib module(s): `weight`. All the common decoupled formatter settings (decoupled field key, location, hide-if-empty, force-multiple) apply.

---

- Enable so weight fields appear with a decoupled formatter option on *Manage display → Decoupled*.
- Expose a weight field value in the `/decoupled-api/{type}/{bundle}/collection` JSON output.
- Rename the field to a clean API key via the Decoupled field key setting.
- Relocate the value in the JSON tree via the Decoupled field location setting.
- Omit the field when empty via the hide-if-empty setting.
