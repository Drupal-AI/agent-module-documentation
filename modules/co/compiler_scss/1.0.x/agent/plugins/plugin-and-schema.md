# The compiler plugin, config-schema types & form elements

## The `scss` Compiler plugin

`\Drupal\compiler_scss\Plugin\Compiler\ScssCompiler` is annotated `@Compiler("scss")` — an
implementation of the **`compiler`** module's Compiler plugin type (manager
`plugin.manager.compiler`, interface `\Drupal\compiler\Plugin\CompilerPluginInterface`). This
module does **not** define a plugin type; it plugs into the one `compiler` provides.

The plugin is a thin forwarder: its `compile()` and any other call are proxied via `__call()` to
the backend service `compiler_scss.backend` (`ScssPhp`), throwing `BadMethodCallException` for
unknown methods and `RuntimeException` if the backend is unavailable.

Discover it live: `\Drupal::service('plugin.manager.compiler')->getDefinitions()` includes `scss`.

## Config-schema data types (`config/schema/compiler_scss.schema.yml`)

For storing typed style values in configuration:

| Type | Class | Use |
|---|---|---|
| `compiler_scss_color` | `Plugin\DataType\Color` | Hexadecimal color. |
| `compiler_scss_font_family` | `Config\Schema\FontFamily` (SequenceDataDefinition) | Font-family stack. |
| `compiler_scss_number` | `Config\Schema\Number` (+`NumberDataDefinition`) | SASS number. |
| `compiler_scss_unit` | `Plugin\DataType\Unit` | SASS unit. |

Reference these as the `type:` of a mapping key in your own module's config schema to validate
color/number/font values.

## Form elements (`src/Element/`, `FormElementBase`)

Matching render/form elements let editors author those values:

- `compiler_scss_color` (`ScssColor`) — a `color` input (plus enable checkbox).
- `compiler_scss_font_family` (`ScssFontFamily`) — a font-family stack builder.
- `compiler_scss_number` (`ScssNumber`) — a number input with a unit `select`.

Use them as `'#type' => 'compiler_scss_color'` (etc.) in a form to collect values that pair with
the schema types above — e.g. a theme-settings form feeding variables into a compile.
