<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edit own user account permission (edit_own_user_account_permission) — agent index

Adds one permission, **`edit own user account`**, and replaces the access check on core's
user edit route so a site can control whether authenticated users may edit their own account
at all. No dependencies, no config UI. Version **8.x-1.1**, core `^10.3 || ^11.0`,
`GPL-2.0-or-later`, package `Permissions`.

## Mechanism (read the source, it is tiny)
- `edit_own_user_account_permission.permissions.yml` — declares `edit own user account`.
- `src/Routing/RouteSubscriber.php` — `alterRoutes()` sets `_custom_access` on the
  `entity.user.edit_form` route (`/user/{user}/edit`), replacing core's owner-based access.
- `src/Access/EditOwnUserAccountAccessCheck.php` — `access(AccountInterface $user, AccountInterface $account)`.
  Drupal resolves `$user` to the **`{user}` entity being edited** (route parameter, upcast) and
  `$account` to the **current user** (typed `AccountInterface`). It returns
  `allowedIf( ($account->hasPermission('edit own user account') && $user->id() == $account->id())
  || $account->hasPermission('administer users') )`.

## Net behavior
- **Own account only.** A holder of `edit own user account` may edit **only their own** account —
  the `$user->id() == $account->id()` check enforces this. To edit *other* accounts you still need
  core's `administer users`, which bypasses the whole check.
- **Off by default.** The permission ships unassigned, so out of the box self-editing is
  disabled: the "Edit" local task on a user's own profile is hidden and `/user/{uid}/edit`
  returns access denied. Grant the permission to restore self-editing per role.
- **Whole form, not per field.** The gate is on the route, so it covers the entire account form
  (name, email, password). It does **not** hide or expose individual fields, and it does **not**
  change core's rules for who may set roles/status (those still require `administer users` /
  `administer permissions`). Other routes into the same data (webform, JSON:API, custom forms)
  are not covered.
- **Priority.** This permission gates the form, so it sits *above* core's "Change own username":
  without it, that core permission cannot take effect because the form is unreachable.

## When to use
- Demo/sandbox sites; accounts provisioned from LDAP/SAML/CRM; intranets with
  administrator-maintained accounts; least-privilege on self-service.
- Before withholding it, confirm account recovery (admin edits, password reset) still covers
  email/password changes users can no longer make themselves.

## Files
- `../data.json` — metadata.
- `../usage.md` — summary, detail, use cases.
- `permissions/edit-own-user-account.md` — the permission and exact access logic.
