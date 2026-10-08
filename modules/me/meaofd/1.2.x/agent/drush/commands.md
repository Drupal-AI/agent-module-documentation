<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command

Defined in `drush.services.yml` -> `Drupal\meaofd\Commands\Commands` (legacy annotated command class,
injected `@meaofd.fixer`).

## `meaofd:fix <entity_type_id>`

Reconciles the stored definitions of one entity type with code (the same action as the report page's
"Fix" button).

```bash
drush meaofd:fix paragraph      # fix the Paragraph entity type
drush meaofd:fix node
```

- **Argument** `entity_type_id` (required) — the machine id of the entity type, e.g. `node`,
  `paragraph`, `taxonomy_term`, `media`, `comment`.
- **Option** `--no-cache-rebuild` — skip rebuilding entity cache definitions before/after the fix.

Behaviour: writes `Fixing entity definitions for <id>`, then calls `Fixer::fix()` only if
`entityTypeHasChanges()` is TRUE. Prints `Entity types updated: <id>` when something changed, otherwise
`No updates required for entity type: <id>`. On error it logs and re-throws.

No alias is registered; there is no bulk "fix everything" command — call it per entity type.
