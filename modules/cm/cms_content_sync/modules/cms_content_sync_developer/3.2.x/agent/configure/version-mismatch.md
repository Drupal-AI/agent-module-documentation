# The `cms_content_sync.developer` config

No admin settings form. This submodule owns one simple config object that holds transient state,
written and read by its event subscribers (see [../events/version-warnings.md](../events/version-warnings.md)).

## Config object

| Key | Type | Meaning |
|---|---|---|
| `version_mismatch` | map (flow id → flow label) | Flows detected as having an out-of-date entity-type definition. Empty on install (`config/install/cms_content_sync.developer.yml` ships `version_mismatch: {}`). |

The map is appended to (deduplicated) whenever a synced bundle's config changes, and cleared
per-flow when you run `drush csuf` (which calls `Flow::resetVersionWarning()`).

### Read / clear with Drush or PHP

```bash
# Inspect which flows are currently flagged
drush config:get cms_content_sync.developer version_mismatch

# Manually clear the flag map (normally cleared by "drush csuf")
drush config:set cms_content_sync.developer version_mismatch '{}'
```

```php
// Read
$flags = \Drupal::config('cms_content_sync.developer')->get('version_mismatch');

// Clear
\Drupal::configFactory()->getEditable('cms_content_sync.developer')
  ->set('version_mismatch', [])->save();
```

## config_ignore integration

`cms_content_sync_developer.module` implements `hook_config_ignore_settings_alter()` and adds
`cms_content_sync.developer:version_mismatch` to the ignore list. That is why `config_ignore` is a
hard dependency: the flag map is per-environment runtime state and must not be captured by
`drush config:export` or overwritten by `drush config:import`.

## Install / uninstall

- `hook_install()` sets the module weight to `100` and rebuilds caches so its subscribers run
  after the parent module's.
- `hook_uninstall()` deletes the `cms_content_sync.developer` object.
- No `config/schema` is shipped by this submodule.
