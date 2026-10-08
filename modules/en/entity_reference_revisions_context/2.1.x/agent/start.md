<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Revisions Context (entity_reference_revisions_context) — agent index

One **field formatter** for `entity_reference_revisions` fields (e.g. **Paragraphs**). It renders each
referenced revision exactly like the parent ERR "Rendered entity" formatter, then adds `data-*`
attributes describing each item's position within the set. Package **Field types**. Depends on
**`entity_reference_revisions`**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.1.0.

- **The formatter, the attributes it emits, and how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EntityReferenceRevisionsEntityContextFormatter` (id
  **`entity_reference_revisions_entity_view_context`**, label *"Rendered entity with context"*), in
  `src/Plugin/Field/FieldFormatter/EntityReferenceRevisionsEntityContextFormatter.php`. It **extends**
  `entity_reference_revisions`'s `EntityReferenceRevisionsEntityFormatter` and implements
  `ContainerFactoryPluginInterface`. `field_types = { "entity_reference_revisions" }`.
- **No** config schema, **no** settings form of its own, **no** permissions, **no** routes, **no**
  services, **no** hooks, **no** Drush, **no** submodules. `composer.json` `require` is empty; the
  only dependency is the `entity_reference_revisions` module (info.yml).
- It changes only how an ERR field is **displayed**. Selected per view-display on *Manage display*.

## Mechanism (from source)

- `viewElements()` calls `parent::viewElements()` (so access filtering / view-mode rendering is done by
  the ERR core formatter), then loops the rendered `$elements` and calls three helpers per delta:
  `addPreviousElementContext()`, `addNextElementContext()`, `addPositionContext()`.
- Bundle lookup: `findElementBundle()` reads `$elements[$delta]['#' . target_type]->bundle()` (the
  `#{target_type}` entity the parent placed on each element).
- Attributes written into `$elements[$delta]['#attributes']`: `data-entity-context-first`,
  `data-entity-context-last`, `data-entity-context-prev`, `data-entity-context-next`,
  `data-entity-context-group`, `data-entity-context-position`, `data-entity-context-odd`,
  `data-entity-context-even`. See [fields/formatter.md](fields/formatter.md) for exact semantics.
