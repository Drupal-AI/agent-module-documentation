Dependent List lets one list field's available options be filtered by the value selected in another list field on the same entity, updating live via AJAX.

---

Dependent List adds conditional (cascading) behaviour to core list fields without a separate admin UI. You mark a list field as "dependent" in its field settings form: pick a parent list field on the same bundle, then, for each allowed parent value, check which of the child field's options should be shown. The mapping is stored as a `dependent_list` third-party setting on the child field's `FieldConfig` (a `parent_field` name plus a `value_map` of parent-value => allowed-child-keys). On any entity edit form the parent widget gets an `#ajax` change handler; when the parent value changes, `DependentListAjaxHandler::updateOptions()` rebuilds the child widget's options to just those allowed for the new parent value. It supports `list_string`, `list_integer` and `list_float` fields rendered as select, radios, or checkboxes, and is designed to keep working inside field groups, paragraphs, and deeply nested inline entity forms. Validation helpers make sure a value chosen through the filtered options is accepted (options are augmented before core's required/options checks) and that stale child values from a previous parent selection are dropped. Requires the core `options` and `field_ui` modules; there is no global configuration page and no permissions of its own.

---

- Show an "Event subtype" list only with the subtypes valid for the chosen "Event main type".
- Country -> region -> city style cascading selects on a content type.
- Filter a "Model" list by the selected "Manufacturer" on a product node.
- Restrict a "Sub-category" dropdown to the children of the picked "Category".
- Department -> team selection on a staff/person entity.
- Show relevant "Status reason" options based on a selected "Status".
- Limit "Ticket priority" choices depending on the selected "Ticket type".
- Cascade "Course" -> "Module" list fields on an enrolment form.
- Filter "Product option" checkboxes by a chosen "Product line".
- Constrain "Material" radios to those valid for a selected "Product family".
- Drive dependent lists inside a paragraph (e.g. a repeatable "specification" paragraph).
- Use dependent lists inside inline entity forms, including nested IEF rows.
- Show only the "Size" options that exist for a selected "Garment type".
- Filter a multi-value checkboxes field so editors can only pick allowed combinations.
- Present a radios child field whose options change when the parent radio changes.
- Keep taxonomy-free, config-driven conditional option lists (no reference fields needed).
- Reduce data-entry errors by hiding options that do not apply to the current parent value.
- Configure everything per field in Manage fields, with no code and no extra admin screen.
- Map many parent values to overlapping sets of child options via the checkbox matrix.
- Support integer- and float-keyed list fields, not just string lists.
- Automatically clear a previously chosen child value when it is no longer valid for the new parent value.
- Build guided, self-consistent forms where later choices narrow with earlier ones.
