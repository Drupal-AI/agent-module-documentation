<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_guardian — permissions

From `config_guardian.permissions.yml` (11 perms). Routes gated in
`config_guardian.routing.yml`. Perms marked "restrict access" carry
`restrict access: true` (flagged as security-sensitive on the permissions form).

| Permission | Restrict | Gates |
|---|---|---|
| `administer config guardian` | yes | Settings form (`/settings`) |
| `view config snapshots` | no | Dashboard, snapshot list/view/compare, activity log, ajax status/pending-changes |
| `create config snapshots` | no | Create-snapshot form (`/snapshot/add`) |
| `restore config snapshots` | yes | Rollback form (`/snapshot/{id}/rollback`) |
| `delete config snapshots` | yes | Delete-snapshot form |
| `export config snapshots` | no | Snapshot JSON download (`/snapshot/{id}/export`) |
| `import config snapshots` | yes | Snapshot import form (`/snapshot/import`) |
| `analyze config impact` | no | Impact analysis page, dependency-graph ajax + iframe |
| `synchronize configuration` | yes | Sync overview (`/sync`) |
| `export configuration` | yes | Export active config to sync (`/sync/export`) |
| `import configuration` | yes | Import config from sync (`/sync/import`) |

Notes:
- `administer config guardian` gates only the settings form — it is NOT a superset
  that unlocks the other routes; each action needs its own permission.
- Restore, import (snapshot), delete, synchronize, export/import configuration, and
  administer overwrite or expose live configuration — grant only to trusted
  operators. View/analyze/export-snapshot are read-only-ish but expose full config
  values.
