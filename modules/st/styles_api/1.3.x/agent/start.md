# Styles API — agent index

Developer framework that defines a **`Style` plugin type** so modules/themes can register named
templates ("styles") with metadata (label, category, icon) that other code lists and renders
through. Modelled on core Layout Discovery. **No config, no UI, no permissions, no Drush.**

- **Define a style (annotation `@Style` or `<provider>.themes.yml`), the properties, base class** →
  [plugins/style.md](plugins/style.md)
- **Use the plugin manager from code (list styles, theme registration)** →
  [api/manager.md](api/manager.md)

Key facts:
- Plugin manager service: `plugin.manager.styles_api` (class `StylePluginManager`).
- Annotation: `@Style` (`Drupal\styles_api\Annotation\Style`); discovery dir: `src/Plugin/Style/`.
- Interface `StyleInterface`; base classes `StyleBase` / `StyleDefault`.
- Also supports **YAML discovery**: styles declared in a `<provider>.themes.yml` file.
- `@Style` properties: `id`, `type` (`block`|`region`|`element`), `label`, `category`, `icon`,
  `path`, and **either** `template` (auto-registered via `hook_theme()`) **or** `theme` (you
  register) — mutually exclusive.
- Alter hook: `hook_styles_alter()`. The module's `styles_api_theme()` auto-registers templates.
- Gotcha: the deprecated statics `Style::getStyleOptions()` / `Style::getThemeImplementations()`
  call a mistyped accessor and fatal — use the plugin manager service instead.
