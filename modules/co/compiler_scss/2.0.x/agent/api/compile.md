# Compiling SCSS from code

## Minimal example (inline SCSS)

```php
use Drupal\compiler\CompilerInputSource;

$compiler = \Drupal::service('plugin.manager.compiler')->createInstance('scss');
$css = $compiler->compile(new CompilerInputSource('$p: 10px; .box { padding: $p * 2; }'));
// => ".box {\n  padding: 20px;\n}\n"
```

`compile(CompilerInput ...$inputs): string` accepts **exactly one** input (it throws
`\RuntimeException('Exactly 1 input is expected')` for zero or many). A `CompilerInput` is either:

- `new CompilerInputSource($scss)` — inline SCSS source (this replaces 1.x's `CompilerInputDirect`).
- `new CompilerInputFile($absolutePath)` — a file whose contents are read (`file_get_contents`).

Both live in the `\Drupal\compiler` namespace. There is **no** `CompilerContext` and **no** options
array anymore — everything (import paths, variables, output style, etc.) is set via plugin setters
**before** calling `compile()`.

## Configure the compiler (setters, from `ScssInterface`)

All setters live on the plugin instance and take effect on the next `compile()`:

| Method | Purpose |
|---|---|
| `setVariable(string $id, mixed $value, bool $overwrite = FALSE): string` | Inject a Sass variable (`$id`). Value is auto-converted (see below). Returns the sanitized id. Throws `RuntimeException` if `$id` already set and `!$overwrite`. |
| `unsetVariable(string $id): void` | Remove a variable (always succeeds). |
| `setFunction(string $id, \Closure $cb, array $args = [], bool $overwrite = FALSE): string` | Register a Sass host function (see below). |
| `unsetFunction(string $id): void` | Remove a function. |
| `setImportPaths(string ...$paths): void` | Search paths for `@import`/`@use`. |
| `setOutputStyle(\ScssPhp\ScssPhp\OutputStyle $style): void` | `EXPANDED` (default) or `COMPRESSED`. |
| `setLogger(\ScssPhp\ScssPhp\Logger\LoggerInterface $logger): void` | Default logs warnings to `php://stderr`. |
| `setQuietDeps(bool $value): void` | Silence deprecations from imported stylesheets. |
| `setFatalDeprecations(\ScssPhp\ScssPhp\Deprecation ...$d): void` | Treat listed deprecations as fatal. |
| `setFutureDeprecations(...$d): void` / `setSilenceDeprecations(...$d): void` | Opt into early warnings / silence specific deprecations. |

`$id` for variables/functions is sanitized (`cleanIdentifier`): non-alphanumerics become hyphens,
lowercased, leading non-alpha and trailing hyphens stripped. An id that reduces to empty throws
`InvalidArgumentException`. The **returned** string is the id actually used.

## Inject variables

```php
$compiler->setVariable('brand', ['red' => 0, 'green' => 120, 'blue' => 255]); // -> Sass color
$compiler->setVariable('gap', ['value' => 16, 'unit' => 'px']);               // -> 16px
$compiler->setVariable('stack', ['Inter', 'sans-serif']);                     // -> comma Sass list
$compiler->setVariable('tokens', ['pad' => ['value' => 8, 'unit' => 'px']]);  // -> Sass map
$css = $compiler->compile(new CompilerInputSource('.x { color: $brand; gap: $gap; }'));
```

Conversion is performed by `compiler_scss.value_converter`
(`\Drupal\compiler_scss\ValueConverter::convertValueRecursive`):

- `null`→`null`, `bool`→boolean, `int`/`float`→unitless number, `string`→string.
- Array shaped `{red,green,blue[,alpha]}` (int 0–255, alpha float 0–1) → Sass color.
- Array shaped `{value, unit}` (float + string) → single-unit Sass number.
- List array → comma-separated, unbracketed Sass list; associative array → Sass map.
- `stdClass` is converted to an array recursively first. Unconvertible types throw
  `UnexpectedValueException`. To change list separator/bracketing, use Sass `list.join()`.

## Register PHP functions into SCSS (`setFunction`)

The closure must accept **either no parameters, or exactly one `array` parameter** (the list of
passed Sass `Value` objects); anything else throws `InvalidArgumentException`. Its return value is
auto-converted to a Sass value.

```php
$compiler->setFunction('sum', fn(array $a) => (float) (string) $a[0]->getValue() + (float) (string) $a[1]->getValue(), ['x', 'y']);
// usable as sum($x, $y) in SCSS
```

`$args` is a list of Sass argument declarations, validated/canonicalized by
`processFunctionArguments`:

- Each name must start with a letter, contain only letters/digits/hyphens, and not end in a hyphen.
- Suffix a name with `...` to make it variadic (`'items...'`); no declaration may follow a variadic one.
- Give a default with `name:sassValue` (e.g. `'size:10px'`); variadic args cannot have defaults.
  Invalid defaults throw `InvalidArgumentException`.

## What happens on compile

`Scss::compile()` builds a fresh `ScssPhp\ScssPhp\Compiler`, applies the injected variables and
functions, the import paths, logger, output style, and deprecation settings, then returns
`->compileString($source)->getCss()`. Any error throws rather than returning.

## The plugin, config-schema types & form elements

See [../plugins/plugin-and-schema.md](../plugins/plugin-and-schema.md).
