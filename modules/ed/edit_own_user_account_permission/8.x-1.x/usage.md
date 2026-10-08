<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Edit own user account permission adds an `edit own user account` permission and rewires the core user edit route so that a site can decide whether authenticated users may edit their own account at all.

---

Core has no switch for this: any authenticated user may edit their own account, because core's `entity.user.edit_form` route (`/user/{user}/edit`) grants `update` access to the account owner. This module replaces that route's access with its own check (a `RouteSubscriber` sets `_custom_access` on the route, resolved by `EditOwnUserAccountAccessCheck::access()`). The new rule is: the current user may reach `/user/{user}/edit` **only** if either (a) they hold `edit own user account` **and** the `{user}` being edited is themselves (`$user->id() == $account->id()`), or (b) they hold core's `administer users` (which still lets an admin edit anyone). Because the permission is not granted to any role on install, the default effect is to **disable** self-service account editing: the "Edit" tab on a user's own profile disappears and visiting the edit form returns access denied. Grant the permission to a role and its users regain the ability to edit their own account. The gate is at the **whole form** level — it covers the name, email and password fields that live on that form — not individual fields; other profile fields exposed through other forms, webforms, JSON:API or custom code are unaffected and need their own controls. Note two interactions: this permission has **higher priority than core's "Change own username"** (without it, that core permission cannot take effect because the form is unreachable), and withholding it removes the user's own path to change their email or password, so confirm your account-recovery flow (admin edits, password reset) still covers those needs. The module is intentionally tiny — one permission, one route subscriber, one access check — with no dependencies and no configuration UI; you manage it entirely from Admin > People > Permissions.

---

- Lock down a demo or sandbox site so visitors cannot alter the seeded account.
- Prevent authenticated users from editing their own account by default.
- Grant self-service account editing to only specific roles.
- Stop users editing profiles that are provisioned from LDAP, SAML or a CRM.
- Prevent self-service email changes that could redirect password resets.
- Prevent self-service display-name changes used for impersonation.
- Keep synced identity fields authoritative against an external source.
- Hide the "Edit" tab on a user's own profile page.
- Return access denied on `/user/{uid}/edit` for users without the permission.
- Keep `administer users` admins fully able to edit any account.
- Enforce administrator-maintained accounts on an intranet.
- Apply least privilege to the user account form.
- Keep the account name, email and password read-only for end users.
- Gate the core "Change own username" permission behind this one.
- Support a provisioned-accounts operating model.
- Reduce inconsistent or divergent profile data.
- Freeze account edits during a migration or content-freeze window.
- Enforce a compliance requirement that identity fields are not self-edited.
- Roll self-editing out gradually per role rather than for all authenticated users.
- Keep student or member records edited only by staff.
