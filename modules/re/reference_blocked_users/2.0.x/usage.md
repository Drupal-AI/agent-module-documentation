Reference Blocked Users adds a single permission that lets non-admin roles select **blocked** (as well as active) user accounts in any user entity-reference field, including the core node "Authored by" field, and lets holders match users by **email address** as well as username.

---

By default Drupal's user selection handler (`default:user`) only returns *active* accounts in entity-reference autocomplete/select widgets unless the current user holds `administer users`. This module ships one `EntityReferenceSelection` plugin, `default:reference_blocked_users` (class `ReferenceAllUsers extends UserSelection`, declared with the modern `#[EntityReferenceSelection]` PHP attribute), registered for the `user` entity type in the `default` group with **`weight: 10`**. Because core's `SelectionPluginManager` picks the highest-weighted plugin in a group, this handler transparently becomes the active user-selection handler for *every* user reference field site-wide — no per-field configuration. Its overridden `buildEntityQuery()` checks the current user: if they **lack** `administer users` but **hold** the module's `reference blocked users` permission, it calls `buildEntityQueryForAllUsers()`, which runs an access-checked query (`accessCheck(TRUE)`) that includes blocked accounts (`status >= 0`) while still honouring role filters and the anonymous-user exclusion, and matches the typed text against **both** the username and the email (an `orConditionGroup` on `name`/`mail`); otherwise it falls through to the stock parent query (active users only, username match), so behaviour is unchanged for everyone else. Version 2.x targets Drupal 11.3+/12, moves the plugin from the deprecated annotation to the `#[EntityReferenceSelection]` attribute, adds email matching, and ships a kernel test (`ReferenceBlockedUsersSelectionTest`). There is no config UI (`configure` is null), no schema, no services and no dependencies beyond core `user`.

---

- Let content editors set a node's "Authored by" to a blocked user account without granting `administer users`.
- Reference blocked users in a custom `entity_reference` field that targets users.
- Reattribute existing content to a deactivated/blocked author.
- Allow a moderator role to pick blocked accounts in an autocomplete widget.
- Keep authorship pointing at a real (now-blocked) person instead of Anonymous.
- Include both active and blocked users in a user-reference select list.
- Find a user by typing part of their **email address** in the reference autocomplete, not just the username.
- Give a limited editorial role blocked-user visibility scoped to reference fields only (not the full user admin).
- Attribute imported/legacy content to accounts that were blocked after migration.
- Support workflows where accounts are blocked but must remain selectable as owners.
- Reference a blocked user on a "reviewed by" or "assigned to" field.
- Preserve author metadata when offboarding a user by blocking rather than deleting them.
- Let a helpdesk role assign tickets (entity reference to user) to suspended accounts.
- Populate a user-reference field on a paragraph or media entity with blocked users.
- Provide blocked-user selection in inline-entity-form or widget-driven user references.
- Grant blocked-user referencing per role via Drupal's permissions UI.
- Avoid patching core just to expose blocked users in the author field.
- Restore an author reference to a temporarily-suspended contributor.
- Run the module on Drupal 12 (2.x uses the modern selection-plugin attribute).
- Let editors search by name or email and match blocked accounts in the reference autocomplete.
- Standardise blocked-user referencing across all user-reference fields with one permission instead of per-field handler tweaks.
