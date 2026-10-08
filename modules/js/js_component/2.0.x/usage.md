<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JS Component lets a developer register a JavaScript/React (or Twig-wrapped) front-end component from any module or theme via a simple YAML file, and exposes each registered component as a placeable Drupal block (with an optional site-builder settings form) that mounts the component and hands it data through `drupalSettings` or DOM data attributes.

---

Each component is declared in a `THEME_OR_MODULE.js_component.yml` file. A definition names a `label`, an optional `root_id` (the DOM id the JS mounts on, default `root`), a `libraries` block (same syntax as `*.libraries.yml`, used to attach the component's JS/CSS), optional `settings` (Form API elements collected from the site builder), a `settings_scope` (`dom` → `drupalSettings.jsComponent`, or `attribute` → `data-*` attributes), a `settings_allow_token` flag (runs entered values through Token before render), and optional `template` (a Twig file) or `handlers` (PHP `component_form` / `data_provider` classes). A `JSComponentManager` plugin manager (`plugin.manager.js_component`, plugin type `js_component`) auto-discovers those YAML files across all modules and enabled themes using a `YamlDiscoveryDecorator`. `hook_library_info_build()` turns each component's `libraries` into a real Drupal library, and `hook_theme()` registers a theme hook for components that ship a Twig template. A block deriver (`JSComponentsBlockType`) turns every component into a `js_component:<id>` block derivative; placing that block renders either an inline `<div id="root">` wrapper or the component's Twig template, attaches the library, and injects settings and event-built `data`. Data can be supplied server-side by a `data_provider` handler class or by subscribers to the `js_component.build_component_data` event; settings values support tokens (node context) when enabled. There is no global config page, no permissions, and no Drush commands — everything is developer YAML plus block placement.

---

- Mount a React app inside a Drupal block without writing a custom module or block plugin.
- Register a Vue/Svelte/vanilla-JS widget from a theme by dropping in a `THEME.js_component.yml` file.
- Expose a built front-end bundle (`build/static/js/main.*.js`) as a placeable, reusable block.
- Give site builders a settings form (select, textfield, etc.) that configures a JS component per block instance.
- Pass configuration to a component through `drupalSettings.jsComponent[<id>][<root>].settings`.
- Pass configuration to a component as DOM `data-*` attributes by setting `settings_scope: attribute`.
- Render a component's markup via a Twig template instead of an empty mount `<div>`.
- Attach component CSS and JS automatically via the definition's `libraries` block.
- Load an external (CDN) script for a component using the library `type: external` flag.
- Supply server-computed data to a component with a `data_provider` handler class implementing `fetch()`.
- Inject or alter component data at build time by subscribing to the `js_component.build_component_data` event.
- Replace the simple auto-built settings form with a custom `component_form` handler class for AJAX/validation logic.
- Alter another module's component settings form with `hook_js_component_form_alter()` / `hook_js_component_FORMID_form_alter()`.
- React to component settings submission with `hook_js_component_form_submit()`.
- Use Token replacement (e.g. `[node:title]`) inside component settings via `settings_allow_token: TRUE`.
- Give each component a stable or per-instance mount id via `root_id` (including `settings:<key>` to derive it from a setting).
- Place the same component multiple times on a page, each getting a unique mount id via `Html::getUniqueId()`.
- Scope a component to node context (the block carries a `node` context) for token/data building.
- Override a component's `root_id` at runtime through block configuration overrides.
- Ship a design-system widget library as a set of JS components across a theme.
- Progressively decouple a page — embed islands of JS interactivity as blocks in an otherwise server-rendered site.
- Alter the discovered component definitions with `hook_js_component_info_alter()`.
- Build a chart, map, or calendar block backed by a JS library and site-builder-chosen options.
- Standardize how front-end components receive Drupal configuration across a project.
