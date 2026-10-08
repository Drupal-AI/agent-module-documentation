# Compiling SCSS from code

## Minimal example (inline SCSS)

```php
use Drupal\compiler\CompilerContext;
use Drupal\compiler\CompilerInputDirect;

$compiler = \Drupal::service('plugin.manager.compiler')->createInstance('scss');
$context  = new CompilerContext('scss', [], [
  new CompilerInputDirect('$p: 10px; .box { padding: $p * 2; }'),
]);
$css = $compiler->compile($context);
// => ".box {\n  padding: 20px;\n}\n"
```

`CompilerContext(string $compiler, array $options = [], array $inputs = [], $data = NULL)`:
- `$compiler` — the plugin id (`'scss'`).
- `$inputs` — array of `CompilerInputInterface`; multiple inputs are concatenated (CRLF) before
  compiling. Use `CompilerInputDirect($scss)` for inline source or
  `CompilerInputFile($absolutePath)` for a file (its contents are read).
- `$options` — associative; `import_path` sets the SCSS `@import`/`@use` search path
  (absolute, or theme-relative when a theme compiler context is used).

## What happens

`ScssCompiler::compile()` forwards to the backend (`compiler_scss.backend`). `ScssPhp::compile()`
creates a `ScssPhp\ScssPhp\Compiler`, sets the import path, registers any bridged PHP functions,
then returns `->compileString($source)->getCss()`. Any error throws instead of returning.

## Bridge PHP functions into SCSS (`registerFunction`)

The backend can expose native PHP callables as SASS functions:

```php
$backend = \Drupal::service('compiler_scss.backend');
$backend->registerFunction(fn($a, $b) => $a + $b, 'add_two');   // usable as add_two($x, $y) in SCSS
// A named (non-closure) callable takes the function's own short name if $name is omitted.
```

Rules (`BackendBase::registerFunction`): the name must match `/^[a-zA-Z_][a-zA-Z0-9_]*$/`; optional
and pass-by-reference parameters are not supported; the SASS signature is derived from the PHP
parameter names (`$paramName`). Register functions **before** the first compile. Arguments and
return values are auto-converted between the languages (colors ↔ hex, numbers ↔ unit-aware
`Number`, lists/maps ↔ arrays, strings, booleans, null).

## Swapping the backend

`compiler_scss.backend` is registered by `CompilerScssServiceProvider` (currently `ScssPhp`).
Override that service to provide an alternative backend that implements
`\Drupal\compiler_scss\BackendInterface`.
