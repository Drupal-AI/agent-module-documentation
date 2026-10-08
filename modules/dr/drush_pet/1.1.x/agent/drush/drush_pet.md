<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `potx:extract-translations` (alias `pet`)

Extracts translatable strings from Drupal projects using POTX and writes one `.po`
file per project and language. Provided by class
`Drupal\drush_pet\Drush\Commands\PotxExtractTranslationsCommand`.

## Signature

```
drush potx:extract-translations [<project>] [--type=…] [--group=custom] [--language=…]
drush pet [<project>] [--type=…] [--group=custom] [--language=…]
```

## Argument

| Arg | Optional | Meaning |
|---|---|---|
| `project` | yes | Machine name of a single module, theme or profile. When omitted, all matched projects are processed. |

## Options

| Option | Default | Meaning |
|---|---|---|
| `--type` | *(all)* | Restrict to one project type: `module`, `theme`, or `profile`. Any other value errors out. |
| `--group` | `custom` | Only projects whose filesystem path contains this directory segment (e.g. `custom`, `contrib`, `shared`) are included. Matched as `<group>/` in the path. |
| `--language` | *(all)* | Language code to extract (e.g. `nl`, `fr`). When omitted, uses all configured, unlocked, translatable site languages (or the default language on a monolingual site). |

## Behavior

For each matched project × language:
1. Collects the project's source files via POTX (`_potx_explore_dir`), excluding files
   under the project's own nested `modules/` (submodules are handled as their own projects).
2. Runs POTX extraction into an in-memory store and renders a `.po` file body.
3. If no translatable strings are found, that project/language is **skipped** (nothing written).
4. Otherwise creates `<project-path>/translations/` (if missing) and writes
   `<project>.<lang>.po` there.
5. Patches the project's `<project>.info.yml`, setting
   `interface translation project: <project>` and
   `interface translation server pattern: <path>/translations/%project.%language.po`
   (skipped when the pattern is already correct).

Output: a progress bar plus a summary table of Project / Language / File (or "Skipped").
Returns success even when nothing was written; returns failure on invalid `--type`,
no loadable language, a non-existent named project, or file-write errors.

## Requirements at runtime

- The `potx` module must be enabled (dependency; the command loads `potx.inc` and
  `potx.local.inc`).
- At least one unlocked, translatable language must be configured, else the command errors.

## Examples

```bash
# Single project.
drush potx:extract-translations my_module

# All custom modules.
drush potx:extract-translations --type=module

# All themes under a "shared" path segment.
drush potx:extract-translations --type=theme --group=shared

# Only Dutch, all custom projects.
drush potx:extract-translations --language=nl

# Everything: all types, all languages, custom group.
drush potx:extract-translations
```

## Notes

- Writes into the project source tree (`translations/` dir + `.info.yml` edit) — intended
  for developer/local use, not production runtime.
- POTX accumulates results in global state; the command resets that state between projects,
  so a single invocation over many projects is safe.
