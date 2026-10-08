Styles API is a small developer framework that lets modules and themes register named, reusable "styles" — each a template (or theme hook) with metadata (label, category, icon) — through a `Style` plugin type, so other code can present them as options and render content through the chosen style's template.

---

The module defines a `Style` plugin type modelled on core's Layout Discovery: a plugin manager service `plugin.manager.styles_api` (class `StylePluginManager`), an annotation `@Style` (`Drupal\styles_api\Annotation\Style`) discovered from each module/theme's `src/Plugin/Style/` directory, an interface `StyleInterface`, and base classes `StyleBase` / `StyleDefault`. In addition to annotated PHP plugins, it supports **YAML discovery**: a `<provider>.themes.yml` file in a module or theme can declare styles without a plugin class (via a `YamlDiscoveryDecorator` keyed on `themes`). A `@Style` (or YAML entry) carries an `id`, a `type` (`block`, `region`, or `element`), a human `label`, an optional `category`, an `icon`, a base `path`, and **either** a `template` (which Styles API registers with `hook_theme()` for you) **or** a `theme` hook you register yourself — the two are mutually exclusive. The module's own `styles_api_theme()` implementation calls `StylePluginManager::getThemeImplementations()` so every style that provides a template becomes a usable theme hook automatically. Consumers get the plugin manager (via `\Drupal::service('plugin.manager.styles_api')` or the static `Style::stylePluginManager()`), call `getDefinitions()` / `getStyleOptions()` to list styles, and render through the selected style's template. It ships no admin UI, no configuration, no permissions and no Drush — it is purely an API other modules/themes build on. (Note: the deprecated static helpers `Style::getStyleOptions()` / `Style::getThemeImplementations()` reference a mistyped manager accessor and should be avoided in favour of the plugin manager service.)

---

- Let a module register a reusable content "style" (a template + metadata) other code can pick from.
- Provide a themeable style option list for an editor or a formatter setting.
- Register a template with `hook_theme()` automatically by declaring a `template` on a `@Style` plugin.
- Define styles in a theme via a `<theme>.themes.yml` file without writing plugin classes.
- Group styles by `category` for a grouped select UI (`getStyleOptions(['group_by_category' => TRUE])`).
- Attach a preview `icon` to a style for a visual chooser.
- Build a "card style" / "callout style" library that modules and themes can extend.
- Offer block-, region-, or element-level styles via the `type` property.
- Let a contrib module expose its templates as first-class, discoverable styles.
- Enumerate all available styles from code through `plugin.manager.styles_api->getDefinitions()`.
- Provide a base class (`StyleBase` / `StyleDefault`) so most styles need no custom PHP.
- Register a style backed by an existing `theme` hook you define yourself.
- Ship style plugins that resolve their asset `path` relative to the providing module or theme.
- Give a design system a plugin-based registry of named visual styles.
- Allow themes to add or override styles that modules registered (provider can be a theme).
- Present a consistent style picker across multiple features by reusing one plugin type.
- Let another module alter discovered styles through the `styles` alter hook (`hook_styles_alter`).
- Use annotated `@Style` plugins in `src/Plugin/Style/` for styles that need behaviour/config.
- Turn a set of Twig templates into a selectable, metadata-rich style catalogue.
- Provide the plumbing for a higher-level "styles" feature without reinventing plugin discovery.
