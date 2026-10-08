<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Components (varbase_components) — agent index

Components-handler module of the **Varbase distribution**. Version **4.0.0** (version-dir `4.0.x`).
Core **`~11.4.0`** (pinned to one Drupal minor). License GPL-2.0-or-later. Package: Varbase.

## What it is (4.0.x is a rewrite)
The 3.x line installed the UI Patterns + UI Icons recipe stack. **4.0.x dropped all of that.** It now
depends only on `drupal/cva` (~1, the **Drupal Canvas** module) and core `views`, and it ships **no**
components, Twig templates, libraries or config beyond one settings object and one JS init. It is the
glue + maintenance layer for a Canvas SDC site. Info-yml `dependencies:` = `views`, `cva:cva`.

Four jobs:
1. **Theme-switch migration.** `src/EventSubscriber/ActiveThemeChangeSubscriber.php` listens on config
   `SAVE`; when `system.theme:default` changes **and both** old and new themes set
   `auto_switch_components: true` in `.info.yml`, it re-themes the whole site (config, content
   `component_tree` fields, Canvas `page_region` clones, text-field paths, `dependencies.theme`) and
   heals component versions. Logs to channel `varbase_components`.
2. **Component-version heal.** Canvas regenerates SDC component config entities (new version hashes) on
   rebuild/module-install/theme-install. `src/Hook/VarbaseComponentsHooks.php` weights the module
   heavier than Canvas (`module_set_weight('varbase_components', 10)` in `.install`) and calls
   `ActiveThemeChangeSubscriber::heal()` from `#[Hook('rebuild')]`, `#[Hook('modules_installed')]`,
   `#[Hook('themes_installed')]` to rewrite any config/content pinning a stale hash to the active one.
3. **Hidden Canvas components.** `#[Hook('component_presave')]` creates any component in
   `varbase_components.settings:hidden_canvas_components` **disabled**; `hook_install()` disables ones
   that already exist; `#[Hook('themes_uninstalled')]` deletes orphaned `sdc.<theme>.*` component
   configs (only when `canvas` module present).
4. **`active_theme` Twig var + Views SDC plugins + AOS.** `#[Hook('preprocess')]` sets
   `$variables['active_theme']` = `system.theme:default` for every template. Two Views plugins render a
   view / its exposed filters through an SDC. A `varbase_components/aos` library wires Animate-On-Scroll.

## Provides
- **Config schema** (`config/schema/varbase_components.schema.yml`): `varbase_components.settings`
  (`hidden_canvas_components` sequence), plus schema for the two Views plugins. **No settings UI.**
- **Drush commands** (`drush.services.yml`, `src/Commands/VarbaseComponentsCommands.php`):
  `varbase-components:switch-theme` (aliases `vc-switch,vcs`; `--dry-run`),
  `varbase-components:fix-versions` (`vc-fix-versions,vcfv`),
  `varbase-components:scan-refs` (`vc-scan,vcscan`).
- **Views plugins** (not plugin *types*): `components_views_style` style plugin,
  `components_exposed_form` exposed-form plugin.
- **Library**: `aos` (external `/libraries/aos/aos.js|css` + `js/aos-init.js`).
- **Hooks**: `preprocess`, `component_presave`, `rebuild`, `modules_installed`, `themes_installed`,
  `themes_uninstalled` (all attribute hooks in `VarbaseComponentsHooks`). One event subscriber.
- **No** permissions, **no** routes/controllers, **no** plugin types.

## Common misconception (correct it)
Not a runtime theme switcher. The subscriber only fires on a `system.theme` default-theme change and
rewrites **stored** config/content; render is unaffected. Migration also only runs if BOTH themes carry
`auto_switch_components: true`.

## Detail docs
- Theme-switch subscriber, healing, Drush commands: [theming/theme-switcher.md](theming/theme-switcher.md)
- Settings, hidden components, hooks, install/library: [config/settings.md](config/settings.md)
- Views SDC style + exposed-form plugins: [plugins/views.md](plugins/views.md)

## Deploy note
The `~11.4.0` core pin ties the site's core updates to the Varbase release cycle. Enabling it also pulls
the Drupal Canvas (`cva`) module. Flag both before recommending it outside a Varbase distribution.
