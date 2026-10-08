<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (`bibcite_import.permissions.yml`)

| Permission | Gates | Restricted |
|---|---|---|
| `bibcite import` | Access to the import form (`/admin/content/bibcite/reference/import`). | yes |
| `bibcite populate` | Access to the populate form (`/admin/content/bibcite/reference/populate`). | yes |

Both are `restrict access: true` (grant only to trusted roles). The routes additionally require
core `administer bibcite` (from bibcite core), so an importer effectively needs
`bibcite import`+`administer bibcite`. The settings form is gated by `administer bibcite` alone.
