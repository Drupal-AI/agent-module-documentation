<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Double Reference provides a field type where one field item stores two entity references — a primary reference (full entity-reference behaviour) and an "added reference" with most of the same options — so the pair acts as a single coupled field.

---

The field type (`DoubleReferenceItem`) extends core's `EntityReferenceItem`, adding an `ar_target_id`/`ar_entity` property pair and an `ar_target_type` storage setting; column type (int vs varchar) is derived from the added target entity type's ID definition. Field settings add a primary label, and an "added reference" group (label, allowed bundles, weight, required). Two widgets (`double_reference_autocomplete`, `double_reference_autocomplete_select`) extend the core autocomplete widgets, and a formatter (`double_reference_label`) extends `EntityReferenceLabelFormatter` to render both labels, each optionally linked to its entity. A Views data alter swaps the target-id filters to the entity-reference (or taxonomy index) filter, and an Entity Usage tracker plugin records both references.

Install it like any field module and choose "Double Reference" (Reference group) when adding a field; configure the added-reference target type at storage level and its bundles/label/weight/required at field level. The label formatter prints labels as `#plain_text` or as `#type => link`, so output is escaped by the render layer.

---

- Store two coupled entity references in a single field item.
- Pair a primary reference with a secondary "added" reference (e.g. term + node).
- Add a "Double Reference" field from the Reference category.
- Choose the added reference's target entity type at storage level.
- Limit the added reference to specific bundles.
- Label the primary and added references independently.
- Order the two references (added first or second) via weight.
- Make the added reference required or optional.
- Use the autocomplete or autocomplete-select widget for entry.
- Display both labels with the `double_reference_label` formatter.
- Optionally link the added reference's label to its entity.
- Reference nodes, terms, users, or any entity type for the second value.
- Filter on either reference in Views (entity-reference / taxonomy index filter).
- Track both references in Entity Usage reports.
- Model relationships that always come as a pair (e.g. product + variant).
- Keep the two IDs in sync automatically on save.