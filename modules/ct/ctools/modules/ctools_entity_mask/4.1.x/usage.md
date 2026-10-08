Entity Mask lets one content entity type "borrow" the fields, form, and view display configuration of another entity type by declaring a `mask` on its entity annotation.

---

`ctools_entity_mask` is a developer submodule of Chaos Tools for people building custom content entity types. Instead of re-declaring fields and re-creating form/view displays for a new entity type, you point the new type at an existing one via a `mask` key on the entity type definition; the module then copies the masked type's display modes and configurable field definitions onto your entity. It provides a `MaskContentEntityStorage` (a storage handler for mask entities) and a `MaskEntityTrait` that dual-purposes the entity's UUID as its canonical id, because mask entities are often not persisted to the database like normal content entities. Display-mode syncing happens through `ctools_entity_mask_copy_display_modes()`, hooked into `hook_entity_view_mode_info_alter()`. There is no UI and no configuration screen — everything is driven from your entity type's PHP annotation/definition. It has no dependency on the base ctools module and supports Drupal 9.5, 10, and 11. This is a niche, code-only tool aimed at module developers who want lightweight entity types that mirror another type's field UI.

---

- Give a custom entity type the same fields as `node` without redefining them.
- Reuse another entity type's form and view display configuration.
- Build a lightweight, non-persisted entity that mirrors an existing type.
- Share display modes between a mask type and the type it masks.
- Use a UUID as the entity id for an in-memory entity via `MaskEntityTrait`.
- Prototype a new content entity type by borrowing an existing field UI.
- Create a "virtual" entity that shows another type's fields in Manage Display.
- Avoid duplicating field storage definitions across similar entity types.
- Attach the `MaskContentEntityStorage` handler to a custom entity type.
- Keep a derived entity type's display in sync when the masked type changes.
- Let editors configure fields once and reuse them on a masked type.
- Build ephemeral entities that are computed rather than stored.
- Back a JSON/preview entity with the field definitions of a real content type.
- Reduce boilerplate when defining families of related entity types.
- Mirror a media or paragraph type's field configuration onto a custom type.
- Provide a masked type for a headless/computed content model.
- Enable Manage Fields / Manage Display UIs on an otherwise code-defined type.
- Copy configurable field definitions from the masked type at runtime.
- Support developer experiments with entity types without migrations.
- Standardize display-mode handling for a set of mask entity types.
