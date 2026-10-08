# Permissions

Defined in `roleassign.permissions.yml`.

| Permission | Gates |
|---|---|
| `assign roles` | Lets a user (who also holds core **Administer users**) assign the restricted set of roles configured at `/admin/people/roleassign`. Marked `restrict access: true` (security-sensitive). |

RoleAssign does **not** define its own permission for choosing the assignable set — the config
form (`roleassign.settings`, `/admin/people/roleassign`) is gated by core
**`administer permissions`**.

## The delegation model

- **`administer permissions`** (core) — full control: pick which roles are assignable, and
  (independently) grant any permission to any role. Trusted site admins only. Holders are
  **not** restricted by RoleAssign.
- **`assign roles`** (this module) + **`administer users`** (core) — the delegatee. Can edit
  user accounts and assign *only* the configured subset of roles, without the ability to grant
  arbitrary permissions.

The point of the module: previously the only way to let someone assign roles was to grant
`administer permissions`, which also lets them grant themselves any right. `assign roles`
delegates just the role-assignment task safely.

## How "restricted" is decided — `_roleassign_restrict_access()`

The current user is **restricted** (their assignable roles are limited to `roleassign_roles`)
only when **both**:

- they do **not** have `administer permissions`, **and**
- they have **both** `administer users` **and** `assign roles`.

Anyone with `administer permissions` sees the full, unmodified roles field. A user missing
either `administer users` or `assign roles` is not affected by the module at all.

> Note: `administer users` is security-critical (it can change admin passwords/emails). Grant
> it only to trusted assistant admins; consider the User Protect module for extra safety.
