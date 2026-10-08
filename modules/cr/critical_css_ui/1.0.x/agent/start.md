<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Critical CSS UI (critical_css_ui) — agent index

Stores above-the-fold **critical CSS** as database entities and inlines the fragment matching the
current page context into the `<head>`, deferring the rest of the site's stylesheets to load
asynchronously. Package **Page Speed Optimization**. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.x (installed 1.0.0-alpha3). No composer or Drupal module dependencies declared;
uses core services (entity, asset renderer, Views data handler).

- **Config form, the `critical_css` entity, routes/permission, the renderer decorator + provider,
  and how matching works** → [config/settings.md](config/settings.md)

## What it provides

- **Content entity type `critical_css`** (`src/Entity/CriticalCSS.php`, base table `critical_css`)
  with base fields `target_context` (string, unique), `css` (`string_long`), `status` (boolean,
  default TRUE), plus `created`/`changed`. Admin permission `administer critical_css`. Handlers:
  list builder `CriticalCSSListBuilder`, `EntityViewsData`, add/edit form `CriticalCSSForm`,
  node/node_type form `CriticalCssContextForm`, core delete forms, `AdminHtmlRouteProvider`.
- **Service decorator** `Asset\CssCollectionRenderer` decorates core `asset.css.collection_renderer`
  (`critical_css_ui.services.yml`) — inlines the critical CSS `<style id="critical-css">` and makes
  the other CSS assets async.
- **Service** `critical_css_ui.provider` = `Asset\CriticalCssProvider` — decides whether the feature
  is enabled for the request and which entity's CSS to return.
- **Config form** `Form\CriticalCssConfigForm` (route `critical_css_ui.settings`, config object
  `critical_css_ui.settings` with a single `enabled` boolean; schema + install default shipped).
- **Local-task deriver** `Plugin\Derivative\CriticalCssLocalTasks` — adds a "Critical CSS" tab on
  `entity.node.canonical` and `entity.node_type.edit_form`.
- **Permission** `administer critical_css` (`restrict access: true`) gates every route.
- **`hook_requirements()`** (`.install`) errors at runtime if the `critical_css` module is also
  enabled (both decorate the same renderer).

## Routes (all require `administer critical_css`)

- `critical_css_ui.settings` → `/admin/config/development/performance/critical-css` (settings form).
- `entity.critical_css.collection` / `.add_form` / `.canonical` / `.edit_form` / `.delete_form`
  under `/admin/config/development/performance/critical-css`.
- `entity.critical_css.node_form` → `/node/{node}/critical-css`.
- `entity.critical_css.node_type_form` → `/admin/structure/types/manage/{node_type}/critical-css`.

## Mechanism (from source)

- `CriticalCssProvider::isEnabled()` returns FALSE on admin routes (when the user can view the admin
  theme) and on AJAX requests, else reads `critical_css_ui.settings:enabled`.
- `getTargetContexts()` reads the current entity from route parameters; for **node** entities it
  builds `node:{id}` then `node:{bundle}`, then always appends `default`.
- `getCriticalCss()` loads the first enabled `critical_css` entity whose `target_context` matches (in
  that order) and returns its trimmed `css`.
- `CssCollectionRenderer::render()` calls the inner renderer, then (if enabled and not yet processed)
  prepends `<style id="critical-css">` with the CSS via `Markup::create()` and, when a fragment was
  found, rewrites every non-print stylesheet link to `media="print"` + `onload` swap with a
  `<noscript>` fallback (`makeAssetsAsync()`).
