<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered through `drush.services.yml` →
`Drupal\select_translation\Commands\SelectTranslationCommands` (Drush 9/10/11).

## `select_translation:translation <nid>` (alias `select-translation`)

Resolves and returns the selected translation of node `<nid>` using the same algorithm as
the Views filter / API function.

- Argument `nid` — the node id (must be an integer ≥ 1, else it throws).
- Option `--mode` — `default`, `original`, or a comma-separated langcode list (see
  [../api/functions.md](../api/functions.md) for the mode syntax). If omitted, the API
  default (`default`) is used.

The command calls `select_translation_of_node($nid, $mode)`, logs the chosen langcode to the
`select_translation` logger channel (`"Selected translation for node <nid>: <langcode>"`),
and returns the node object. It throws if the node id is invalid or the node cannot be found.

```bash
drush select_translation:translation 42 --mode default
drush select-translation 42 --mode fr,en,current
```
