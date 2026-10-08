# Drush commands

Defined in `src/Drush/Commands/UpgradeStatusCommands.php` (`drush.services.yml`). Use for CI gating —
exit code is non-zero when errors are found.

### `upgrade_status:analyze [projects...]` (alias `us-a`)
Analyze one or more projects and print results.
Options:
- `--all` — analyze all projects.
- `--skip-existing` — reuse a prior scan's results if present.
- `--ignore-uninstalled` — skip uninstalled projects.
- `--ignore-contrib` / `--ignore-custom` — skip contributed / custom projects.
- `--ignore-list=a,b,c` — skip named projects.
- `--phpstan-memory-limit=…` — memory limit passed to PHPStan.
- `--format=plain|checkstyle|codeclimate` — output format.

```bash
drush upgrade_status:analyze --all
drush us-a my_module --skip-existing
```

### `upgrade_status:checkstyle [projects...]` (alias `us-cs`)
Same analysis, emits Checkstyle-style output for CI. Same `--all/--skip-existing/--ignore-*/
--phpstan-memory-limit` options.

```bash
drush upgrade_status:checkstyle --all --ignore-uninstalled
```

Returns `EXIT_SUCCESS` when no errors, a failure exit code when at least one error is found — wire
into a pipeline to block merges that introduce deprecations.
