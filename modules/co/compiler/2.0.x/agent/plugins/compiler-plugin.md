<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Define a compiler plugin

The `compiler` module registers a plugin type. To add a compiler you create a plugin class in
your own module — the `compiler` module provides only the manager, base class, attribute,
annotation, and interface.

## The plugin type wiring (provided by this module)

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.compiler` |
| Manager class | `Drupal\compiler\Plugin\CompilerPluginManager` (`final`, extends `DefaultPluginManager`, implements `CompilerPluginManagerInterface`) |
| Discovery subdir | `Plugin/Compiler` (i.e. `<module>/src/Plugin/Compiler/`) |
| Attribute | `Drupal\compiler\Attribute\Compiler` — extends `Plugin`, `TARGET_CLASS`, written `#[Compiler('id')]` |
| Annotation (legacy) | `Drupal\compiler\Annotation\Compiler` — a `PluginID`, written `@Compiler("id")` |
| Plugin interface | `Drupal\compiler\Plugin\CompilerPluginInterface` |
| Base class | `Drupal\compiler\Plugin\CompilerPluginBase` (extends `PluginBase`) |
| Alter hook | `hook_compiler_plugin_alter(array &$definitions)` |
| Cache bin | `compiler_info` |

The `services.yml` for the manager is simply:

```yaml
services:
  plugin.manager.compiler:
    class: '\Drupal\compiler\Plugin\CompilerPluginManager'
    parent: default_plugin_manager
```

Both attribute and annotation discovery are wired (the manager passes both to
`DefaultPluginManager`), so either form works; prefer the `#[Compiler('id')]` attribute.

## Minimal plugin

`your_module/src/Plugin/Compiler/UppercaseCompiler.php`:

```php
namespace Drupal\your_module\Plugin\Compiler;

use Drupal\compiler\CompilerInput;
use Drupal\compiler\Plugin\CompilerPluginBase;

#[\Drupal\compiler\Attribute\Compiler('uppercase')]
final class UppercaseCompiler extends CompilerPluginBase {

  public function compile(CompilerInput ...$inputs): mixed {
    $out = '';
    foreach ($inputs as $input) {
      // getSource() returns the file contents (CompilerInputFile) or the raw
      // string (CompilerInputSource) — always a string.
      $out .= strtoupper($input->getSource());
    }
    return $out; // Throw an exception on error rather than returning one.
  }
}
```

The plugin id is the `#[Compiler('...')]` value. After adding the class, rebuild caches
(`drush cr`) so the manager discovers it.

## The `compile()` contract

`CompilerPluginInterface::compile(CompilerInput ...$inputs): mixed` receives a **variadic**
list of `CompilerInput` value objects and returns the compiled result (any type). There is no
context, options, or data object in 2.0 — pass inputs directly. On an error state a compiler
should **throw** (the interface documents `@throws \Throwable`), not return an error value.

Plugin authors are encouraged to **extend the interface** to narrow the signature for their
consumers, e.g.:

```php
interface PrefixCalculatorInterface extends CompilerPluginInterface {
  public function compile(CompilerInput ...$inputs): int|float;
}
```

## Altering discovered definitions

```php
function my_module_compiler_plugin_alter(array &$definitions) {
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
