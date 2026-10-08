<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View User Email (view_user_email) — agent index

Grants chosen roles visibility of other users' `mail` (email) field. The entire module is one
`hook_entity_field_access()` implementation in `view_user_email.module` plus one permission.
**No routes, no configuration, no dependencies beyond core.** Core: `^8 || ^9 || ^10 || ^11`.

Deprecation: since Drupal 9.2 core ships an equivalent `view user email addresses` permission,
so the README marks this module needed only on 8.x / 9.0 / 9.1.

- **Grant a role access to email addresses** → [permissions/permissions.md](permissions/permissions.md)
- **How the grant works and where it takes effect** → [hooks/field-access.md](hooks/field-access.md)

Key facts:
- Permission: `access email field` (title "Access other users email field", `restrict access: TRUE`).
- Hook: `view_user_email_entity_field_access()` — returns `AccessResult::allowed()` for the
  `view` operation on a field named `mail` when the account holds the permission; returns
  `AccessResult::neutral()` in every other case (never `forbidden`).
- Also implements `hook_help()` on route `help.page.view_user_email`.
- Enforced at the entity field-access layer, so it applies uniformly: user profile display,
  entity/Views field rendering, and REST / JSON:API output.
