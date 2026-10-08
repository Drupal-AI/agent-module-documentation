# UI Skins — plugin types

Two YAML-discovered plugin types. Declare them in a **module or theme** root as
`{provider}.ui_skins.css_variables.yml` / `{provider}.ui_skins.themes.yml`. Set `enabled: false` on a
definition to hide it. Both managers filter by theme in `getDefinitionsForTheme($theme)`: a definition
applies if its provider is an enabled module, or is the theme itself or one of its base themes.

## 1. `ui_skins.css_variables` — an editable CSS custom property

Manager: `\Drupal\ui_skins\CssVariable\CssVariablePluginManager` (services
`Drupal\ui_skins\CssVariable\CssVariablePluginManagerInterface`, BC alias
`plugin.manager.ui_skins.css_variable`). Definition class `CssVariableDefinition`.

```yaml
# mytheme.ui_skins.css_variables.yml
color_primary:                 # plugin id → CSS var name "--color-primary" (underscores → hyphens)
  enabled: true
  type: "ui_skins_alpha_color" # any form element: textfield (default), color, ui_skins_alpha_color, ...
  label: "Primary color"
  description: "Brand primary."
  category: "Colors"           # groups form elements into vertical tabs; defaults to "Other"
  weight: 0
  default_values:
    ":root": "#0066ccff"       # keyed by scope (a CSS selector); multiple scopes allowed
```

Fields: `id` (from key, required), `enabled`, `type`, `label`, `description`, `category`,
`default_values` (`{scope: value}`), `weight`. The CSS var name is `--` + id with `_`→`-`.

## 2. `ui_skins.themes` — a body/html attribute preset ("skin")

Manager: `\Drupal\ui_skins\Theme\ThemePluginManager` (interface + BC alias
`plugin.manager.ui_skins.theme`). Definition class `ThemeDefinition`.

```yaml
# mytheme.ui_skins.themes.yml
dark:
  label: "Dark"
  description: "Dark skin."
  target: "body"          # body → $variables['attributes']; html → $variables['html_attributes']
  key: "class"            # attribute to set (default "class"; class values pass through Html::getClass())
  value: "theme-dark"     # defaults to the plugin id if empty
  library: "mytheme/dark" # optional; attached when this skin is active
  dependencies:           # optional; other ui_skins.themes ids applied first (recursively)
    - base_tokens
```

`getComputedTarget()` maps `html`→`html_attributes`, everything else→`attributes`.
`getDefinitionWithDependencies($id)` resolves the dependency chain (dependencies first, self last).

## `ui_skins_alpha_color` render element

`\Drupal\ui_skins\Element\AlphaColor` (`#type => 'ui_skins_alpha_color'`). Renders a core `color`
input plus a 0–255 `number` alpha input and stores an 8-digit hex string `#rrggbbaa`
(`#default_value` like `#00112233`). Usable in any custom form, not just theme settings.

## Notes

- Both managers cache in `cache.discovery` (tags `ui_skins_css_variables` / `ui_skins_themes`) and honor
  alter hooks `hook_ui_skins_css_variables_alter` / `hook_ui_skins_themes_alter` (via `alterInfo`).
- `id` is required; a missing id throws `PluginException`.
- There are no PHP classes to implement — these are pure YAML/data plugins wrapped in definition objects.
