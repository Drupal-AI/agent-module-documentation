# Drush

Config Ignore does not add standalone Drush commands. It registers command *hooks*
(`src/Drush/Commands/ConfigIgnoreCommands.php`) that add one option to core's config
import/export commands.

## `--deactivate-config-ignore`
Added to `drush config:export` and `drush config:import`. When present, it sets
`config_ignore_deactivate = TRUE` for that single run, so ignoring is bypassed and the full
configuration is imported/exported. Use with care.

```
drush config:export --deactivate-config-ignore
drush config:import --deactivate-config-ignore
```

Notes:
- The pre-command hook only applies for Drush < 13.7 (newer Drush handles deactivation via its
  own `ConsoleDefinitionsEvent`).
- For a permanent bypass instead of a one-off flag, set
  `$settings['config_ignore_deactivate'] = TRUE;` in `settings.php`.
