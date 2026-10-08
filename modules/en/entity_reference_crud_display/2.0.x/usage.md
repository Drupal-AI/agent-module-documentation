<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference CRUD Display adds a field formatter that renders each referenced entity together with inline Create / Edit / Delete controls driven by AJAX modal forms.

---

The module solves the problem of editing referenced content without leaving the host entity page. Select the "Entity Reference CRUD Display" formatter on an entity-reference field's Manage display tab; on the rendered page each referenced entity is shown in a chosen view mode with Edit and Delete links, plus an Add button that builds a new target entity and links it back to the host through the same field. Edit/create forms are staged in a PrivateTempStore keyed by the target entity UUID so unsaved changes survive the AJAX round-trip before the final save.

Operationally the mutating routes are properly gated: edit, create, delete and delete-confirm use custom access callbacks that require `$entity_target->access('update'|'create'|'delete')` AND `$entity_parent->access('update')`, and edit/delete links only render when the same checks pass. The read-only view/cancel routes are gated only by the `access content` permission and render an arbitrary target entity in an arbitrary view mode without an explicit `view` access check (see security note in start.md). There is no module configuration form — everything is configured per field on the display settings.
---
- Enable inline CRUD on an entity-reference field via its Manage display formatter.
- Let editors add a new referenced entity from the host entity's view page.
- Edit a referenced entity in an AJAX modal without navigating away.
- Delete a referenced entity with a confirmation modal.
- Render each referenced entity in a specific view mode chosen in the formatter.
- Replace a Paragraphs-style inline workflow for simple reference fields.
- Keep unsaved edits in PrivateTempStore across the AJAX form load.
- Show Edit links only to users with update access to both host and target.
- Show Delete links only to users with delete access to the target.
- Cancel an in-progress create and restore the original display.
- Cancel an in-progress delete and restore the original display.
- Build management UIs for referenced child entities (e.g. line items).
- Configure the target bundle used when creating new entities.
- Use with any content entity type as the reference target.
- Wire the Add button back to the host field automatically on save.
- Provide a lightweight editorial surface for one-to-many relationships.
- Combine with view modes to present compact vs. full referenced entity displays.
- Limit editing surface to a single field on the host entity's display.
- Avoid custom controllers for simple referenced-entity editing.
- Give content authors a single-page create/edit/delete experience.
