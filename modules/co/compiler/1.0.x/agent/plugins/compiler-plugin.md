<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Define a compiler plugin

The `compiler` module registers a plugin type. To add a compiler you create a plugin class in
your own module — the `compiler` module provides only the manager, base class, annotation, and
interface.

## The plugin type wiring (provided by this module)

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.compiler` |
| Manager class | `Drupal\compiler\Plugin\CompilerPluginManager` (extends `DefaultPluginManager`) |
| Discovery subdir | `Plugin/Compiler` (i.e. `<module>/src/Plugin/Compiler/`) |
| Annotation | `Drupal\compiler\Annotation\Compiler` — a `PluginID`, written `@Compiler("id")` |
| Plugin interface | `Drupal\compiler\Plugin\CompilerPluginInterface` |
| Base class | `Drupal\compiler\Plugin\CompilerPluginBase` (extends `PluginBase`) |
| Alter hook | `hook_compiler_info(array &$definitions)` |
| Cache bin | `compiler_plugins` |

The `services.yml` for the manager is simply:

```yaml
services:
  plugin.manager.compiler:
    class: '\Drupal\compiler\Plugin\CompilerPluginManager'
    parent: default_plugin_manager
```

## Minimal plugin

`your_module/src/Plugin/Compiler/UppercaseCompiler.php`:

```php
namespace Drupal\your_module\Plugin\Compiler;

use Drupal\compiler\CompilerContextInterface;
use Drupal\compiler\Plugin\CompilerPluginBase;

/**
 * @Compiler("uppercase")
 */
class UppercaseCompiler extends CompilerPluginBase {

  public function compile(CompilerContextInterface $context) {
    $out = '';
    foreach ($context->getInputs() as $input) {
      // $input is a CompilerInputInterface; ->get() is a file path or raw value.
      $out .= strtoupper(file_get_contents($input->get()));
    }
    return $out; // Throw an exception on error rather than returning one.
  }
}
```

The plugin id is the `@Compiler("...")` value (a `PluginID` annotation — the annotation carries
only the id, no other keys). After adding the class, rebuild caches (`drush cr`) so the manager
discovers it.

## The `compile()` contract

`CompilerPluginInterface::compile(CompilerContextInterface $context)` returns the compiled
result (any type — usually a string of bytes). Optional per-compiler parameters should be read
from the context's options/data rather than added as method arguments unless officially
supported. On an error state a compiler should **throw**, not return an error value.

## Altering discovered definitions

```php
function my_module_compiler_info(array &$definitions) {
  // Add, remove, or tweak compiler plugin definitions.
  unset($definitions['uppercase']);
}
```

## Verifying registration

```php
$manager = \Drupal::service('plugin.manager.compiler');
$manager->hasDefinition('uppercase');          // TRUE once discovered
array_keys($manager->getDefinitions());        // all registered compiler ids
$manager->createInstance('uppercase');         // a CompilerPluginInterface instance
```
