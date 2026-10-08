<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference CRUD Display (entity_reference_crud_display) — agent index

**Provides an entity-reference field formatter with inline AJAX Create/Read/Update/Delete of referenced entities.**

- **Version:** 2.0.x
- **Core:** ^10 || ^11
- **Package:** 7Links
- **Configuration:** none; set the "Entity Reference CRUD Display" formatter on an entity-reference field under Manage display.
- **Key routes:** `entity_reference_crud_display.view_entity`, `.new_entity_form`, `.edit_entity_form`, `.delete_entity`, `.delete_confirm`, `.cancel_entity` — all AJAX (`nojs|ajax`), controller `EntityReferenceCrudDisplayController`.
- **Plugin:** `EntityReferenceCrudDisplayFormatter` (field formatter). Uses `tempstore.private` (`crud_form`) to stage edits.
- **Security:** mutating routes (create/edit/delete) use custom access callbacks requiring `access('create'/'update'/'delete')` on the target AND `update` on the parent — sound. The read-only `view_entity`/`cancel` routes are gated only by `_permission: access content` and render an arbitrary target entity + view mode without a `view` access check (`EntityReferenceCrudDisplayController::buildEntityView`, line 651) — potential info disclosure.

See [configure/formatter.md](configure/formatter.md)
