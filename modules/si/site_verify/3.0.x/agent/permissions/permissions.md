<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Both permissions are `restrict access: TRUE` (marked security-sensitive in the permissions UI).

| Machine name | Title | Grants |
|---|---|---|
| `administer site verify` | Administer site verification | View the verifications listing (`view`/`view label` operations on ANY `site_verification` entity); the entity type's `admin_permission`, so it also gates create/update/delete/enable/disable of **meta**-type verifications. |
| `manage file based site verifications` | Manage file type site verifications | Required in addition to the above to create, edit, delete, enable, or disable **file**-type verifications specifically. |

## How access is decided

`Drupal\site_verify\Entity\SiteVerificationAccessControlHandler::checkAccess()`:

- `view` / `view label` on any verification → requires `administer site verify`.
- `update`, `delete`, `enable`, `disable` on a verification → requires `administer site verify`
  **if the entity's `type` is `meta`**, or `manage file based site verifications` **if the
  entity's `type` is `file`** (a `match()` on `SiteVerificationType`).
- `delete` on a not-yet-saved (`isNew()`) entity is always forbidden.
- `enable` is forbidden if already enabled; `disable` is forbidden if already disabled.

Practical effect: a role with only `administer site verify` can see the full list (including
file verifications) and manage meta-tag verifications, but the **add/edit form hides the
"File" option** and the "Upload a file" button when the user lacks
`manage file based site verifications` — so that role effectively cannot create or convert a
verification to type `file`. Grant `manage file based site verifications` only to roles that
should be able to serve arbitrary text content from a root-relative path on the live site.

There are no other module-defined permissions (no separate "view" or "access" only permission
distinct from `administer site verify`).
