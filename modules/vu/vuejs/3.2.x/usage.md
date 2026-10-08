<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vue.js makes the Vue runtime (and optionally petite-vue) available to Drupal as a named asset library, loaded from a CDN or a local copy, so themes and modules can attach one shared version instead of bundling their own.

---

The module ships no JavaScript of its own; instead it generates up to two asset libraries — `vuejs/vue` and `vuejs/petitevue` — from settings you manage at **Administration → Configuration → Development → Vue.js** (`/admin/config/development/vuejs`, permission **administer vuejs configuration**). For each runtime you choose an installation type: **Use an external CDN** (pick `unpkg`, `cdnjs`, or `jsDelivr` and a version — the module builds the script URL for you, defaulting to Vue `3.5.13`), or **Local library** (download the Vue tarball into your site's `libraries/` folder — either manually or via the bundled `composer.libraries.json` with `wikimedia/composer-merge-plugin` — and point the path at the extracted file such as `/libraries/vue/package/dist/vue.global.prod.js`). A library is only registered when it is both **enabled** and has a **path**; out of the box `vue` is enabled and `petitevue` is disabled. Petite-vue additionally exposes **Defer loading** and **Initialize** (manual-init) script attributes. Once configured, attach the library the usual ways — `{{ attach_library('vuejs/vue') }}` in Twig, `$attachments['#attached']['library'][] = 'vuejs/vue';` in a hook, or listing `vuejs/vue` under `dependencies:` in your own `*.libraries.yml` — and your JavaScript uses the global `Vue` object. The module supports both Vue 3 (current) and the end-of-life Vue 2 (it emits `vue.min.js` for versions below 3.0.0), and it warns on the status report if a local library file cannot be found.

---

- Provide the Vue runtime to a custom module.
- Share one Vue copy across a whole site.
- Attach Vue to a Twig template with `attach_library`.
- Attach Vue programmatically from `hook_page_attachments`.
- Depend on Vue from your own `*.libraries.yml`.
- Load Vue from a CDN (unpkg, cdnjs, or jsDelivr).
- Pin a specific Vue version from the settings form.
- Install Vue locally under `libraries/` instead of a CDN.
- Install the Vue library via Composer Merge Plugin.
- Add petite-vue alongside the full Vue runtime.
- Defer petite-vue loading until the page is ready.
- Use petite-vue manual-init mode via the `init` attribute.
- Avoid bundling Vue several times across modules.
- Prevent Vue version conflicts on the same page.
- Progressively enhance part of a Drupal-rendered page.
- Build a reactive widget without a front-end build step.
- Add a small interactive component to a form or block.
- Support a team already familiar with Vue.
- Serve Vue 2 for legacy code (`vue.min.js`).
- Restrict who can change the Vue configuration via a dedicated permission.
- Get a status-report warning when a local Vue file is missing.
