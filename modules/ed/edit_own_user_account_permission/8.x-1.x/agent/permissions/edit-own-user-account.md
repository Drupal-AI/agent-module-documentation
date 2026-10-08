<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission: `edit own user account`

Declared in `edit_own_user_account_permission.permissions.yml`:

```yaml
edit own user account:
  title: Edit own user account
  description: User can edit their own account profile.
```

Not `restrict access` flagged, and **not granted to any role on install** — so the default
state is that no one has it and self-service account editing is off.

## What it gates
The module's `RouteSubscriber::alterRoutes()` sets `_custom_access` on the core
`entity.user.edit_form` route (`/user/{user}/edit`), pointing at
`EditOwnUserAccountAccessCheck::access()`. This **replaces** core's default owner-based
access on that route. The check:

```php
public function access(AccountInterface $user, AccountInterface $account) {
  $can_edit_own_account = ($account->hasPermission('edit own user account') && $user->id() == $account->id());
  return AccessResult::allowedIf($can_edit_own_account || $account->hasPermission('administer users'));
}
```

Argument resolution (important):
- `$user` = the **`{user}` entity being edited** (route parameter, upcast to a `User`, which
  implements `AccountInterface`).
- `$account` = the **current user** (matched by the `AccountInterface` type-hint).

So access to a user's edit form is granted only when **the current user holds
`edit own user account` and is editing their own account**, or when the current user holds
core `administer users` (which lets admins edit anyone).

## Effects of granting / withholding
- **Granted to a role:** those users regain the "Edit" tab on their own profile and can open
  `/user/{uid}/edit` for their own account (name, email, password, and whatever else that form
  exposes for a non-admin).
- **Withheld (default):** the "Edit" local task on the user's own profile is hidden and visiting
  the own edit form returns access denied.
- **`administer users`** always bypasses this check — admins are unaffected.
- Gate is at the **route/form** level; it does not add per-field control and does not change
  which fields core shows to non-admins (roles/status remain admin-only via core).

## Managing it
Admin > People > Permissions (`/admin/people/permissions`), row "Edit own user account".
No configuration form, no Drush commands, no config schema.
