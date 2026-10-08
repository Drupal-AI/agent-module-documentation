<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `unused:modules`

One command, provided via `drush.services.yml` → `UnusedModulesCommands` (injects
`unused_modules.helper`).

```
drush unused:modules [type] [show]
```

- `type` (default `projects`) — `projects` or `modules`.
- `show` (default `disabled`) — `disabled` (only unused) or `all` (include ones with enabled
  modules).
- Aliases: `um`, `unused-modules`, `unused_modules`.
- An unknown `type`/`show` throws an exception.

## Examples

```bash
drush unused:modules projects disabled     # projects safe to delete (default)
drush um                                    # same, shorthand
drush unused:modules projects all           # all projects + whether each has enabled modules
drush unused:modules modules disabled       # individual disabled modules (in fully-disabled projects)
drush unused:modules modules all            # all non-core modules with enabled/has_modules
drush unused:modules projects disabled --format=json   # machine-readable
```

## Output columns (`RowsOfFields`)

Keyed by project (for `projects`) or module (for `modules`):

| Field | Meaning |
|---|---|
| `project` | Project name. |
| `module` | Module machine name (modules view only). |
| `enabled` | "Yes"/"No" — is this module enabled (modules view only). |
| `has_modules` | "Yes"/"No" — does the project have any enabled modules. |
| `path` | Project path on disk (e.g. `modules/contrib/token`). |

Default fields: `project,module,enabled,has_modules,path`. With `--format=json` the result is an
object keyed by project/module name, each value carrying the fields above — ideal for scripting
(e.g. checking whether a given project appears with `has_modules: "No"`).

When there is nothing to report the command prints `Hurray, no orphaned projects!` /
`Hurray, no orphaned modules!` and returns no rows.

> Note: `modules disabled` only lists modules whose **project** has no enabled modules, so a
> disabled submodule of an otherwise-enabled project will **not** appear there (use
> `modules all`).
