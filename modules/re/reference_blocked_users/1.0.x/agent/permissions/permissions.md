# Permissions — Reference Blocked Users

Source: `reference_blocked_users.permissions.yml`.

| Permission | Gates | `restrict access` |
|---|---|---|
| `reference blocked users` | Whether the user-selection handler includes **blocked** accounts in user reference fields. | not set (grantable to any role) |

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
- A user with neither permission gets core's default: active accounts only.
- Grant `reference blocked users` to any editorial role that must attribute content to, or
  reference, blocked/suspended accounts without receiving the full `administer users` grant.

## Scope note

The permission only affects what appears in **user entity-reference selection** (autocomplete,
select, "Authored by"). It does not grant viewing, editing or unblocking of the user accounts
themselves, and the query still runs `accessCheck()`.
