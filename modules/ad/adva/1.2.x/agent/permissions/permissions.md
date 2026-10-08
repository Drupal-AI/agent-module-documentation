<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# adva permissions

From `adva.permissions.yml` + `EntityBypassPermissions::permissions()`:

| Permission | Restrict | Gates |
|---|---|---|
| `administer adva` | yes | Access the settings form (`adva.settings`) and rebuild form (`adva.access_rebuild`) — configure which providers apply per entity type and trigger rebuilds. |
| `bypass adva access` | yes | Global bypass. In `adva_query_alter` and `AccessStorage::access` a holder is exempt from adva grant filtering for **all** entity types. |
| `bypass adva <entity_type> access` | yes | Per-entity-type bypass, generated for each consumer (e.g. `bypass adva media access`). Exempts the holder from adva grants for that type. |

Notes:
- All three are `restrict access: true` — intended only for trusted roles.
- The two bypass checks are combined differently by path: `adva_query_alter` skips filtering if
  the account has the **global OR the per-type** bypass; `AccessStorage::access()` early-returns
  `allowed` only when the account has **both** global AND per-type bypass. (The handler path is
  additive regardless — see api/access-model.md.)
- Per-type bypass permissions exist only for entity types that have a registered Access Consumer.
