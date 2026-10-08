Reference Blocked Users adds a single permission that lets non-admin roles select **blocked** (as well as active) user accounts in any user entity-reference field, including the core node "Authored by" field.

---

By default Drupal's user selection handler (`default:user`) only returns *active* accounts in entity-reference autocomplete/select widgets unless the current user holds `administer users`. This module ships one `EntityReferenceSelection` plugin, `default:reference_blocked_users` (class `ReferenceAllUsers extends UserSelection`), registered for the `user` entity type in the `default` group with **`weight: 10`**. Because core's `SelectionPluginManager::getPluginId()` picks the highest-weighted plugin in a group, this handler transparently becomes the active user-selection handler for *every* user reference field site-wide — no per-field configuration. Its overridden `buildEntityQuery()` checks the current user: if they **lack** `administer users` but **hold** the module's `reference blocked users` permission, it runs a query that includes blocked accounts (`status >= 0`) while still honouring `accessCheck()`, role filters and the anonymous-user exclusion; otherwise it falls through to the stock parent query (active users only), so behaviour is unchanged for everyone else. There is no config UI (`configure` is null), no schema, no services and no dependencies beyond core `user`. This solves the case core cannot: the "Authored by" field has no handler-settings form, so there was previously no way to grant editors the ability to attribute content to a blocked account without giving them full `administer users`.

---

- Let content editors set a node's "Authored by" to a blocked user account without granting `administer users`.
- Reference blocked users in a custom `entity_reference` field that targets users.
- Reattribute existing content to a deactivated/blocked author.
- Allow a moderator role to pick blocked accounts in an autocomplete widget.
- Keep authorship pointing at a real (now-blocked) person instead of Anonymous.
- Include both active and blocked users in a user-reference select list.
- Give a limited editorial role blocked-user visibility scoped to reference fields only (not the full user admin).
- Attribute imported/legacy content to accounts that were blocked after migration.
- Support workflows where accounts are blocked but must remain selectable as owners.
- Reference a blocked user on a "reviewed by" or "assigned to" field.
- Preserve author metadata when offboarding a user by blocking rather than deleting them.
- Let a helpdesk role assign tickets (entity reference to user) to suspended accounts.
- Populate a user-reference field on a paragraph or media entity with blocked users.
- Provide blocked-user selection in views-driven or inline-entity-form user references.
- Grant blocked-user referencing per role via Drupal's permissions UI.
- Avoid patching core just to expose blocked users in the author field.
- Restore an author reference to a temporarily-suspended contributor.
- Reference blocked accounts in a taxonomy-term or config-entity field that points at users.
- Let editors search by name and match blocked accounts in the reference autocomplete.
- Standardise blocked-user referencing across all user-reference fields with one permission instead of per-field handler tweaks.
