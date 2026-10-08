SCSS Compiler provides an `scss` compiler plugin for the Compiler module, turning SCSS source into CSS at runtime using the pure-PHP `scssphp/scssphp` library — no Node.js or external toolchain required.

---

The module registers a single Compiler plugin, `@Compiler("scss")` (`ScssCompiler`), for the `compiler` module's plugin type, and backs it with a swappable backend service `compiler_scss.backend` (registered by a service provider; currently the `ScssPhp` implementation wrapping `scssphp/scssphp`). You compile by getting the plugin from `plugin.manager.compiler` (`createInstance('scss')`) and calling `compile()` with a `CompilerContext` that carries your inputs (`CompilerInputDirect` for inline SCSS, `CompilerInputFile` for files) and options (e.g. `import_path`); it returns the compiled CSS string. The plugin forwards all calls to the backend, whose extra power is `registerFunction()`: it bridges native PHP callables into the SCSS compiler as SASS functions (with automatic argument/return type juggling between colors, numbers/units, lists, maps, strings and booleans), so themes/modules can expose data to stylesheets. It also ships Drupal config-schema data types and matching form elements for authoring style values as configuration: `compiler_scss_color` (hex color + form `color` widget), `compiler_scss_font_family`, `compiler_scss_number` and `compiler_scss_unit` (SASS number with a unit). The module has no admin UI, routes, permissions or settings of its own — it is developer infrastructure meant to be driven from code (typically by a theme or a configuration-driven design-token module). Requires PHP 8.3+, the `compiler` module and `scssphp/scssphp`.

---

- Compile SCSS to CSS in PHP without Node, `sass`, or a build step.
- Turn a theme's SCSS partials into CSS at runtime from a `compiler` context.
- Compile an inline SCSS snippet (`CompilerInputDirect`) to a CSS string.
- Compile a SCSS file (`CompilerInputFile`) with an `import_path` for `@import`/`@use` resolution.
- Provide a compiler backend to the Compiler module's plugin system via `@Compiler("scss")`.
- Expose PHP values to SCSS by registering PHP callables as SASS functions with `registerFunction()`.
- Bridge a Drupal color value into SCSS and get proper color type handling back.
- Feed configurable design tokens (colors, numbers, fonts) into a compiled stylesheet.
- Store a hex color in configuration using the `compiler_scss_color` schema type + form element.
- Store a SASS number-with-unit (e.g. `16px`) in config using `compiler_scss_number`/`compiler_scss_unit`.
- Collect a font-family stack from an admin form using the `compiler_scss_font_family` element.
- Build a theme settings form where editors pick colors/sizes that recompile the CSS.
- Swap the SCSS backend implementation by overriding the `compiler_scss.backend` service.
- Generate per-tenant or per-brand CSS from shared SCSS with different variables.
- Recompile CSS when configuration changes instead of shipping pre-built assets.
- Validate that a compiled stylesheet is correct by asserting on the returned CSS string.
- Support Sass variables, nesting, mixins and functions in Drupal-authored stylesheets.
- Let a design-token module hand off numeric/color values to SCSS safely typed.
- Avoid committing compiled CSS by compiling on demand behind a cache.
- Prototype SCSS output quickly from a `drush php:eval` one-liner.
- Provide type-safe SASS/PHP interop (numbers, units, lists, maps, booleans) for advanced functions.
