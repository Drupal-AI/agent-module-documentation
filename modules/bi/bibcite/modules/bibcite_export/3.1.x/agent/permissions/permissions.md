<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (`bibcite_export.permissions.yml`)

| Permission | Gates |
|---|---|
| `access bibcite export` | Exporting reference data — the single-reference export route, the export-multiple form, and (together with `administer bibcite`) the export-all form. |

Notes:

- The single export route also enforces `entity.view` access on the reference itself.
- The export-**all** form additionally requires `administer bibcite` (route requirement
  `administer bibcite+access bibcite export`).
- Not `restrict access`-flagged; grant it to any role that should download citations.
