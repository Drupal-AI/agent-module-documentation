<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alpine.js Library support (alpine_js) — agent index

Bundles **Alpine.js 3.15.12** and its official plugins as local Drupal asset libraries and, via
`hook_js_alter()`, re-orders the page's JavaScript so Alpine-plugin files load **before** Alpine
starts. Package `Libraries`. No module dependencies (`ext-json` only). Core requirement
`^9 || ^10 || ^11` (composer allows `^10 || ^11 || ^12`). License GPL-2.0-or-later. Version 3.0.8.
All Alpine JS is shipped in `js/vendor/` — no CDN.

- **Settings form, config object + schema, delivery/plugin toggles, the route & its permission** →
  [config/settings.md](config/settings.md)
- **How the load-order re-sort works (`hook_js_alter` + `AlpineAssetService`), how a theme/module
  opts in, header/footer/CSP/bridge behaviour** → [api/asset-ordering.md](api/asset-ordering.md)

## What it actually is

- One service, `alpinejs.service` = `Drupal\alpine_js\AlpineAssetService`
  (`src/AlpineAssetService.php`), constructed with `@config.factory` + `@library.discovery`.
- One procedural hook, `alpine_js_js_alter()` (`alpine_js.module`), the only entry point — it
  skips Ajax/XHR responses, otherwise calls `findAndSplitAlpineLibraries()`.
- One config form, `SettingsForm` (`src/Form/SettingsForm.php`), a `ConfigFormBase` at route
  `alpine_js.settings_form` → `/admin/config/development/alpinejs`.
- One config object, **`alpine_js.settings`** (booleans only; schema `config/schema/alpinejs.schema.yml`,
  defaults `config/install/alpine_js.settings.yml`), plus three `hook_update_N` migrations in
  `alpine_js.install`.
- Asset libraries in `alpine_js.libraries.yml`: `alpine`, `alpine-csp`, six plugins (`anchor`,
  `collapse`, `focus`, `intersect`, `persist`, `resize`), and `drupalbridge`.
- **No entities, no plugin types, no permissions.yml, no Drush, no REST.** (The route requires a
  permission `administer alpinejs configuration` that the module never declares — see
  config/settings.md.)

## Key facts (from source)

- Opt-in three ways: a theme/module depends on `alpine_js/alpine_js`; a JS file is tagged
  `attributes: { alpinejs: true }` (plus a `dependencies: [alpine_js/alpine_js]`); or `global` is
  enabled so Alpine loads on every page.
- Delivery is boolean config: `global`, `admin`, `footer`, `csp`, `bridge`, and per-plugin
  `plugins.{anchor,collapse,focus,intersect,persist,resize}`. Defaults ship everything **off**
  except `footer: 1`.
- Attachment order enforced by `AlpineAssetService`: bundled plugins → custom `alpinejs`-tagged
  libraries → optional bridge → **Alpine core (or CSP build) last**, all at weight ~300 in the
  chosen scope.
- The `alpine:init` convention is how a plugin registers (`js/drupalbridge.plugin.js` adds the
  `$dbg()` magic as the only bundled example).
