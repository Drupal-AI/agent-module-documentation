<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, hidden Canvas components, hooks, install & library

Source: `config/install/varbase_components.settings.yml`,
`config/schema/varbase_components.schema.yml`, `src/Hook/VarbaseComponentsHooks.php`,
`varbase_components.install`, `varbase_components.libraries.yml`, `js/aos-init.js`.

## `varbase_components.settings` (no UI)
`config_object` with one key. There is **no settings form/route** (`configure` is null); change it via
config import, Drush `config:set`, or a recipe.

```yaml
hidden_canvas_components:
  - block.admin_menu_links
  - block.ai_operations_status
  - block.ai_setup_ai_provider
  - block.events_block
  - block.project_browser_block.ai_dashboard_recommended
  - block.project_browser_block.varbase_recipes
  - block.share
  - block.social_auth_login
  - block.views_block.recent_pages-block_recent_pages
  - sdc.navigation.message
  - sdc.webshare.share
```

Schema: `hidden_canvas_components` is a `sequence` of strings (Drupal Canvas `component` config entity
IDs). The schema file also defines `views.exposed_form.components_exposed_form` and
`views.style.components_views_style` (see plugins/views.md).

## Hidden components mechanism (`VarbaseComponentsHooks`)
`getHiddenCanvasComponents()` reads the setting (`?? []`). Drupal Canvas computes a Component config
entity's initial `status` at source-discovery time and offers no alter hook, so:
- `#[Hook('component_presave')] componentPresave(EntityInterface $component)` — on a **new**, enabled
  `component` entity whose ID is in the hidden list, calls `$component->disable()`. Components on the
  list are created disabled whenever the module/recipe providing them is enabled.
- `disableHiddenComponents()` (static) — loads the hidden `component` entities that already exist and
  disables+saves any still enabled. Called from `hook_install()` to cover components created before this
  module was installed. Bails if the `component` entity type is absent.
- Only the **initial** status is enforced; a site builder can re-enable any hidden component manually.

The listed items are administrative or duplicate components (dashboard feeds, Project Browser blocks, AI
admin blocks, and the Webshare Share block/component that duplicates the theme Share component) that
should not be placed on pages by editors.

## `themes_uninstalled` orphan cleanup
`#[Hook('themes_uninstalled')] themesUninstalled(array $themes)` — only when the `canvas` module is
installed and the `component` entity type exists. For each uninstalled theme it entity-queries
`component` IDs starting with `sdc.<theme>.` (`accessCheck(FALSE)`) and deletes them, logging the count.
Canvas creates an `sdc.<theme>.<name>` component config per SDC but these are not theme-dependent config,
so core does not remove them on uninstall — they would otherwise linger as orphans. Safe because Drupal
forbids uninstalling the default theme and the theme-switch subscriber has already migrated content off
the old theme.

## `active_theme` Twig variable
`#[Hook('preprocess')] preprocess(array &$variables)` sets
`$variables['active_theme'] = \Drupal::config('system.theme')->get('default')` for **every** template.
This is the configured **default** theme machine name, not necessarily the theme rendering the current
request (an admin route uses the admin theme but `active_theme` still holds the default). Use
`{{ active_theme }}` in component/theme templates for theme-aware asset paths or class names.

## Install / update
- `varbase_components_install($is_syncing)` — `module_set_weight('varbase_components', 10)` (so heal
  hooks run after Canvas), then `VarbaseComponentsHooks::disableHiddenComponents()`.
- `varbase_components_update_10001()` — re-applies the module weight of 10.

## AOS library
`varbase_components.libraries.yml` defines one library, `aos` (Animate On Scroll, v2.3.1):

```yaml
aos:
  css: { theme: { /libraries/aos/aos.css: {} } }
  js:  { /libraries/aos/aos.js: { minified: true }, js/aos-init.js: {} }
  dependencies: [ core/drupal, core/once ]
```

Expects the AOS vendor library at `/libraries/aos/` (not bundled). `js/aos-init.js` registers the
`Drupal.behaviors.varbaseComponentsAos` behavior, which (guarded by `once`) calls `AOS.init({ once: true,
disable: <prefers-reduced-motion: reduce> })`. The library is attached only when a component selects an
animation.
