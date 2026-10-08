<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Type UI is the site-building interface for creating and managing annotation types.

---

Annotations Type UI adds the admin CRUD interface for `annotation_type` config entities — the bundles of the annotation content entity (editorial, technical, rules, or any custom category a site defines). It provides an add/edit form (`AnnotationTypeForm`), a delete confirmation form (`AnnotationTypeDeleteForm`, which warns that deleting a type deletes all its annotations), and a draggable, weight-ordered collection list builder (`AnnotationTypeListBuilder`); it wires the entity's form and route handlers in via `hook_entity_type_alter`. The collection is the module's `configure` route (`entity.annotation_type.collection`), gated by the base module's `administer annotation types`. Because the types themselves are stored by the base `annotations` module, this UI is optional and can be uninstalled once the types are defined. Depends on `annotations`.

---

- Create new annotation types (bundles of the annotation entity).
- Edit an annotation type's label and description.
- Set a type's ordering weight (shown first in forms/output).
- Reorder types with a draggable list.
- Delete an annotation type via a confirm form.
- Warn that deleting a type deletes all its annotations.
- Reach type management from the Annotations admin section.
- Gate type management behind `administer annotation types`.
- Provide the `configure` link for the module (collection route).
- Register the type entity's form/route handlers via hook_entity_type_alter.
- Let site builders define custom annotation categories.
- Surface add/edit action links (links.action.yml).
- Be uninstalled after types are defined (types persist in the base module).
- Support other submodules' per-type third-party settings on the edit form.
- Keep the annotation bundle set fully config-managed.
- Complement annotations (data) without duplicating storage.
