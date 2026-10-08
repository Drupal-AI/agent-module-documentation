# Radioactivity — Drush

Defined in `src/Drush/Commands/RadioactivityDrushCommands.php` (Drush 12+ attribute style).

## `radioactivity:fix-references`

Backfills `radioactivity_reference` fields that have no referenced `radioactivity` entity (e.g. after
adding the field to existing content, or migration). For each entity returned by
`RadioactivityReferenceUpdater::getReferencesWithoutTarget()` it creates and links a radioactivity
entity via `updateReferenceFields()`.

```bash
ddev drush radioactivity:fix-references
```

No arguments/options. Logs a warning if nothing needs fixing, otherwise a success count. Related:
`hook_requirements('runtime')` raises an ERROR on the status report when reference fields are missing
targets, pointing you to run this command.
