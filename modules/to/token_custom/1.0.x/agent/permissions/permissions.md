<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# token_custom permissions

From `token_custom.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer custom tokens` | Create, edit, delete custom **tokens**; the Add-token page and token entity forms. Also the entity `admin_permission`. | `restrict access: true` (security-sensitive — content is rendered via a text format). |
| `administer custom token types` | Create, edit, delete custom **token types** (bundles). | `restrict access: true`. |
| `access custom tokens overview` | View access to the tokens overview page (`/admin/structure/token-custom`) without full admin rights. | Read-only listing. |

The collection route requires `administer custom tokens+access custom tokens overview` (either
grants the overview). Type routes require `administer custom token types`. Grant the two
`administer …` permissions only to trusted roles, since token content is output through a text
format and can contain HTML.
