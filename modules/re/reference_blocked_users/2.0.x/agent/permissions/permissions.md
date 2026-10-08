<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — Reference Blocked Users

Source: `reference_blocked_users.permissions.yml`.

| Permission | Gates | `restrict access` |
|---|---|---|
| `reference blocked users` | Whether the user-selection handler includes **blocked** accounts (and email matching) in user reference fields. | not set (grantable to any role) |

Title: "Reference blocked users". Description: "Permission to reference all users
(active/blocked) in entity reference user field and in Authored by field".

## How it is checked

In `ReferenceAllUsers::buildEntityQuery()`:

```php
if (!$this->currentUser->hasPermission('administer users') &&
     $this->currentUser->hasPermission('reference blocked users')) {
  return $this->buildEntityQueryForAllUsers($match, $match_operator); // includes status 0
}
return parent::buildEntityQuery($match, $match_operator);            // active only
```

- A user with `administer users` already sees all accounts via core, so the module leaves them
  on the parent path (the extra permission is only meaningful for **non**-admin roles).
- A user with neither permission gets core's default: active accounts only, username match.
- Grant `reference blocked users` to any editorial role that must attribute content to, or
  reference, blocked/suspended accounts without receiving the full `administer users` grant.

## Scope note

The permission only affects what appears in **user entity-reference selection** (autocomplete,
select, "Authored by"). It does not grant viewing, editing or unblocking of the user accounts
themselves, and the query still runs `accessCheck(TRUE)`. Email is used only as a query match
condition; the referenceable results still render the account label (username), as in core.
