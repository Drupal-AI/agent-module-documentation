<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component (component) — agent index

Exposes a JavaScript/CSS/HTML front-end component to Drupal as a **placeable block** from a single
`MACHINE_NAME.component.yml` file — no PHP, no plugin class, no module. A discovery service
(`component.discovery`) scans the `components/` subfolder of every enabled module and theme (and the
web root) for `*.component.yml` files; each `type: block` component becomes a derived block
(`component:<name>`), each `type: library` component becomes a Drupal library
(`component/<name>`), and `type: plugin` components are selectable swap-ins configured on the admin
form. At render time `ComponentBlock` attaches the component's library, reads the component's HTML
template file from disk and prints it (`{{ html_template|raw }}`) inside a wrapper `<div>` whose
`data-*` attributes carry the component's static + per-block configuration to the browser.

Version **1.0.0-rc5**. Core `^9 || ^10 || ^11`. Package `Component`. No dependencies. Submodule
`component_example` (sample components — NOT enabled on this site; see below). The project itself
notes it may be discontinued now that Single-Directory Components (SDC) are in core.

- Depends on: nothing. Core: `^9 || ^10 || ^11`. Package: `Component`.
- Settings page: **yes** — `component.admin_form` at `admin/config/development/component`
  (permission `access administration pages`). No module-specific permissions. No drush. **No config
  schema** (the `component.admin` config object is written without a schema).
- Provides NO Drupal plugin *type* / manager. It provides one block plugin (`component`) with a
  deriver, one service, and the `*.component.yml` authoring format.

**Caveat — cannot install/uninstall other modules while enabled (verified, this site, D11).**
`component.services.yml` tags `component.discovery` with `plugin_manager_cache_clear`, but
`ComponentDiscovery` does not implement `CachedDiscoveryInterface` / has no `clearCachedDefinitions()`
method. Core's `CachedDiscoveryClearer::clearCachedDefinitions()` calls that method on every tagged
service, so any code path that runs it fatals with
`Error: Call to undefined method Drupal\component\ComponentDiscovery::clearCachedDefinitions()`.
That path is hit by `ModuleInstaller::install()/uninstall()` and `ThemeInstaller::install()` — so
enabling ANY module or theme (including `component_example`) fatals mid-operation. `drush cr` and the
admin "Clear all caches" button do **not** fatal (they rebuild the container instead). This is a
stability bug, not a security issue. See [api/services.md](api/services.md).

**Also odd:** discovery collides with core SDC — both use `*.component.yml` in `components/`
folders, so `component.discovery` scans core's SDC files (navigation, olivero teaser…) and logs a
`missing required keys description` notice for each on every discovery. And
`ComponentBlockDeriver::getDerivativeDefinitions()` returns `NULL` (not an array) when no `block`
component exists, producing a `getDerivativeDefinitions() does not return an array` warning.

## What you'd do → where

- **Author a component (all `*.component.yml` keys, discovery rules, `type: block|library|plugin`)** →
  [api/component-yml.md](api/component-yml.md)
- **Understand how a component renders (block build, data attributes, template, cache) / place one
  as a block** → [plugins/block.md](plugins/block.md)
- **Call/alter the discovery service, hooks, and the library/drupalSettings wiring** →
  [api/services.md](api/services.md)
- **Use the admin form / the `component.admin` config / choose a `plugin` swap-in** →
  [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Service: `component.discovery` (`Drupal\component\ComponentDiscovery` implements
  `ComponentDiscoveryInterface`; only public method `getComponents()`). Also `logger.channel.component`.
  Service provider `Drupal\component\ComponentServiceProvider` (Drupal 8 BC only).
- Route / menu link: `component.admin_form` → `admin/config/development/component`
  (`Drupal\component\Form\ComponentAdminForm`, form id `component_admin_form`,
  `_permission: 'access administration pages'`, `_admin_route: TRUE`).
- Config object: `component.admin` (keys = a `plugin` component's `parent` machine name → selected
  plugin machine name).
- Block plugin: id `component`, deriver `Drupal\component\Plugin\Derivative\ComponentBlockDeriver`,
  class `Drupal\component\Plugin\Block\ComponentBlock`. Derived ids: `component:<machine_name>`.
- Theme hook: `component_html` (`templates/component-html.html.twig`; render element `elements`;
  variables `html_template`, `content_attributes`). Override per-component via the yml `theme` key.
- Hooks implemented: `component_theme`, `component_page_attachments`, `component_library_info_build`,
  `component_help`. Alter hook invoked: `hook_component_info_alter(&$components)`.
- Library naming: `component/<machine_name>` (built by `component_library_info_build()`).
- `*.component.yml` keys (defaults in `ComponentDiscovery::$defaults`): `name` (req), `description`
  (req), `type` (`block`|`library`|`plugin`, default `block`), `js` `{}`, `css` `{}`, `template`
  (default `index.htm`), `form_configuration` `{}`, `static_configuration` `{}`, `cache`
  `{max-age: 0}`, `dependencies` `[]`, `parent` `''`. Also read: `theme`, `contexts`. Required keys
  enforced: `name`, `description`.
