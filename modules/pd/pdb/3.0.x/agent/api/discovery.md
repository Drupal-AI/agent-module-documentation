# PDB component discovery API

## Service `pdb.component_discovery`

Class `Drupal\pdb\ComponentDiscovery` (`ComponentDiscoveryInterface`), extends core
`ExtensionDiscovery`. Public, constructed with `%app.root%`, `@event_dispatcher`, `@module_handler`.

```php
$components = \Drupal::service('pdb.component_discovery')->getComponents();
// Returns Extension[] keyed by component name; each has ->info (parsed *.info.yml + 'path')
// merged with defaults ['dependencies' => [], 'description' => '', 'version' => NULL].
```

`getComponents()` scans for `type: pdb` extensions, parses each info file, then invokes
`hook_component_info_alter($components)` before returning.

## Where it scans (`scan()`)

1. `Settings::get('pdb_search_dirs', [])` from `settings.php` (string or array of paths relative to
   the Drupal root).
2. A `PdbDiscoveryEvent` (`PdbDiscoveryEvent::SEARCH_DIRS` = `pdb.search_dirs`) is dispatched with
   those dirs; subscribers may `getDirs()`/`setDirs()` to add or replace them.
3. If the resulting list is **empty**, PDB falls back to core's global extension scan
   (`globalDiscovery = TRUE`) — the whole install is searched.
4. Otherwise only the given dirs are scanned (`scanDirectory()`), honoring
   `Settings::get('file_scan_ignore_directories')` and a PDB-specific filter
   (`Discovery\PdbRecursiveExtensionFilterCallback`) whose skipped folders include `vendor`, `lib`,
   `assets`, `css`, `js`, `images`, `templates`, `fixtures`, etc.

Restrict scanning for performance:

```php
// settings.php
$settings['pdb_search_dirs'] = ['sites/default/components', 'web/libraries/my-components'];
```

## Alter discovered components — `hook_component_info_alter()`

```php
/**
 * Implements hook_component_info_alter().
 *
 * @param \Drupal\Core\Extension\Extension[] $components
 *   Discovered PDB components; mutate $component->info as needed.
 */
function mymodule_component_info_alter(array &$components) {
  if (isset($components['hello'])) {
    $components['hello']->info['category'] = 'Featured';
    $components['hello']->info['presentation'] = 'react';
  }
}
```

## Add search dirs via an event subscriber

```php
use Drupal\pdb\Event\PdbDiscoveryEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyPdbDirsSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [PdbDiscoveryEvent::SEARCH_DIRS => 'onSearchDirs'];
  }
  public function onSearchDirs(PdbDiscoveryEvent $event): void {
    $dirs = $event->getDirs();
    $dirs[] = 'modules/custom/my_components';
    $event->setDirs($dirs);
  }
}
```

`ComponentDiscovery` is also what `PdbBlockDeriver::getDerivativeDefinitions()` calls to build one
block derivative per component (skipping `status: disabled`), attaching the parsed `info`,
`admin_label` (component `name`), `max-age: 0`, optional `category`, and `context_definitions`
built from the component's `contexts`.
