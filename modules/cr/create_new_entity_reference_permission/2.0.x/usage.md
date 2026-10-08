<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Create New Entity Reference Permission adds a dedicated permission that controls whether a user is allowed to create brand-new referenced entities on the fly from an entity-reference autocomplete field.
---
Core's entity-reference autocomplete widget, when the field is set to "Create referenced entities if they don't already exist", lets any user with field edit access type a new value and have a new target entity auto-created. This module ships a replacement widget, `entity_reference_autocomplete_permissions_widget` ("Autocomplete (with new entity permission)"), that extends the core widget and, in `formElement()`, **unsets** the `#autocreate` element for users who lack the `create new autocomplete entity reference` permission.

The effect is restrictive, not permissive: it takes the always-on core autocreate behaviour and hides it behind a permission (declared with `restrict access: TRUE`). Users without the permission simply get a normal autocomplete that can only reference existing entities. To use it, switch the field's form-display widget to the new widget and grant the permission to trusted roles only. Note the gate is at the widget/form layer — the underlying create still relies on the field's autocreate configuration, so pair the widget with the permission grant rather than exposing the field to untrusted roles.
---
- Restrict which roles may auto-create new referenced entities inline.
- Replace the core autocomplete widget with the permission-aware one.
- Grant "Create new autocomplete referenced entity" to trusted editors only.
- Prevent low-trust authors from spawning new taxonomy terms via a reference field.
- Prevent inline creation of referenced nodes/users by unauthorized roles.
- Keep autocomplete working for existing-entity selection for everyone.
- Configure per field via Manage form display.
- Combine with the field's "create if not exists" setting.
- Audit which roles hold the restricted permission.
- Lock down free-text term creation on curated vocabularies.
- Offer inline creation to admins while denying it to contributors.
- Apply the widget to any entity_reference field type.
- Revert by switching back to the stock autocomplete widget.
- Review that referenced-entity create access is still enforced elsewhere.
- Curate which reference fields allow inline entity creation at all.
- Document per-role which fields permit new-entity autocreate.