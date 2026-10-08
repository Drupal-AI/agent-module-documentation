<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `config:inspect`

Provided by `src/Commands/InspectorCommands.php` (Drush 11+ annotated command; a legacy
`config_inspector.drush.inc` `inspect_config` exists for Drush 9/10).

```
drush config:inspect [key] [options]
```

- `key` (optional) — a single config name (e.g. `system.site`). Omit to inspect **all** active config.
- **Alias:** `inspect_config`.
- **Exit code:** non-zero (`EXIT_FAILURE`) when any inspected object has schema errors — so
  `drush config:inspect --only-error` is usable as a CI gate. (With `--statistics` the exit
  code is forced back to success so validatability can still be computed.)

## Options

| Option | Effect |
|---|---|
| `--only-error` | Hide config that is fully correct; show only problems. |
| `--detail` | Expand each object into per-property-path rows. |
| `--filter-keys=a,b` | Inspect only these keys. Supports glob (`system.action.*`). Mutually exclusive with `--skip-keys`. |
| `--skip-keys=a,b` | Skip these keys. Mutually exclusive with `--filter-keys`. |
| `--strict-validation` | Treat < 100% validatability as an error (combine with `--only-error`). |
| `--list-constraints` | Print the validation constraints per property path. **Requires `--detail`.** |
| `--generate-baseline` | Write `config_inspector-baseline.json` (the current keys) to CWD. **Requires `--only-error`.** |
| `--baseline=FILE` | Skip keys listed in a baseline JSON file. **Requires `--only-error`.** |
| `--todo[=N]` | List the N (default 15) unvalidatable config objects closest to 100%, plus the highest-impact unvalidatable types. Cannot combine with `--detail`. |
| `--statistics` | Emit a large JSON assessment of type/object validatability across the whole site. |
| `--fields=key,status,...` | Choose output columns (default `key,status,validatability,data,constraints`). |

## Common recipes

```bash
drush config:inspect                                   # inspect everything
drush config:inspect --only-error                      # only schema problems (CI-friendly)
drush config:inspect --only-error --detail             # problems, per property path
drush config:inspect system.site --detail              # one object, detailed
drush config:inspect --filter-keys='system.action.*' --detail --list-constraints
drush config:inspect --only-error --generate-baseline  # snapshot current failures
drush config:inspect --only-error --baseline=config_inspector-baseline.json
```

Data column legend: `✅❓` = correct primitive type, no deeper validation possible;
`✅✅` = correct primitive type and passed all constraints.
