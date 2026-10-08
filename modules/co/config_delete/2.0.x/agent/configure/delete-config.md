# The Config Delete form

## Route & access

- Route `config_delete.delete` → **`/admin/config/development/configuration/delete`**.
- Shown as a **Delete** local task + menu link under core *Configuration synchronization*
  (`config.sync`).
- Permission **`delete configuration`** (defined by the module, `restrict access: true` — treat
  as a trusted-admin permission).

## What the form does

`Drupal\config_delete\Form\ConfigDeleteForm` extends core `ConfigSingleExportForm`, so it keeps
the two selects:

- **Configuration type** (`config_type`) — `system.simple` for simple config, or a config
  entity type (e.g. `view`, `image_style`, `field_config`).
- **Configuration name** (`config_name`) — the specific object of that type.

`config_delete_form_alter()` then: removes the export textarea, adds a **Delete config
dependencies** checkbox (`delete_dependencies`), swaps in a **Delete** submit button, and shows
a warning that deleting config can break the site.

## How it resolves the name and deletes

```php
// submitForm(), paraphrased:
if ($config_type !== 'system.simple') {
  $name = $entityTypeManager->getDefinition($config_type)->getConfigPrefix() . '.' . $config_name;
} else {
  $name = $config_name;                       // simple config uses the raw name
}
if ($delete_dependencies) {
  foreach (\Drupal::configFactory()->get($name)->get('dependencies')['config'] ?? [] as $dep) {
    \Drupal::configFactory()->getEditable($dep)->delete();
  }
}
\Drupal::configFactory()->getEditable($name)->delete();
```

So for a config entity the effective name is `<config_prefix>.<config_name>` (e.g. entity type
`image_style` → prefix `image.style` → `image.style.thumbnail`); for `system.simple` the name
is used verbatim (e.g. `system.site`).

## Equivalent without the UI

The module has **no Drush command**. The same effect from code / drush:

```php
// Delete one simple config object.
\Drupal::configFactory()->getEditable('mymodule.settings')->delete();
```

```bash
drush config:delete mymodule.settings    # core drush equivalent for simple config
```

## Caveats

- Deleting config that other config/modules depend on **can break the site** — the "Delete
  config dependencies" option deletes the object's own `dependencies.config` entries, not the
  reverse (things that depend on *it*).
- The module ships no schema and no default config; it is purely this delete form + permission.
