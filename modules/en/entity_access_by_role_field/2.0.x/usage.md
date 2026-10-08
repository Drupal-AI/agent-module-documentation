<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Access by Role Field adds an "Entity Access by Role" field type that lets editors allow or deny access to each individual fielded entity for chosen user roles, enforced through `hook_entity_access()`.

---

The module provides a single field type, `entity_access_by_role_field`, that you attach to any fieldable entity bundle (node, taxonomy term, media, user, etc.). Each field value is a pair of `role_id` + `access` (`allowed`/`forbidden`), and a widget lets an editor pick roles and whether those roles are allowed or restricted. Per field instance you configure two settings: `operations` (which of `view`, `update`, `delete` the field governs) and `empty_roles_access_fallback` (what happens when no role is chosen: `neutral`, `allowed`, or `forbidden`). At runtime `entity_access_by_role_field_entity_access()` reads all such fields on the entity and returns an allowed/forbidden/neutral result by intersecting the entity's selected roles with the current user's roles; an "allowed" field grants access to matching roles and forbids others, a "forbidden" field does the reverse. Unpublished entities are handled specially: a `view` request on an unpublished entity is treated as the `view_unpublished` operation. A global `bypass entity_access_by_role_field permissions` permission (restricted) lets trusted roles skip all of this logic. The module deliberately does NOT implement `hook_query_TAG_alter()`, so Views and other listing queries are not filtered — access is only enforced on the canonical/entity operations, which can lead to label disclosure in listings. It also adds an access check to the taxonomy term canonical route via a route subscriber. It is a fork of the older Entity Access by Role module.

---

- Restrict viewing of a specific node to one or more selected roles, per node.
- Let editors mark an individual article as visible only to an "editor" or "member" role.
- Deny a set of roles access to a particular entity while allowing everyone else (forbidden mode).
- Control view, edit, and delete access independently on the same entity via the `operations` setting.
- Apply per-entity role access to taxonomy terms (the module adds the term canonical access check).
- Apply per-entity role access to media entities, users, or any fieldable entity type.
- Choose a fallback (`neutral`/`allowed`/`forbidden`) for entities where no role is selected.
- Fall back to "neutral" so other modules/core still decide access when the field is left empty.
- Fall back to "forbidden" to make a field default to locked-down unless roles are explicitly allowed.
- Allow trusted administrators to bypass all field access logic with a single global permission.
- Combine multiple role-access fields on one entity, each governing different operations.
- Give a "premium" role exclusive view access to paywalled content nodes.
- Let unpublished content be viewed only by roles allowed via the view_unpublished handling.
- Set default role/access values on the field instance so new entities start with a sensible policy.
- Model simple per-record access without writing a custom node-access module.
- Grant edit rights on specific entities to a "contributor" role while denying delete.
- Use the debug formatter to display which roles/access an entity's field currently carries.
- Replace ad-hoc "private content" flags with an explicit role-based per-entity control.
- Restrict a landing-page node to internal roles during a staged launch, then open it up.
- Enforce different visibility per entity within the same content type.
- Migrate from the legacy Entity Access by Role module to a maintained field-based approach.
- Deny anonymous users access to selected entities while leaving the rest public.
- Provide editors a self-service way to lock a page to specific roles without a site builder.
- Layer per-entity role access on top of core permissions for finer control.
- Configure which operations a role-access field affects so it only gates viewing, not editing.
