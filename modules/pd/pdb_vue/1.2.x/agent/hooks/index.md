<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & asset libraries

`pdb_vue.module` implements three alter hooks that wire discovered Vue components to the right
assets. Integrators and theme authors mainly care about the library names these produce so they can
override them.

## `pdb_vue_component_info_alter($components)`
Custom PDB alter (invoked by `ComponentDiscovery::getComponents()` via `hook_component_info_alter`).
For each `presentation == 'vue'` component with no hardcoded `path`, sets
`$component->info['path'] = $component->getPath()` so `VueBlock::build()` can locate the component's
`template` file.

## `pdb_vue_library_info_alter(&$libraries, $extension)`
- For `$extension == 'pdb'` (the per-component libraries built by the parent):
  - Merges any `libraries:` declared in a component's info.yml into that component's
    `<machine_name>/header` and `/footer` library dependencies.
  - When `version == 'vue3'`, rewrites each dependency matching `^pdb_vue/vue` to its `vue3`
    equivalent (`pdb_vue/vue` → `pdb_vue/vue3`, `pdb_vue/vue.vuex` → `pdb_vue/vue3.vuex`, …), so the
    same component works under either Vue major without editing its info.yml.
  - In SPA mode (`use_spa`) for `component: true` components, appends `pdb_vue/vue3.spa-create`
    (which runs `Vue.createApp({})` into the shared `vueApp`).
- For `$extension == 'pdb_vue'` with `development_mode` on: swaps each library's `*.prod.js` /
  `*.min.js` file for the un-minified `.js` build (Vue Devtools).

## `pdb_vue_js_alter(&$javascript, $assets)`
Finds the `spa-init` JS file and bumps its weight to `last_weight + 0.25` so the global app is
mounted **after** every component tag has been printed.

## Provided asset libraries (`pdb_vue.libraries.yml`)

External CDN scripts (protocol-relative) plus two local init/create files.

| Library | Version | Source |
|---|---|---|
| `pdb_vue/vue` / `vue.dev` | Vue 2.7.14 | cdnjs (`vue.min.js` / `vue.js`) |
| `pdb_vue/vue.spa-init` | — | local `js/spa-init.js` (`new Vue({el: spaElement})`) |
| `pdb_vue/vue.vuex` / `vue.vuex.dev` | Vuex 3.6.2 | cdnjs |
| `pdb_vue/vue3` / `vue3.dev` | Vue 3.3.4 | jsDelivr (`vue.global.prod.js` / `vue.global.js`) |
| `pdb_vue/vue3.spa-create` | — | local `js/vue3.spa-create.js` (`Vue.createApp({})` → `vueApp`) |
| `pdb_vue/vue3.spa-init` | — | local `js/vue3.spa-init.js` (`vueApp.mount(spaElement)`) |
| `pdb_vue/vue3.vuex` / `vue3.vuex.dev` | Vuex 4.1.0 | jsDelivr |
| `pdb_vue/vue3.pinia` / `vue3.pinia.dev` | Pinia 2.1.3 | jsDelivr (depends on `vue3` + `vue3.vue-demi`) |
| `pdb_vue/vue3.vue-demi` / `.dev` | vue-demi 0.14.5 | jsDelivr |

## Overriding from a theme
Standard `libraries-override` in a theme's `*.info.yml` works, e.g.:
```yaml
libraries-override:
  pdb_vue/vue3: themename/vue3          # swap the whole Vue library
  vue3.spa-init:
    js:
      js/vue3.spa-init.js: js/custom.spa-init.js   # replace one file
  pdb_vue/vue: false                    # remove a library (e.g. self-managing via Vite)
```
