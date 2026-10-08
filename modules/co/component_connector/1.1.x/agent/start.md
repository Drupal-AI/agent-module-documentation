<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component connector — agent index

info.yml name **"Component connector"**, description *"Components drupal integration"*. Version **1.1.0**,
core `^9 || ^10 || ^11`, package Other. No dependencies outside core.

A theme-layer developer framework: it lets you author front-end components inside a **theme folder** and wire
them into Drupal's theme registry, asset libraries, and the Layout API using small YAML files — no PHP needed
per component. Components are authored in code (Twig + CSS/JS + a `*.theme.yml` or `*.suggestion.yml`
descriptor); there is **no remote fetching, no design-system URL, no runtime component input**. "External" in
the README means "external to this module" (authored in your theme), not fetched over the network.

## Configuration
- Config object `component_connector.settings`, single key **`theme`** = machine name of the theme to scan for
  component descriptors. Install default: `claro` (`config/install/component_connector.settings.yml`).
- Settings form `Drupal\component_connector\Form\SettingsForm` at route
  **`component_connector.settings`** → `/admin/config/system/component_connector_settings` (menu link under
  System config; `component_connector.links.menu.yml`). A single "Theme" select (or "- None -"). Route
  permission **`administer site configuration`** (core; module provides no permissions of its own).
- After changing definitions run `drush cr` — descriptors are read at registry build time and file-cached
  (`FileCacheFactory 'component_connector:theme'` / `':suggestion'`).

## Mechanism (`src/ComponentConnectorManager.php`, service `component_connector.manager`)
- `getDefinitions($type)` — `file_system->scanDirectory($theme->getPath(), '/^.*\.<type>\.yml$/')` over the
  **configured theme's** directory (`theme` = `theme` or `suggestion`), guarded by `themeExists()`; decodes each
  with `Yaml::decode(file_get_contents(...))`; file-cached.
- `component_connector.module` hooks:
  - `hook_theme_registry_alter` → `alterRegistry()` — registers/merges/replaces theme hooks from `*.theme.yml`
    and remaps templates from `*.suggestion.yml`.
  - `hook_library_info_alter` → `buildLibraries()` — **only when the extension being altered is the active
    theme**; auto-declares a library per component when a `<name>.css`/`<name>.js` sits next to the descriptor.
  - `hook_layout_alter` → `alterLayouts()` — descriptors with `base hook: layout` become Layout API plugins.
  - `hook_themes_installed` → reinit registry when the configured theme is installed.
- `theme.registry` is **decorated** by `RegistryDecorator` (`theme.registry.decorator`): on `get()`/`initDefault()`
  it builds the configured theme's registry even when that theme is not the active theme, so components resolve
  from any active theme (e.g. admin theme active, front theme configured).
- Static preprocess callbacks appended to hooks: `preprocessLibraries` (merges `#attached`), `preprocessVariables`
  (copies a render element's `#variables` up to template vars), `preprocessLayout` (flattens layout `content`
  regions + `#settings`).

## Integration types (descriptor recipes) → [usage.md](../usage.md)
Four `*.theme.yml` / `*.suggestion.yml` shapes, all documented with worked examples in the module README:
1. **Custom theme hook** — `hook theme: <new_hook>` registers a brand-new `hook_theme`.
2. **Candidate** — `hook theme: <hook__variant>` + `base hook: <existing>` extends a core/contrib hook.
3. **Replace** — `hook theme: <existing>` overrides a core/contrib hook's template (no `fields`/`settings`).
4. **Suggestion** (`*.suggestion.yml`) — `base hook: <existing>` remaps the base hook to your template AND
   allows extra `fields`/`settings` variables (avoids the render-element-vs-variables limitation).
5. **Layout** — `base hook: layout` registers a Layout plugin (`ComponentConnectorLayout`); `fields` become
   layout **regions**, `settings` become a config form (textfield/checkbox/select), plus a `field_templates`
   option (`default` / `only_content`, the latter strips field wrappers).

## Security posture
Config-only surface: the one route is gated by `administer site configuration`; the sole input is a theme
machine name chosen from a select of installed themes. Component descriptors, Twig, and assets are
developer-authored files in the codebase (a code trust boundary, like any theme), rendered through Drupal's
normal autoescaping theme layer. No remote fetch, no user-supplied paths, no secrets.

## Files
`component_connector.info.yml`, `.module`, `.routing.yml`, `.services.yml`, `.links.menu.yml`,
`config/install/component_connector.settings.yml`, `config/schema/component_connector.schema.yml`,
`src/ComponentConnectorManager.php`, `src/RegistryDecorator.php`, `src/Form/SettingsForm.php`,
`src/Plugin/Layout/ComponentConnectorLayout.php`, `README.md`.
