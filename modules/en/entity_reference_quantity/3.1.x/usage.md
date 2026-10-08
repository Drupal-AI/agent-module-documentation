<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Quantity provides an entity-reference field type that stores an integer quantity alongside each referenced entity, plus autocomplete and select widgets and a label formatter that renders the quantity next to the referenced entity's title.

---

The field type `entity_reference_quantity` extends core's `EntityReferenceItem`, adding a `quantity`
integer property/column to the standard `target_id` (it reuses the core entity-reference storage,
selection handlers and `EntityReferenceFieldItemList`). Field settings add `qty_label` (label/placeholder
for the quantity input) and `qty_min` / `qty_max` bounds (defaults 0 and 999). Two widgets ship:
`entity_reference_quantity_autocomplete` (default — an entity autocomplete plus a number input) and
`entity_reference_quantity_select` (a select list of referenceable entities plus a number input,
rendered inline). The formatter `entity_reference_quantity_label` extends core's entity-reference label
formatter and outputs the quantity via a small configurable Twig template (default ` ({{ quantity }})`)
placed before/after the title, as a suffix, or in a data attribute. Everything else (target type,
target bundles, selection handler) is inherited from core entity reference, so it behaves like a normal
reference field that also happens to carry a per-reference count. There is no admin settings page and no
permissions; configuration is entirely per-field and per-form/view-display.

---

- Reference entities and record a quantity for each (e.g. products × count).
- Build a simple bill-of-materials or parts-list field without full Commerce.
- Attach ingredient quantities to a recipe's referenced ingredient terms/nodes.
- Store "N of this related item" on a node reference field.
- Use an autocomplete widget to pick a referenced entity and enter its quantity.
- Use a select-list widget for a fixed set of referenceable entities plus a quantity.
- Constrain the quantity with configurable min/max bounds per field.
- Give the quantity input a custom label/placeholder via `qty_label`.
- Display the referenced label with the quantity appended, e.g. "Widget (3)".
- Place the quantity before the title, after the title, as a suffix, or in a data attribute.
- Customise the quantity output markup with a Twig template setting.
- Reuse core entity-reference selection handlers (bundles, views) with an added quantity.
- Reference users, taxonomy terms, nodes or any entity type, each with a count.
- Support multi-value fields where each delta has its own quantity.
- Render quantities into markup for downstream styling via the data-attribute location.
- Migrate a plain entity_reference field to one that also tracks quantities.
- Track requested/allocated counts against referenced resources.
- Model "packages" that bundle multiple referenced items in specific amounts.
- Expose quantity data for theming without writing a custom formatter.
- Capture headcounts or seat counts against referenced events/sessions.
