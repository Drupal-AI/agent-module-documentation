Entity Reference Integrity Enforce turns the base module's dependency data into real deletion protection: for the entity types you enable, entities that are still referenced by an entity_reference field cannot be deleted.

---

On the settings form (`/admin/config/content/entity-reference-integrity`, permission `administer entity reference integrity enforce`) an admin ticks which entity types to protect; the choice is stored in `entity_reference_integrity_enforce.settings:enabled_entity_type_ids` (empty by default). Enforcement then happens on several fronts: `hook_entity_predelete` throws a `ProtectedEntityException` if a protected, still-referenced entity is about to be deleted (a hard backstop for any code path, ordered to run first); `hook_form_alter` rewrites the standard entity *delete* form to remove the confirm button and instead list the referencing entities (first 10 shown, with "view label" access respected); `hook_entity_access` denies `delete` on JSON:API routes (`_format = api_json`) for referenced entities; and `hook_action_info_alter` swaps core's `entity:delete_action` for a subclass whose `access()` also forbids deletion of referenced entities (so VBO/bulk delete is covered too). All checks call the base module's `hasDependents()` handler. The exception backstop means even a raw `$entity->delete()` will fail for protected referenced entities.

---

- Prevent deletion of taxonomy terms that are still referenced by content.
- Prevent deletion of media entities still used in fields.
- Prevent deletion of referenced users, nodes, or any enabled entity type.
- Show editors the exact list of entities that reference the one they tried to delete.
- Replace the delete confirm button with an explanatory "in use" message.
- Block deletes coming through the admin UI delete forms.
- Block deletes coming through bulk/VBO `entity:delete_action`.
- Block deletes coming through JSON:API (`api_json`) DELETE requests.
- Guarantee protection even for programmatic `$entity->delete()` via the predelete exception.
- Choose exactly which entity types are protected on the settings form.
- Leave other entity types unaffected (only enabled types are enforced).
- Respect entity access when listing referencing entities to a user.
- Keep referential integrity in a decoupled/headless setup.
- Give content teams a safety net against breaking references.
- Combine with the base module's API for custom "used by" reporting.
