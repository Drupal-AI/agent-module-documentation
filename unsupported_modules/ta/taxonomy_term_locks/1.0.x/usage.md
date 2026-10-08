<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy term locks lets editors flag individual taxonomy terms as "locked". A locked term cannot be edited or deleted through the term forms unless the user holds the "bypass taxonomy term lock" permission. Two permissions are provided: "set taxonomy term lock" (add/remove locks) and "bypass taxonomy term lock" (edit/delete locked terms; restricted).

---

The module works by altering the taxonomy term add/edit and delete forms. On the edit form it adds a "Locked" checkbox for users with the set permission, storing the flag in a custom taxonomy_term_locks table. On the delete and edit forms it calls blockUnauthorizedAccess(), which throws a 403 when the current term is locked and the user lacks bypass. On the term overview page it strips the operations links for locked terms from users without bypass.

Note that enforcement is form-level only: the module alters the standard term forms and overview, but does not implement hook_entity_access. Term edits/deletes performed through other paths (JSON:API/REST, bulk operations, or custom code) are not covered by the lock. Treat it as an editorial guardrail on the admin UI, not a hard entity-access boundary.

---

- Lock individual taxonomy terms against edits.
- Prevent deletion of locked terms in the UI.
- Grant a "set taxonomy term lock" permission to editors.
- Reserve a "bypass taxonomy term lock" permission for trusted roles.
- Add a "Locked" checkbox on the term edit form.
- Block the term delete form with a 403 when locked.
- Hide operations links for locked terms in the overview.
- Protect canonical/reference vocabularies from accidental change.
- Store lock flags in a dedicated database table.
- Bulk-insert or bulk-delete locks programmatically via the service.
- Keep taxonomy structure stable across editors.
- Guard official category terms from junior editors.
- Toggle a lock on or off from the edit form.
- Restrict lock management to specific roles.
- Apply an editorial guardrail without custom code.
- Combine set/bypass permissions for tiered control.
- Prevent inadvertent term removal on large sites.
- Signal "do not touch" terms to the editorial team.
