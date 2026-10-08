# Drush integration

The module does **not** add a standalone `drush plugin:*` command. Instead it hooks into
Drush's cache-clear system (`drush.services.yml` → `plugin.commands`,
`Drupal\plugin\Commands\PluginCommands`).

## `plugin-types` cache-clear target

`PluginCommands::cacheClear()` registers an extra bootstrapped cache-clear type named
`plugin-types`. Running the Drush cache-clear for that type calls `clearPluginTypeCaches()`,
which clears cached plugin definitions for one or all registered plugin types (only managers
implementing `CachedDiscoveryInterface`).

```bash
# Clear all plugin-type caches:
drush cache:clear plugin-types
# Clear a specific type (extra arg = plugin type id):
drush cache:clear plugin-types condition
```

Passing an unknown plugin type id throws `Plugin type "<id>" does not exist.`

That is the entirety of the module's Drush surface — one cache-clear callback backed by the
`plugin.plugin_type_manager` service.
