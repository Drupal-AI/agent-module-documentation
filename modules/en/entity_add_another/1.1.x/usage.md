<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Add Another creates a button on entity add forms that allows creating an entity and immediately adding another.

---

Entity Add Another adds a "Save and Add Another" button to entity add forms — so after creating an
entity the editor is returned to a fresh add form, speeding up bulk creation of many entities of the same
type. It is configured at `entity_add_another.settings` (`/admin/config/content/entity_add_another`) and
provides its own permissions. Branch 1.1.x refactors the hooks onto Drupal's attribute-based OOP hook
system and requires core 10.1 or newer (also supporting 12).

Use it to streamline repetitive entity creation. It is a content-editing/workflow feature affecting the
add-form buttons; entity creation is still governed by normal create access — the button only appears on
add forms the editor can already reach, and after saving it redirects back to the same (internal) add form.
It has no access-control role beyond its two permissions. Enable the button per entity type or bundle from
the settings form.

---

- Add a Save-and-Add-Another button to entity add forms.
- Return the editor to a fresh add form after saving.
- Speed up bulk creation of many entities of one type.
- Enable the button per entity type from the settings form.
- Enable the button per bundle (`entity_type__bundle`) as well.
- Work with any content entity type using standard entity forms.
- Streamline content-entry team workflows.
- Batch-create nodes of a content type quickly.
- Batch-create taxonomy terms in a vocabulary.
- Batch-upload or register media entities.
- Batch-create Commerce, ECK, or custom entities.
- Gate visibility with the "use entity add another" permission.
- Restrict configuration with the "administer entity add another" permission.
- Rely on normal create access for the entity type.
- Redirect back to the same add form (internal path only).
- Preserve the current query string on the return redirect.
- Order the button correctly alongside Inline Entity Form.
- Configure at `entity_add_another.settings`.
- Reduce repetitive navigation for administrators.
- Create and immediately add another entity.
