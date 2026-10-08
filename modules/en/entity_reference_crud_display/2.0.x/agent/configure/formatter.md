<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the CRUD Display formatter

1. Enable the module (no dependencies).
2. Go to the host entity's **Manage display** tab (e.g. `/admin/structure/types/manage/<bundle>/display`).
3. For an **entity reference** field, choose the format **Entity Reference CRUD Display**.
4. In the formatter settings pick the **view mode** used to render each referenced entity and the **target bundle** used when creating a new entity.
5. Save. On the entity view page each referenced item now shows Edit/Delete links and an Add button, all handled via AJAX modals.

Notes:
- Edit/create forms use `PrivateTempStore` collection `crud_form` keyed by the target entity UUID; the copy is committed on final save.
- Edit/Delete links render only when the viewer has `update`/`delete` on the target and `update` on the host entity.
- The generic view route only requires the `access content` permission; do not rely on it to hide entities the user otherwise cannot view.
