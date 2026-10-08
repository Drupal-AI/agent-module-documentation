<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reference Value Pair adds one field type, `reference_value_pair`, that stores an entity reference **and** a scalar text value together in a single field delta — the shape you need for "this ingredient, this quantity" or "this skill, this rating" — without the weight of a Paragraph or a dedicated referenced entity per row.

---

A plain entity reference field cannot carry data *about* the reference. The usual workarounds are a Paragraph type per row, or a bespoke entity with two fields — both correct and both heavy, adding entity types, forms, permissions and joins for what is conceptually a pair. This module makes the pair a field type: it extends core `EntityReferenceItem` and adds a required `value` column, so the reference half keeps full entity-reference behaviour (selection handlers, autocreate, `ValidReference` validation) while the value rides alongside. It ships two widgets — `reference_value_autocomplete_widget` (default) and `reference_value_select` — and a `reference_value_formatter` that prints the referenced entity's label and the value through a `reference-value-pair-formatter.html.twig` template (respecting entity access and offering an invalid-reference fallback label). `hook_field_views_data()` exposes both columns to Views with forward and reverse relationships, and a Feeds target maps both properties for import. The only dependency is core `field` (core `^10 || ^11`). The honest trade-off is that the value side is a scalar, not a fielded entity: it cannot be translated independently of the reference, carries no validation beyond length/field settings, and cannot be extended later without a data migration. Where those constraints hold, this is markedly simpler than the alternatives.

---

- Store a quantity alongside a referenced entity (e.g. term + "50").
- Model an ingredient plus an amount on a recipe node.
- Record a measurement with its unit taken from a taxonomy (50 liter, 20 cm, 80 %).
- Capture a skill and a proficiency level in one field.
- Attach a price to a referenced product option.
- Give a referenced team member a role within a single field.
- Avoid creating a Paragraph type for a simple pair.
- Filter a view by either half of the pair.
- Sort a listing on the scalar value component.
- Relate host and target entities via the field's Views relationship.
- Import pairs through the Feeds target.
- Reference any entity type by setting the field's `target_type`.
- Autocreate a referenced entity from the autocomplete widget.
- Pick the reference from a select list instead of autocomplete.
- Enforce that a value cannot be saved without a reference.
- Show a fallback label when a referenced entity has been deleted.
- Record a rating or score against a referenced item.
- Store a weight or ordering value per reference.
- Override the pair's markup with a Twig template suggestion.
- Reduce entity count versus a Paragraph-per-row model.
- Model a survey answer as question plus score.
- Attach a percentage to a referenced category.
- Report on pairs through Views without deltas drifting apart.
- Replace two parallel multi-value fields that risk misalignment.
