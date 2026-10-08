<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDB Vue js (pdb_vue) — agent index

Registers **Vue.js** as a framework for **Progressively Decoupled Blocks (PDB)**. Any module or
theme that ships a component directory (`type: pdb`, `presentation: vue` in its `*.info.yml`) is
discovered by the parent `pdb` module and exposed here as a placeable Drupal block that mounts a
Vue app/component in that block's region. Drupal still renders the page; Vue owns the block markup.

Depends on `pdb:pdb` (`drupal/pdb >= 1.0`). Core `^9 || ^10 || ^11`. Ships the Vue 2/3, Vuex,
Pinia and vue-demi asset libraries plus 11 example component submodules.

- Settings page (Vue version, dev mode, SPA mode) → configure/settings.md ([configure/settings.md](configure/settings.md))
- The `vue_component` block plugin + how components become blocks → [blocks/vue-component.md](blocks/vue-component.md)
- Authoring a Vue component block (info.yml contract, props, state) → [api/authoring-components.md](api/authoring-components.md)
- Asset-library and JS alters (Vue2→Vue3 swap, dev mode, SPA wiring, overrides) → [hooks/index.md](hooks/index.md)
- The one permission → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object: `pdb_vue.settings` — keys `version` (`vue3`|`vue2`, default `vue3`),
  `development_mode` (bool), `use_spa` (bool), `spa_element` (string, default `#page-wrapper`).
- Configure route: `pdb_vue.form` at `/admin/config/services/pdb-vue` (form `\Drupal\pdb_vue\Form\VueForm`).
- Permission: `administer decoupled vue blocks` (gates the settings form only).
- Block plugin id: `vue_component`; class `\Drupal\pdb_vue\Plugin\Block\VueBlock`
  (extends `\Drupal\pdb\Plugin\Block\PdbBlock`); deriver `\Drupal\pdb_vue\Plugin\Derivative\VueBlockDeriver`.
- Discovery service (from parent): `pdb.component_discovery` (`\Drupal\pdb\ComponentDiscovery`).
- Provides no drush commands and defines no plugin *type* of its own.
- Update hook `pdb_vue_update_8101` pins existing sites to `version: vue2`.
