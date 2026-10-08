# SCSS Compiler — agent index

Provides an `scss` compiler plugin for the **Compiler** module, backed by `scssphp/scssphp` v2
(pure PHP). Developer infrastructure: no admin UI, routes, permissions or settings
(`configure: null`). Requires the `compiler` module (`^2.0`), `scssphp/scssphp` (`^2.0`), and PHP 8.3+.

- **Compile SCSS from code — get the plugin, configure it, `setVariable()`/`setFunction()` PHP↔SCSS bridge** →
  [api/compile.md](api/compile.md)
- **The `#[Compiler('scss')]` plugin, its full setter API, config-schema types, form elements & Unit enums** →
  [plugins/plugin-and-schema.md](plugins/plugin-and-schema.md)

Key facts:
- Get the compiler: `\Drupal::service('plugin.manager.compiler')->createInstance('scss')` (plugin id `scss`,
  class `\Drupal\compiler_scss\Plugin\Compiler\Scss`, interface `ScssInterface`).
- Compile: `$css = $compiler->compile($input)` — pass **exactly one** `\Drupal\compiler\CompilerInput`
  (throws `RuntimeException` otherwise). Returns the CSS string; throws on error.
- Inputs: `new CompilerInputSource('$x:1; .a{color:$x}')` (inline) or `new CompilerInputFile('/abs/path.scss')`
  (contents read via `file_get_contents`). Both extend `\Drupal\compiler\CompilerInput`.
- Configure via setters (call before `compile()`): `setVariable($id,$value,$overwrite=FALSE)`,
  `setFunction($id,\Closure $cb,array $args=[],$overwrite=FALSE)`, `unsetVariable`/`unsetFunction`,
  `setImportPaths(...$paths)`, `setOutputStyle(OutputStyle)`, `setLogger(LoggerInterface)`,
  `setQuietDeps(bool)`, `setFatalDeprecations(...)`, `setFutureDeprecations(...)`, `setSilenceDeprecations(...)`.
- PHP→Sass value coercion is done by `compiler_scss.value_converter` (`\Drupal\compiler_scss\ValueConverter`):
  RGB(A) arrays → color, `{value,unit}` arrays → number, lists → comma Sass list, assoc arrays → map.
- Config-schema data types / form elements: `compiler_scss_color`, `compiler_scss_font_family`,
  `compiler_scss_number`, `compiler_scss_font_weight`. Unit enums: `\Drupal\compiler_scss\Unit`, `UnitGroup`.
- **Changed from 1.x:** no `CompilerContext`, no `compiler_scss.backend` service / service provider, no
  `registerFunction()`, no `compiler_scss_unit` schema type. Compile takes one input, not an options+inputs context.
