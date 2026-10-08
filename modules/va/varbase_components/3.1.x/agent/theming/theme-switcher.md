<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme switcher, active_theme variable, and install recipe

Source: `src/EventSubscriber/ActiveThemeChangeSubscriber.php`,
`src/Hook/VarbaseComponentsHooks.php`, `recipes/default/recipe.yml`,
`varbase_components.install`.

## The `active_theme` Twig variable

`VarbaseComponentsHooks::preprocess()` is a `#[Hook('preprocess')]` (applies to all
templates). It reads the default theme from config and exposes it:

```php
$variables['active_theme'] = $this->configFactory->get('system.theme')->get('default');
```

So any template can use `{{ active_theme }}` to get the site **default** theme's machine
name. Caveat worth knowing: this is the configured default theme, not necessarily the theme
that is actually rendering the current request (an admin route uses the admin theme, but
`active_theme` still holds the default). Intended for Vartheme BS5 component templates that
need to build theme-aware asset paths or class names.

## The config theme-switcher (`ActiveThemeChangeSubscriber`)

Subscribes to `ConfigEvents::SAVE` → `onActiveThemeChange()`. Guard conditions, all must hold
before anything happens:

1. The saved config is `system.theme`.
2. The original data had a `default` key.
3. `default` actually changed (`$old_theme !== $new_theme`).
4. **Both** the old and new themes declare `auto_switch_components: true` in their
   `<theme>.info.yml` (`themeHasFlag()` reads and YAML-decodes the theme's info file).

Only then does `replaceAndSaveThemeInActiveConfigs()` run. It:

- Iterates **all** active config names (`configFactory->listAll()`).
- First pass over `core.entity_view_display.*`, then over every config, calling
  `processConfigWithPatterns()`: encodes the config to YAML and runs two regexes that match the
  old theme machine name in `key:oldtheme:key` and `(start|space|quote)oldtheme:key` shapes,
  replacing the old theme name with the new one, then decodes and saves.
- A final pass calls `processDependenciesInConfig()` on configs that do **not** already contain
  the old theme name, swapping the old theme for the new one inside `dependencies.theme` arrays.
- Logs each changed config to the `varbase_components` logger channel and shows a status
  message.

### Why it exists
Vartheme BS5 subthemes bind UI Patterns / Display Suite components per view mode in
`core.entity_view_display.*` and carry `dependencies.theme` references. When you re-theme the
site from one subtheme to a sibling, those stored references would still point at the old
theme. This subscriber rewrites them so the component configuration keeps resolving after the
swap — a config-migration convenience, run at the moment the default theme is saved.

### Opting a theme in
A custom theme participates only if it sets in its `.info.yml`:

```yaml
auto_switch_components: true
```

Both the source and destination theme must set it, or the subscriber does nothing.

## The install recipe

`hook_install()` (`varbase_components.install`) builds and runs `recipes/default/` via
`Recipe::createFromDirectory()` + `RecipeRunner::processRecipe()`. The recipe installs these
modules and imports all (`"*"`) of their config:

- UI Patterns: `ui_patterns`, `ui_patterns_layouts`, `ui_patterns_library`,
  `ui_patterns_views`, `ui_patterns_field_formatters`, `ui_patterns_field_group`,
  `ui_patterns_ds`
- UI Icons: `ui_icons`, `ui_icons_patterns`, `ui_icons_field`, `ui_icons_picker`,
  `ui_icons_library`

(`ds`, `field_group`, `storybook`, `vardot/varbase-patches` come in as composer requirements.)

## Update hooks
`includes/updates/v2.inc` → `varbase_components_update_200001()` uninstalls the old
experimental `sdc` module if present (SDC is now in Drupal core).
