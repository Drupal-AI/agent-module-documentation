<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — the Flysystem `@Adapter` plugin type

Flysystem defines **one plugin type**: an *adapter* that wires a League\Flysystem adapter
into Drupal.

- Plugin manager service: `plugin.manager.flysystem`
  (`Drupal\flysystem\Plugin\FlysystemPluginManager`, plugin namespace `Flysystem`).
- Annotation: `Drupal\flysystem\Annotation\Adapter` → `@Adapter(id = "...", extensions = {...})`.
  `extensions` lists required PHP extensions; if any is missing the plugin is dropped.
- Interface every plugin implements: `Drupal\flysystem\Plugin\FlysystemPluginInterface`.
- Discovery dir: a module's `src/Flysystem/`.
- Fallback: unknown driver → plugin id `missing` (`getFallbackPluginId()`).

## Interface

```php
interface FlysystemPluginInterface {
  public function getAdapter();                 // return a League\Flysystem\AdapterInterface
  public function getExternalUrl($uri);         // browser URL for scheme://... (or download URL)
  public function ensure($force = FALSE);       // health check: array of {severity,message,context}
}
```

Plugins usually also implement `ContainerFactoryPluginInterface::create()` to pull `root`,
`public`, etc. out of `$configuration` (the scheme's `config` array from settings.php).
Reusable traits: `FlysystemUrlTrait` (default `getExternalUrl()` → `/_flysystem/...`) and
`ImageStyleGenerationTrait`.

## Minimal skeleton

```php
namespace Drupal\my_module\Flysystem;

use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\flysystem\Plugin\FlysystemPluginInterface;
use Drupal\flysystem\Plugin\FlysystemUrlTrait;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * @Adapter(id = "mybackend", extensions = {})
 */
class MyBackend implements FlysystemPluginInterface, ContainerFactoryPluginInterface {
  use FlysystemUrlTrait;
  public static function create(ContainerInterface $c, array $configuration, $id, $def) {
    return new static($configuration);
  }
  public function __construct(protected array $config) {}
  public function getAdapter() { /* return new SomeLeagueAdapter($this->config); */ }
  public function ensure($force = FALSE) { return []; }
}
```

Then a site references it: `'driver' => 'mybackend'` in `$settings['flysystem']`.
See the core `Local` plugin (`src/Flysystem/Local.php`) for a complete real example.
