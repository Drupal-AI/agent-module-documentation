Inline Entity Form (IEF) provides field widgets that let editors create, edit, and remove referenced entities directly inside the parent entity's form, instead of jumping to separate add/edit pages.

---

IEF targets the classic parent → children relationship (for example order → line items, or a product → its variations), where the child entities are only ever managed through the parent. It ships two entity-reference field widgets: **Simple** (single referenced entity, embedded inline) and **Complex** (multiple entities shown in a drag-sortable table with add-new and add-existing controls). You choose a widget on the reference field's *Manage form display* tab and configure it — the child entity **form mode**, whether new and/or existing entities are allowed, singular/plural labels, revision creation, collapsible behavior, and what happens to an entity when its reference is removed. Under the hood IEF registers an `inline_form` entity handler for every entity type and exposes a reusable `inline_entity_form` render element (`#type`) that developers can drop into any custom form. Widgets support `entity_reference` and `entity_reference_revisions` fields, so it pairs naturally with Paragraphs-style structures. Alter hooks let modules and themes tweak the embedded entity form, the "add existing" reference form, and the columns of the IEF table. A migration helper adapts D7 inline-entity data during upgrades. It is a foundational content-modeling building block used by Drupal Commerce and many content-heavy sites.

---

- Manage order line items inline from the order edit form.
- Edit product variations directly on the product form (Drupal Commerce).
- Build a parent node that owns a set of child nodes edited in one place.
- Embed a single referenced entity with the Simple widget on a form.
- Show multiple referenced entities in a sortable table with the Complex widget.
- Let editors create brand-new referenced entities without leaving the page.
- Let editors attach existing entities via an autocomplete "Add existing" form.
- Reorder referenced entities by drag-and-drop to control their weight/delta.
- Choose a specific form mode for the embedded child entity form.
- Override singular/plural labels shown on IEF buttons and messages.
- Prevent adding new entities (reference-existing-only workflows).
- Prevent referencing existing entities (create-only workflows).
- Collapse the inline form into an expandable details element to save space.
- Control whether removing a reference keeps or deletes the child entity.
- Force removal to always delete, always keep, or let the editor decide.
- Create a new revision of the child entity when it is saved inline.
- Use IEF with `entity_reference_revisions` fields for Paragraph-like nesting.
- Add an `inline_entity_form` render element to a custom form in code.
- Access the built entity in submit callbacks via `$form['x']['#entity']`.
- Allow duplicating an existing referenced entity in the Complex widget.
- Alter the embedded entity form fields with a hook.
- Alter the "add existing" reference/autocomplete form with a hook.
- Add or reorder columns in the IEF table via the table-fields alter hook.
- Restyle the referenced-entities table by overriding its Twig template.
- Migrate Drupal 7 inline entity data during an upgrade with the migration helper.
- Prevent duplicate references being added to the same field.
- Model deeply nested content (parent with children that have their own children).
