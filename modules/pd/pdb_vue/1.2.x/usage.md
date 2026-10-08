<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDB Vue registers Vue.js as a framework for the Progressively Decoupled Blocks (`pdb`) module: any module or theme that ships a Vue component folder becomes a placeable Drupal block that mounts a Vue app or component in that block's region, while Drupal keeps rendering the rest of the page.

---

Full decoupling means a separate front-end application with its own routing, build and deployment, and it gives up Drupal's block layout, contextual links and page assembly. Progressive decoupling keeps Drupal in charge of the page and hands specific regions — an interactive basket, a live dashboard — to JavaScript, which is often the right trade for a single feature. The parent `pdb` module provides that mechanism generically by discovering "component" directories (an `*.info.yml` with `type: pdb`) across the codebase; `pdb_vue` adds Vue as a supported `presentation`. It exposes each discovered Vue component as a `vue_component` block derivative, attaches the correct Vue 2 or Vue 3 libraries (plus Vuex, Pinia and vue-demi) per a site-wide setting, auto-builds a block config form from the component's declared fields, and passes those field values into the component as Vue props and via `drupalSettings`. A settings page at `/admin/config/services/pdb-vue` chooses the Vue version, toggles an un-minified development mode (which also reveals the shipped example components), and enables a Single-Page-App mode that mounts one global Vue app so components can be placed multiple times. Eleven example components (Vue 2 and Vue 3, template files, Vite and webpack builds, Pinia-shared state, and in-block SPAs) are the practical documentation. Vue 2 reached end of life at the end of 2023, so new work belongs on the `vue3_*` examples.

---

- Place a Vue.js component as a Drupal block.
- Add interactivity to one region of a page without decoupling the whole site.
- Keep Drupal's block layout, contextual links and page assembly.
- Choose Vue 3 (default) or Vue 2 site-wide from one settings page.
- Pass block configuration fields into a Vue component as props.
- Read a placed block's settings in Vue via `drupalSettings.pdb.configuration`.
- Render the same component in several regions using SPA component mode.
- Run a small single-page app inside a Drupal page.
- Share state between two separately placed blocks with Pinia.
- Use Vuex for legacy or Vue 2 state management.
- Turn on development mode to load Vue Devtools and expose demo blocks.
- Ship a Vue block from a custom module or subtheme, no PHP required.
- Provide a component's markup from a separate `template.html` file.
- Build components with Vite and serve the bundle from a block.
- Build components with the Vue CLI / webpack toolchain.
- Attach an extra JS library (e.g. Pinia) to a component from its info.yml.
- Override or swap the bundled Vue library from a theme.
- Mount the global SPA Vue instance on a custom root element.
- Progressively modernise a legacy front end one block at a time.
- Prototype a decoupled feature cheaply before committing to full decoupling.
- Give a front-end team a Vue entry point inside an existing Drupal site.
- Learn the integration pattern from the eleven shipped example components.
