<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

| Permission | Defined by | Gates |
|---|---|---|
| `view diffs of changed files` | `hacked.permissions.yml` (**`restrict access: true`**) | Viewing the per-file diff pages (`hacked.project_diff`, needs the `diff` module) — diffs can expose file contents, hence restricted |
| `administer site configuration` | Drupal core | Every Hacked! report route: `/admin/reports/hacked`, `/…/check`, `/…/{project}`, and the settings form |

Note Hacked! reuses core's `administer site configuration` for the report and settings routes
(see `hacked.routing.yml`) rather than defining its own report permission — so any user who can
administer site configuration can run the integrity report. Only the diff view has a dedicated,
access-restricted permission.

Grant e.g.: `drush role:perm:add auditor 'view diffs of changed files'` (the role still needs
`administer site configuration` to reach the report itself).
