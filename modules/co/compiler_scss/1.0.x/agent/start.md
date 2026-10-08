# SCSS Compiler — agent index

Provides an `scss` compiler plugin for the **Compiler** module, backed by `scssphp/scssphp`
(pure PHP). Developer infrastructure: no admin UI, routes, permissions or settings
(`configure: null`). Requires the `compiler` module, `scssphp/scssphp`, and PHP 8.3+.

- **Compile SCSS from code, the plugin/backend/service, `registerFunction()` PHP↔SCSS bridge** →
  [api/compile.md](api/compile.md)
- **The `@Compiler("scss")` plugin, config-schema types & form elements it adds** →
  [plugins/plugin-and-schema.md](plugins/plugin-and-schema.md)

Key facts:
- Get the compiler: `\Drupal::service('plugin.manager.compiler')->createInstance('scss')` (plugin id `scss`).
- Compile: `$css = $compiler->compile($context)` where `$context` is a
  `\Drupal\compiler\CompilerContext('scss', $options, $inputs)`.
- Inputs: `CompilerInputDirect('$x:1; .a{}')` (inline) or `CompilerInputFile('/path.scss')`.
- Backend service: `compiler_scss.backend` → `\Drupal\compiler_scss\Backend\ScssPhp` (registered by
  `CompilerScssServiceProvider`, swappable).
- Bridge PHP into SCSS: backend `registerFunction(callable $cb, ?string $name)`.
- Config-schema data types / form elements: `compiler_scss_color`, `compiler_scss_font_family`,
  `compiler_scss_number`, `compiler_scss_unit`.
