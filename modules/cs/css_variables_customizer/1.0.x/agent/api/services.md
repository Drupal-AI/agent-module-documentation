<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services, injection mechanism & plumbing

## Services (`css_variables_customizer.services.yml`)

- **`css_variables_customizer.manager`** → `CssVariablesManager` (also aliased to the interface
  `Drupal\css_variables_customizer\CssVariablesManagerInterface`). Parses CSS, converts variables to a
  style string, and builds the injected render array. Args: `@config.factory`, `@tempstore.private`,
  `@css_variables_customizer.preview_cleanup_subscriber`.
- **`css_variables_customizer.theme_finder`** → `ThemeFinder` (aliased to `ThemeFinder`). Returns the
  enabled themes whose `.info.yml` has a `css_variables_customizer` key. Arg: `@extension.list.theme`.
- **`css_variables_customizer.route_subscriber`** → `RouteSubscriber` (event subscriber). Registers a
  `css_variables_customizer.theme.<theme>` form route per customizable theme (`administer themes`).
- **`css_variables_customizer.preview_cleanup_subscriber`** → `CssVariablesPreviewCleanupSubscriber`
  (event subscriber). Deletes preview tempstore entries on `kernel.terminate`.
- **`cache_context.css_variables_preview`** → `CssVariablesPreviewCacheContext` (cache context
  `css_variables_preview`). Args: `@current_user`, `@tempstore.private`.
- **`Drupal\css_variables_customizer\Hook\AttachmentHooks`** — hook object for `hook_page_top`. Args:
  `@theme.manager`, `@css_variables_customizer.manager`, `@router.admin_context`, `@config.factory`.

## `CssVariablesManagerInterface` (the public API)

`src/CssVariablesManager.php` / `src/CssVariablesManagerInterface.php`.

- `getFileVariables(string $file): array` — read one CSS file, return `[category => [variable => ['value'
  => …, 'selector' => …]]]` (calls `parseCss()`).
- `getStringVariables(string $css_styles): array` — parse a raw blob (the Custom textarea) into
  `[variable => value]` via `CSS_VARIABLES_REGEXP` + `array_combine`.
- `variablesToStyle(array $variables, ?string $selector = NULL): string` — flatten the nested structure
  into a CSS string, `sprintf('%s: %s;', $variable, $value)` grouped per selector as `selector{ … } `.
  A non-null `$selector` overrides every stored selector.
- `getComponentVariables(Component $component): array` — resolve an SDC component's own CSS files (from
  its library definition) and parse their annotated variables.
- `buildThemeCustomizations(string $theme, ?string $selector = NULL): array` — the render array of
  `<style>` tags (see below).

Regex constants on the interface: `CSS_CATEGORY_START_REGEXP`, `CSS_CATEGORY_END_REGEXP`,
`CSS_VARIABLES_REGEXP` (`/(?<variable>--([a-zA-Z0-9]+-?)+):(?<value>.+);/`).

## How overrides reach the page (`hook_page_top`)

`AttachmentHooks::attachCustomizations()` (`src/Hook/AttachmentHooks.php:40`) runs on every request:

1. Resolves the **active theme** (`theme.manager`) and merges
   `$manager->buildThemeCustomizations($theme)` into `$page_top`.
2. If the current route is an **admin route** (`router.admin_context`), it ALSO injects the site's
   **default** theme's customizations scoped to the `.ck-content` selector — so CKEditor content areas in
   the admin preview the front-end tokens.

`buildThemeCustomizations()` (`src/CssVariablesManager.php:151`) builds one or more render elements:

```php
$render[$id] = [
  '#type'  => 'html_tag',
  '#tag'   => 'style',
  '#value' => $this->variablesToStyle($customization['overrides'], $selector),
  '#cache' => [
    'tags'     => ['config:css_variables_customizer.customizations.' . $theme],
    'contexts' => ['css_variables_preview:' . $theme],
  ],
];
```

It emits: one block per saved `customizations[]` entry with non-empty `overrides`, one
`css_variables_customizer_custom` block for the `custom` map (each forced to selector `:root`), and — when
there is nothing to output — an empty `css_variables_customizer_holder` `<style>` comment (present so the
cache tag exists and pages invalidate correctly when overrides change). Rendering goes through core's
`html_tag` element, whose string `#value` is passed through `Xss::filterAdmin()` before output.

Data source precedence inside `buildThemeCustomizations()`: the current user's private tempstore
(`css_variables_customizer` collection, key `preview_<theme>`) if a preview exists (and it is then marked
for cleanup), otherwise the saved `css_variables_customizer.customizations.<theme>` config.

## Caching

- **Cache tag** `config:css_variables_customizer.customizations.<theme>` on every injected block — saving
  the form (a config write) invalidates it, so cached pages pick up new overrides.
- **Cache context** `css_variables_preview:<theme>` (`CssVariablesPreviewCacheContext`) — returns
  `no-theme` / `no-preview`, or a `sha256` hash of the current user's preview payload, so a previewing
  admin gets a private variant without polluting other users' cached pages.

## Dynamic routes & links

- `RouteSubscriber::alterRoutes()` adds `css_variables_customizer.theme.<theme>` for each customizable
  theme (`_form => CustomizerForm`, `theme` default param, `_permission: administer themes`).
- `MenuLinkDeriver` / `TaskLinkDeriver` add a menu link and local task per theme under the overview,
  parented on `system.themes_page`. `ThemeFinder` drives all three (routes, menu, tasks) — run `drush cr`
  after opting a new theme in.
