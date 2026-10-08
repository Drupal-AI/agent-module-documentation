Decoupled Toolbox for Color Field adds a decoupled field formatter so color_field_type fields can be exposed as JSON through Decoupled Toolbox.

---

A one-plugin sub-module of Decoupled Toolbox. It provides the `decoupled_color_field` field formatter (class `ColorFieldDecoupledFormatter`, extending `GenericDecoupledFormatter`) which you select on the **Decoupled** view mode for color_field_type fields. Adds an RGBA-output setting; `viewFieldItem()` emits the colour as a lowercased hex string, or as an `rgb()`/`rgba()` string when RGBA output is enabled (via `ColorHex::toString()` / `toRgb()`). Requires the contrib module(s): `color_field`. All the common decoupled formatter settings (decoupled field key, location, hide-if-empty, force-multiple) apply.

---

- Enable so color_field_type fields appear with a decoupled formatter option on *Manage display → Decoupled*.
- Expose a color_field_type field value in the `/decoupled-api/{type}/{bundle}/collection` JSON output.
- Rename the field to a clean API key via the Decoupled field key setting.
- Relocate the value in the JSON tree via the Decoupled field location setting.
- Omit the field when empty via the hide-if-empty setting.
