Entity Prepopulate (epp) prefills a field's value on an entity add/edit form from a token-enabled template stored as a third-party setting on the field, applying it at the entity level (not just the form) so it is robust and works with multi-property fields.

---

The module has no config entity, permission, plugin, or admin page. On each field's settings form (`field_config_edit_form` and `base_field_override_edit_form`) `epp_form_alter()` injects an "Entity Prepopulate" fieldset with two inputs: **Value** (a textarea holding a YAML string that may contain tokens) and **Also on update** (a checkbox). These are saved as third-party settings `epp.value` and `epp.on_update` on the field config; a form builder unsets them when both are empty. At form build time `epp_entity_prepare_form()` (an implementation of `hook_entity_prepare_form()`) iterates the entity's fields, and for any field carrying an `epp.value` it replaces tokens twice — once normally and once with `clear => TRUE` — and only proceeds if **every** token was resolved (the two results match). The resolved YAML is parsed (Symfony YAML), the value is set on the entity, and the entity is validated; if validation for that field fails the previous value is restored and a notice is logged. The prepopulation runs only when the entity **is new**, unless **Also on update** is enabled, in which case it also runs on edit. Because YAML is used, you can target individual field properties (e.g. `value:` and `format:` of a text field, or the components of a geofield/address). Installing the Token module adds a token browser link and richer token support; without it, basic core tokens still work.

---

- Prefill a new article's title from a token (e.g. include the current date in the default title).
- Set a default body text/format on new nodes without a custom module.
- Prepopulate a "source" or "campaign" field from the logged-in user's data via user tokens.
- Default a date field to a token-derived value on entity creation.
- Pre-fill multi-property fields (geofield, address, link) using YAML to target each property.
- Provide sensible defaults for a custom content entity's fields via field third-party settings.
- Set a default author/attribution string using the current user's name token.
- Prepopulate a taxonomy or text field on new media entities.
- Apply a default value only to new entities, leaving edits untouched (the default behaviour).
- Force a value to be (re)applied on every save by enabling "Also on update".
- Ship prepopulation as configuration by exporting the field's `third_party_settings.epp` keys.
- Default a "reference code" field to a computed token string on new orders/tickets.
- Keep prepopulation safe: values only apply when all tokens resolve and the value validates.
- Pre-fill a URL/link field with a tokenised default (e.g. site URL plus a path).
- Set a default value for a base field via a base field override's EPP settings.
- Give editors a starting point for structured text they can then edit.
- Populate hidden or admin-only fields with deterministic values at create time.
- Default a status or category text field on newly created entities.
- Use it as a lighter, entity-level alternative to the Prepopulate module for entity forms.
- Combine with the Token module's browser to discover and insert available tokens into the value.
- Prepopulate fields on user registration/edit forms (any fieldable entity form).
- Enforce a canonical default that reapplies on update (on_update) for compliance/labelling fields.
