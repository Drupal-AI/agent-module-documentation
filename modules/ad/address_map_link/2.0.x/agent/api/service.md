<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build a map URL from an address in code

Use the `plugin.manager.map_link` service directly — no field formatter required.

```php
$manager = \Drupal::service('plugin.manager.map_link');

// List available providers as id => label (sorted).
$options = $manager->getDefinitionsOptionsList();

// Build a URL from an Address field item.
$address = $entity->field_address->first();          // \Drupal\address\AddressInterface
$plugin  = $manager->createInstance('google_maps_directions');
$url     = $plugin->getAddressUrl($address);         // \Drupal\Core\Url
$href    = $url->toString();
```

Example — expose a directions URL to a node template via `hook_ENTITY_TYPE_view()`:

```php
function my_module_node_view(array &$build, $entity, $display, $view_mode) {
  if (!$entity->field_address->isEmpty()) {
    $address = $entity->field_address->first();
    $manager = \Drupal::service('plugin.manager.map_link');
    $build['directions_url']['#markup'] = $manager
      ->createInstance('google_maps_directions')
      ->getAddressUrl($address)
      ->toString();
  }
}
```

Key methods:
- `MapLinkManager::getDefinitionsOptionsList(): array` — plugin id → human name, sorted (used to build
  the formatter dropdown).
- `MapLinkManager::getDefinition($id)` / `createInstance($id)` — standard plugin manager API.
- `MapLinkInterface::getAddressUrl(AddressInterface): Url` — the URL for that provider.
- `MapLinkInterface::getName(): string` — the provider's display name.
