<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Components (varbase_components) — agent index

Components-handler module of the **Varbase distribution**. Version **3.1.1**. Core **`~11.4.0`**
(pinned to one Drupal minor). License GPL-2.0-or-later. Package: Varbase.

**It ships no components, Twig templates, libraries, or config of its own.** There is no
`.libraries.yml`, no `components/`, no `templates/`, no `config/`. It is glue. Three jobs:

1. **Installer.** `hook_install()` runs the bundled core recipe `recipes/default/recipe.yml`, which
   installs and imports the config of the **UI Patterns** family (`ui_patterns`,
   `ui_patterns_layouts`, `ui_patterns_library`, `ui_patterns_views`,
   `ui_patterns_field_formatters`, `ui_patterns_field_group`, `ui_patterns_ds`) and the **UI Icons**
   family (`ui_icons`, `ui_icons_patterns`, `ui_icons_field`, `ui_icons_picker`,
   `ui_icons_library`). Composer also requires `ds`, `field_group`, `storybook`,
   `vardot/varbase-patches`.
2. **`active_theme` Twig variable.** `src/Hook/VarbaseComponentsHooks.php` — a
   `#[Hook('preprocess')]` — sets `$variables['active_theme']` = `system.theme:default` for **every**
   template.
3. **Config theme-switcher.** `src/EventSubscriber/ActiveThemeChangeSubscriber.php` listens on
   config `SAVE`; when `system.theme:default` changes **and both** old and new themes set
   `auto_switch_components: true` in their `.info.yml`, it bulk regex-replaces the old theme machine
   name with the new one across all active config (esp. `core.entity_view_display.*` and
   `dependencies.theme`). Logs to channel `varbase_components`. **This is config migration, not a
   render-time switch.**

## Common misconception (correct it)
It is **not** a runtime theme switcher that makes Layout Builder previews match the front end. The
subscriber only fires on a `system.theme` default-theme change and rewrites stored config.

## Files
- `varbase_components.info.yml` — no `dependencies:` line (deps enforced via composer + recipe).
- `varbase_components.install` — `hook_install()` runs the recipe; includes `includes/helpers.inc`
  (empty stub) and `includes/updates.inc` → `updates/v2.inc`.
- `includes/updates/v2.inc` — `varbase_components_update_200001()` uninstalls the old experimental
  `sdc` module (now in core).
- `varbase_components.services.yml` — registers `ActiveThemeChangeSubscriber`.
- `recipes/default/recipe.yml` — the install recipe (module list above).

## Provides
No permissions. No routes/controllers. No Drush commands. No config schema. No plugin types. No
plugins. No hooks besides `preprocess`. One event subscriber, one recipe.

## Detail
- Theme switcher + `active_theme` variable + recipe: [theming/theme-switcher.md](theming/theme-switcher.md)

## Deploy note
The `~11.4.0` core pin ties the site's core updates to the Varbase release cycle. Flag this before
recommending it outside a Varbase distribution.
