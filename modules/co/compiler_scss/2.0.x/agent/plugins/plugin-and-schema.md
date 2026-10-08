# The compiler plugin, config-schema types, form elements & Unit enums

## The `scss` Compiler plugin

`\Drupal\compiler_scss\Plugin\Compiler\Scss` is attributed `#[Compiler('scss')]` — an implementation
of the **`compiler`** module's Compiler plugin type (manager `plugin.manager.compiler`, base
`\Drupal\compiler\Plugin\CompilerPluginBase`). It implements `ContainerFactoryPluginInterface` and
`\Drupal\compiler_scss\Plugin\Compiler\ScssInterface` (which extends the compiler module's
`CompilerPluginInterface`). This module does **not** define a plugin type; it plugs into the one
`compiler` provides.

Unlike 1.x it is **not** a thin `__call` forwarder to a backend service — there is no
`compiler_scss.backend` service and no `CompilerScssServiceProvider`. The plugin wraps
`ScssPhp\ScssPhp\Compiler` directly and injects only `compiler_scss.value_converter` (the sole
service in `compiler_scss.services.yml`). See [../api/compile.md](../api/compile.md) for `compile()`
and the full setter API (`setVariable`, `setFunction`, `setImportPaths`, `setOutputStyle`, logger and
deprecation setters).

Discover it live: `\Drupal::service('plugin.manager.compiler')->getDefinitions()` includes `scss`.

## Config-schema data types (`config/schema/compiler_scss.schema.yml`)

For storing typed style values in configuration. Reference these as the `type:` of a mapping key in
your own module's config schema.

| Type | Shape | Notes |
|---|---|---|
| `compiler_scss_color` | mapping `{red,green,blue: int 0–255, alpha?: float 0–1}` | RGB(A) color. (In 1.x this was a hex string.) |
| `compiler_scss_font_family` | sequence of non-blank strings | Font-family stack; `FullyValidatable`. |
| `compiler_scss_font_weight` | integer 1–1000 | Font weight (new in 2.0). |
| `compiler_scss_number` | mapping `{value: float, unit: string}` | Sass number; `unit` constrained to a `Choice` of CSS units (`px`, `em`, `rem`, `%`, `deg`, `s`, …). |

The 1.x `compiler_scss_unit` type has been **removed**; the unit now lives inside
`compiler_scss_number` and is enumerated by the `Unit` enum (below).

## Form elements (`src/Element/`)

Matching render/form elements let editors author those values. Use them as
`'#type' => 'compiler_scss_color'` (etc.) in a form.

- **`compiler_scss_color`** (`Element\Color`, extends `FormElementBase`) — an "enable" checkbox plus a
  `color` input. Value is `null` when disabled, otherwise `{red,green,blue}` (parsed from the `#rrggbb`
  hex via `sscanf`). Honors `#required`/`#default_value`.
- **`compiler_scss_font_family`** (`Element\FontFamily`, extends core `Textarea`) — one font name per
  line; validation splits on newlines into a list of names (or `null` if empty).
- **`compiler_scss_number`** (`Element\Number`, extends `FormElementBase`) — a `number` input plus a
  unit `select`. Supports `#min`/`#max`/`#step` and `#units` (see enums). Value is `{value, unit}` or
  `null`. If only one unit is allowed, the select is collapsed to that unit.
- **`compiler_scss_font_weight`** (`Element\FontWeight`, extends core `Number`) — an integer input
  clamped to 1–1000 (`#min`/`#max`/`#step` forced).

## Unit enums (`src/Unit.php`, `src/UnitGroup.php`, both `@api`)

`\Drupal\compiler_scss\Unit` is a backed string enum of CSS units — case names are descriptive, values
are the CSS units (`Unit::Pixels = 'px'`, `Unit::RootElementFontSize = 'rem'`,
`Unit::ElementFontSize = 'em'`, `Unit::Percent = '%'`, plus angles, frequencies, resolutions, times,
etc.); each case has a translated `label()`. `\Drupal\compiler_scss\UnitGroup` groups them
(`Absolute`, `Angle`, `Frequency`, `Length`, `LengthPercent`, `Relative`, `Resolution`, `Time`);
`$group->units()` returns that group's `Unit` list and `UnitGroup::options(...$units)` builds a
`value => label` options array.

Set a number element's allowed units by passing a `UnitGroup`, a single `Unit`, or a list of `Unit`
to `#units`:

```php
$form['size'] = [
  '#type'  => 'compiler_scss_number',
  '#units' => \Drupal\compiler_scss\UnitGroup::Length,   // or Unit::Pixels, or [Unit::ElementFontSize, Unit::RootElementFontSize]
];
```
