<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ScssCompiler plugin type

The module defines a plugin type **`scss_compiler`** so each source language has a pluggable
backend.

- Manager service: `plugin.manager.scss_compiler`
  (`ScssCompilerPluginManager extends DefaultPluginManager`).
- Discovery: annotation `@ScssCompilerPlugin` in namespace `Plugin/ScssCompiler`.
- Interface: `ScssCompilerPluginInterface`; base class `ScssCompilerPluginBase`.
- Alter hook: `hook_scss_compiler_info_alter`; cache bin key `scss_compiler_info_plugins`.
- Get an instance: `\Drupal::service('plugin.manager.scss_compiler')->getInstanceById($id)`.

## Shipped compilers

| Plugin id | Class | Handles |
|---|---|---|
| `scss_compiler_scssphp` | `ScssphpCompiler` | `.scss` (default; bundled scssphp lib) |
| `scss_compiler_lessphp` | `LessphpCompiler` | `.less` |
| `scss_compiler_libsass` | `LibsassCompiler` | `.scss` via libsass, if available |

Which plugin runs for a file comes from `scss_compiler.settings:plugins`
(extension → plugin id). Only extensions listed there are compiled.

## Annotation fields

`@ScssCompilerPlugin` (`Drupal\scss_compiler\Annotation\ScssCompilerPlugin`): `id`, `name`,
`description`, and `extensions` (a map of file extension → internal type), e.g. the scssphp
plugin declares `extensions = { "scss" = "scss" }`.

## Writing a compiler plugin

```php
namespace Drupal\my_module\Plugin\ScssCompiler;

use Drupal\scss_compiler\ScssCompilerPluginBase;

/**
 * @ScssCompilerPlugin(
 *   id = "my_compiler",
 *   name = "My Compiler",
 *   description = "Compiles .mycss",
 *   extensions = { "mycss" = "mycss" }
 * )
 */
class MyCompiler extends ScssCompilerPluginBase {

  public function init() { /* set up the underlying parser */ }

  public static function getVersion() { /* return lib version or FALSE */ }
  public static function getStatus()  { /* return TRUE or an error message */ }

  // Return the compiled CSS string for a source file.
  public function compile(array $scss_file) {
    $source = file_get_contents($scss_file['source_path']);
    return /* compiled css */;
  }

  // Return the newest mtime among the source and its @imports.
  public function checkLastModifyTime(array &$source_file) { /* ... */ }
}
```

Then register the extension so it is used:
`drush cset scss_compiler.settings plugins.mycss my_compiler -y`. `compile()` receives the
`$scss_file` info array (see [api/service.md](../api/service.md)); the service writes the
returned string to `css_path`.
