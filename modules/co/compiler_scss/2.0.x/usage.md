SCSS Compiler provides an `scss` compiler plugin for the Compiler module, turning SCSS source into CSS at runtime using the pure-PHP `scssphp/scssphp` (v2) library — no Node.js or external toolchain required.

---

The module registers a single Compiler plugin, `#[Compiler('scss')]` (class `\Drupal\compiler_scss\Plugin\Compiler\Scss`), for the `compiler` module's plugin type. You obtain it from `plugin.manager.compiler` (`createInstance('scss')`), configure it through setter methods, then call `compile()` with exactly one `CompilerInput` (`\Drupal\compiler\CompilerInputSource` for inline SCSS or `\Drupal\compiler\CompilerInputFile` for a file); it returns the compiled CSS string and throws on any error. Unlike 1.x there is no `CompilerContext`, no backend service and no `registerFunction()` — the plugin wraps `ScssPhp\ScssPhp\Compiler` directly and exposes a rich typed API: `setVariable()`/`unsetVariable()` inject Sass variables, `setFunction()`/`unsetFunction()` register PHP closures as Sass host functions, plus `setImportPaths()`, `setOutputStyle()` (an `OutputStyle` enum, default `EXPANDED`), `setLogger()`, `setQuietDeps()`, `setFatalDeprecations()`, `setFutureDeprecations()` and `setSilenceDeprecations()`. PHP values passed to `setVariable()`/`setFunction()` are auto-converted to Sass values by the `compiler_scss.value_converter` service (`ValueConverter`): null/bool/int/float/string map to their Sass equivalents, RGB(A) arrays coerce to colors, `{value, unit}` arrays to single-unit numbers, lists to comma-separated Sass lists and associative arrays to Sass maps. It also ships Drupal config-schema data types and matching form elements for authoring style values as configuration: `compiler_scss_color` (RGB(A) mapping + color widget), `compiler_scss_font_family` (font stack textarea), `compiler_scss_number` (value + unit, driven by the `Unit`/`UnitGroup` enums) and `compiler_scss_font_weight` (1–1000). The module has no admin UI, routes, permissions or settings of its own — it is developer infrastructure meant to be driven from code (typically a theme or a configuration-driven design-token module). Requires PHP 8.3+, the `compiler` module (`^2.0`) and `scssphp/scssphp` `^2.0`.

---

- Compile SCSS to CSS in PHP without Node, `sass`, or a build step.
- Turn a theme's SCSS partials into CSS at runtime from a compiler plugin.
- Compile an inline SCSS snippet (`CompilerInputSource`) to a CSS string.
- Compile a SCSS file (`CompilerInputFile`) with import paths for `@import`/`@use` resolution.
- Provide an `scss` compiler implementation to the Compiler module's plugin system via `#[Compiler('scss')]`.
- Inject Sass variables from PHP with `setVariable($name, $value)` before compiling.
- Expose PHP logic to SCSS by registering closures as Sass host functions with `setFunction()`.
- Register a variadic or defaulted Sass function using argument declarations like `'x'`, `'y:10px'`, `'args...'`.
- Bridge a Drupal color into SCSS by passing an RGB(A) array — auto-coerced to a Sass color.
- Feed configurable design tokens (colors, numbers, fonts) into a compiled stylesheet.
- Pass a `{value, unit}` array as a variable to get a unit-aware Sass number.
- Hand a PHP associative array to SCSS as a Sass map, or a list as a comma-separated Sass list.
- Store a color in configuration using the `compiler_scss_color` schema type + form element.
- Store a Sass number-with-unit (e.g. `16px`) in config using `compiler_scss_number`.
- Store a font-family stack with `compiler_scss_font_family` and a font weight (1–1000) with `compiler_scss_font_weight`.
- Restrict a number form element's units to a group (e.g. lengths, angles, times) via `#units` and the `UnitGroup` enum.
- Build a theme-settings form where editors pick colors/sizes that recompile the CSS.
- Control output formatting by setting `OutputStyle::COMPRESSED` vs `EXPANDED`.
- Treat, silence, or opt into early warnings for Sass deprecations via the deprecation setters.
- Route compiler log output to a custom `LoggerInterface` with `setLogger()`.
- Generate per-tenant or per-brand CSS from shared SCSS with different injected variables.
- Recompile CSS when configuration changes instead of shipping pre-built assets.
- Validate that a compiled stylesheet is correct by asserting on the returned CSS string.
- Support Sass variables, nesting, mixins and functions in Drupal-authored stylesheets.
- Let a design-token module hand off numeric/color values to SCSS safely typed.
- Avoid committing compiled CSS by compiling on demand behind a cache.
- Prototype SCSS output quickly from a `drush php:eval` one-liner.
