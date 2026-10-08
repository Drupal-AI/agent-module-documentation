<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `drush potx` — command-line extraction

Command `potx` (class `Drupal\potx\Drush\Commands\PotxCommands`, also a legacy
`potx.drush.inc`). Extracts translatable strings from Drupal source and writes Gettext files.

```
drush potx [MODE] [options]
```

## Modes (first argument)

| Mode | Constant | Effect |
|---|---|---|
| `single` (default) | `POTX_BUILD_SINGLE` | every file folded into one output template |
| `multiple` | `POTX_BUILD_MULTIPLE` | `.info` strings folded into per-module `.pot` files |
| `core` | `POTX_BUILD_CORE` | Drupal-core style: `.info` strings fold into `general.pot` |

## Options

| Option | Meaning |
|---|---|
| `--modules=a,b` | comma-list of installed modules; extracts from each module's path |
| `--files=a,b` | comma-list of specific files to scan |
| `--folder=path` | scan this folder (default when nothing else given: current directory) |
| `--api=N` | Drupal API version 5/6/7/8 for extraction settings (default current = 8) |
| `--language=xx` | build a language-dependent template (plural formula, language name) |
| `--translations` | also export existing translations (needs `--language`) |

Selection precedence: `--modules` → `--files` → `--folder` → autodiscover the current directory.

## Output location

Files are written to the **current working directory** (via `_potx_write_files()` with no HTTP
filename). `single`/`core` produce `general.pot` (plus `installer.pot`); `multiple` produces one
`.pot` per module. `cd` into the directory you want the files in before running.

## Examples

```bash
drush potx single                      # everything in CWD -> general.pot
drush potx multiple --modules=token    # token's strings -> per-module .pot
drush potx --files=web/modules/contrib/potx/potx.module
drush potx single --api=8 --folder=web/modules/contrib/potx
```

The command returns a table of `files`, `strings`, and `warnings` counts; errors are logged.
