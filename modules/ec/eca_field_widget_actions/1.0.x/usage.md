ECA Field Widget Actions lets an ECA model power a Field Widget Actions button, computing a field's value on demand when the button is clicked.

---

This module bridges the ECA (Events, Conditions, Actions) engine to the Field Widget Actions module. Field Widget Actions adds action buttons to field widgets on entity edit forms; this module registers one ECA-backed action per enabled ECA model that uses its "ECA Field Widget" event. When a user clicks the button, the event fires with the entity being edited, the field name and the field index (delta) as context, the model runs its conditions and actions, and the "Set field widget value" action returns the result. The value is either offered in the Field Widget Actions suggestions dialog or, if "Fill the field directly" is enabled on the button, written straight into the widget: text and CKEditor widgets receive a string, select lists and checkbox/radio groups receive a value list, and compound fields (Address, Link, Smart Date, Custom Field) receive a mapping of the field's property names and have their widget rebuilt from the entity. It depends on the ECA module and the Field Widget Actions module, and needs no configuration of its own beyond the ECA models and the button settings on "Manage form display".

---

- Add a "Suggest" button next to a text field that returns AI-generated copy.
- Fill a field directly from an ECA model without showing the suggestions dialog.
- Offer a list of suggested values a user can pick from for a text field.
- Populate a select list from an external data lookup via an ECA model.
- Populate a checkbox or radio group with a computed list of option values.
- Fill an entity-reference select with computed entity IDs (not labels).
- Fill an Address field by returning a country_code / locality / postal_code mapping.
- Fill a Link field by returning a uri / title mapping.
- Fill a Smart Date or Date range field via a compound property mapping.
- Fill a Custom Field (custom_field) with a mapping of its configured columns.
- Fill a multi-value compound field with a YAML list of property mappings.
- Compute a field value from the entity's other already-entered field values.
- Restrict a model to only text/editor widgets using the "Restrict by widget kind" event setting.
- Restrict a model to only select-list widgets, or only checkbox/radio widgets.
- Scope a model to compound fields only so it is offered on Address, Link, etc.
- Leave a model unrestricted so it is offered on every field widget.
- Use ECA tokens ([node:title], [entity:field_x:0:value]) inside the returned value.
- Build no-code, per-button automations on entity forms without writing PHP.
- Look up geocoding or address data and pre-fill an address widget from it.
- Suggest taxonomy terms or tags for a Tagify select widget.
- Return a comma-separated string that the module splits into a multi-value option list.
- Trigger different ECA logic per field by cloning a model with a distinct event.
- Add several ECA buttons to one field, each backed by a different model.
- Prototype AI-assisted content editing entirely through ECA models.
