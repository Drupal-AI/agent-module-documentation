<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vue.js (vuejs) — agent index

Makes the **Vue.js** runtime available to Drupal as a named asset library so themes and modules can
attach one shared copy instead of each bundling its own. The module **ships no JavaScript** — it
builds the library definition dynamically from admin config (`hook_library_info_build`), pointing
either at a CDN URL (the install default) or at a locally installed copy under `/libraries/`. It
exposes **two** libraries: `vuejs/vue` (the full Vue runtime, Vue 2 or 3) and `vuejs/petitevue`
(the small `petite-vue` build). Each library is only registered when it is *enabled* and has a
*path* set — by default `vue` is enabled and `petitevue` is disabled, so out of the box only
`vuejs/vue` exists.

The single UI is an admin settings form at `admin/config/development/vuejs` (`Drupal\vuejs\Form\SettingsForm`)
where you choose, per runtime, CDN-vs-local, the CDN provider (`unpkg`/`cdnjs`/`jsDelivr`) and
version or the local file path, and (for petite-vue) `defer`/`init` script attributes. Saving
rewrites the `vuejs.settings` config and clears the library-discovery cache. `hook_requirements`
adds a runtime warning if a library is set to *local* but its file cannot be resolved under
`libraries/`. `hook_help` renders `README.md` on the module help page.

- Depends on: nothing (no `dependencies` in info.yml). Optional soft integration: the `markdown`
  module is used by `hook_help` to render the README if present.
- Core: `^10.3 || ^11`. PHP: `7.4`. Package: none declared.
- Has a settings page: **yes** — `configure: vuejs.settings`. Permission: `administer vuejs configuration`
  (`restrict access: true`). No services, no drush, no plugin types, no fields, no additional permissions.
- Not bundled: the actual Vue JS is loaded from a CDN (default) or expected under `libraries/vue`
  (and `libraries/petitevue`); see `composer.libraries.json` for the Composer Merge Plugin route.

## What you'd do → where

- **Attach Vue (or petite-vue) to a page, template, or another library** →
  [api/libraries.md](api/libraries.md)
- **Understand how the two libraries are generated / when they exist** →
  [api/libraries.md](api/libraries.md)
- **Configure CDN vs local, provider, version, path, defer/init; the config keys** →
  [configure/settings.md](configure/settings.md)
- **Install the Vue library locally (Composer Merge Plugin or manual tarball)** →
  [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Route / form: `vuejs.settings` (`/admin/config/development/vuejs`), form
  `Drupal\vuejs\Form\SettingsForm` (form id `vuejs_settings`, editable config `vuejs.settings`).
  Menu link `vuejs.settings` under `system.admin_config_development`.
- Permission: `administer vuejs configuration` (`restrict access: true`).
- Libraries (built at runtime by `vuejs_library_info_build()`): `vuejs/vue`, `vuejs/petitevue`.
- Config object: `vuejs.settings`, with two mappings `vue` and `petitevue`. `vue` keys:
  `enabled` (bool), `installation` (`local`|`cdn`), `path` (string), `cdn_provider`
  (`unpkg`|`cdnjs`|`jsdelivr`), `cdn_version` (string). `petitevue` adds `defer` (bool) and
  `init` (bool). Config schema type `config_object` in `config/schema/vuejs.schema.yml`.
- Hooks implemented: `hook_help` (renders README), `hook_library_info_build`,
  `hook_requirements` (local-file-missing warning), `hook_update_N` = `vuejs_update_93001`–`93004`.
- Ships no `src/` service, no `*.services.yml`, no controller, no `js/`/`css/` assets of its own.
