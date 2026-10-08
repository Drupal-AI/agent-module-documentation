<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create New Entity Reference Permission (create_new_entity_reference_permission) — agent index
**Gates the entity-reference autocomplete "autocreate" feature behind a permission via a replacement field widget.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Permission:** `create new autocomplete entity reference` (`restrict access: TRUE`).
- **Widget:** `entity_reference_autocomplete_permissions_widget` — "Autocomplete (with new entity permission)"; extends core `EntityReferenceAutocompleteWidget` and unsets `#autocreate` when the user lacks the permission (`src/Plugin/Field/FieldWidget/EntityReferenceAutocompletePermissionsWidget.php`).
- **Routes:** none.

**Security:** Restrictive by design — it ADDS a permission gate on top of core's otherwise-open autocreate; reviewed, it does not over-grant (users lacking the permission lose `#autocreate`). Gate is at the form/widget layer, so grant the permission only to trusted roles.

See [configure/widget-and-permission.md](configure/widget-and-permission.md)