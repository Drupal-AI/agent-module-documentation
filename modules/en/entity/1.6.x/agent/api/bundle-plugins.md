# Code-defined bundles (bundle plugins)

Lets a module define an entity type's bundles — and their fields — entirely in code, instead
of as config. The entity type declares a `bundle_plugin_type` and a `bundle_plugin` handler
(`Drupal\entity\BundlePlugin\BundlePluginHandler`); each bundle is a plugin implementing:

```php
interface BundlePluginInterface extends PluginInspectionInterface {
  // Field names must be unique across ALL bundles; prefix with the plugin ID.
  public function buildFieldDefinitions(); // BundleFieldDefinition[] keyed by field name
}
```

Example plugin:

```php
class Subscription extends PluginBase implements BundlePluginInterface {
  public function buildFieldDefinitions() {
    $fields['subscription_amount'] = BundleFieldDefinition::create('decimal')
      ->setLabel('Amount')
      ->setRequired(TRUE);
    return $fields;
  }
}
```

- `BundleFieldDefinition` implements both storage and field definition interfaces, so a plugin
  returns a single array (unlike core's split `hook_entity_bundle_field_info` /
  `hook_entity_field_storage_info`).
- `entity.bundle_plugin_installer` service creates/removes the bundles' field storage when the
  providing module is installed/uninstalled; `BundlePluginUninstallValidator` blocks
  uninstall while bundle content exists.
- Discover the handler via `$entity_type_manager->getHandler($entity_type_id, 'bundle_plugin')`.
