# Varbase Core — drush commands

Registered by service `varbase_core.commands` →
`Drupal\varbase_core\Drush\Commands\VarbaseCoreCommands` (tagged `drush.command`). All are
maintenance/upgrade helpers meant for developers/CI, not runtime.

| Command | Aliases | Args | What it does |
|---|---|---|---|
| `varbase:remove-non-existent-permissions` | `rnep` | — | Calls `ModuleInstallerFactory::removeNoneExistentPermissions()` to strip permissions that no longer exist (static or dynamic) from stored role config. Use after upgrades that dropped permissions. Logs to the `Varbase` channel. |
| `varbase:entity-update` | `edupdb` | — | Resolves `Vardot\Entity\EntityDefinitionUpdateManager` and calls `applyUpdates()` to reconcile mismatched entity/field definitions ("changes were detected" errors). |
| `varbase:optional-update` | `varbase-up` | `<module> <update_hook> [force]` | Loads `<module>.install` and, if the named function exists, calls it with `$force`. Intended for `*_optional_update_*` functions (e.g. `varbase_core_optional_update_9003`). Prints usage if module or hook is missing. |
| `varbase:composer:cleanup:patches` | `var-ccup` | — | Scans the root `composer.json` `extra.patches`, downloads any GitLab merge-request patch URLs to `<project>/patches/` with a timestamped name, and rewrites the patch entries to the local file paths. Run from the project root. |
| `varbase:composer:cleanup:patches-file` | `var-ccupf` | — | Same as above but for the external file named in `extra.patches-file`. |

## Notes

- `varbase-up` runs an arbitrary function by name from a module's `.install`; only pass trusted
  update-hook names.
- The two `cleanup:patches*` commands fetch each MR patch URL via cURL (default TLS verification),
  create `patches/` if absent, and re-serialize the composer/patches JSON with
  `JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES`. They only act on `/-/merge_requests/` links and
  report "no merge request patches found" otherwise.

Example:

```bash
drush rnep
drush edupdb
drush varbase-up varbase_core varbase_core_optional_update_9003 1
drush var-ccup
```
