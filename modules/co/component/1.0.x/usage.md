<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Component lets a front-end developer expose a JavaScript/CSS/HTML component to Drupal as a placeable block by dropping one `*.component.yml` file next to the assets — no plugin class, no module, no Twig.

---

Install with `composer require drupal/component` and enable it (the optional `component_example` submodule ships sample components for reference). To add a component, create a folder inside a **`components/`** subdirectory of any enabled module or theme, put your JS/CSS/HTML there, and add a `MACHINE_NAME.component.yml` that at minimum declares `name` and `description`; the discovery service picks it up and — for the default `type: block` — registers a placeable block `component:<machine_name>` plus a Drupal library `component/<machine_name>`. You can pass fixed data with `static_configuration:` or expose site-builder settings with `form_configuration:` (Form API), both of which are rendered as `data-*` attributes on the wrapper `<div>` so the browser-side JS can read them off its parent element; you can also set `type: library` (register shared assets, e.g. React from a CDN, without a block) or `type: plugin` (a swap-in selectable on the admin page at `admin/config/development/component`). **Known limitation, verified on Drupal 11:** because `component.discovery` is tagged `plugin_manager_cache_clear` but lacks a `clearCachedDefinitions()` method, installing or uninstalling any module or theme while Component is enabled fatals mid-operation (`drush cr` and the admin "Clear all caches" button are unaffected); the discovery also collides with core's Single-Directory Components, logging a `missing required keys description` notice for each core SDC file. The project notes it may be discontinued now that SDC is in core.

---

- Expose a JS component as a Drupal block from one YAML file.
- Register a component's JS/CSS as the Drupal library `component/<name>`.
- Skip writing a block plugin class per component.
- Keep a component's definition beside its code in a `components/` folder.
- Give site builders placeable front-end widgets.
- Pass fixed parameters to a component with `static_configuration`.
- Expose per-block settings with `form_configuration` (Form API).
- Read component config in the browser from `data-*` attributes.
- Publish a shared vendor bundle with `type: library` (e.g. React from a CDN).
- Reference an external/CDN asset with `type: external`.
- Share code between components via library `dependencies`.
- Provide a swap-in implementation with `type: plugin` + `parent`.
- Select which plugin a parent uses at `admin/config/development/component`.
- Set a component's block cache with the `cache:` key.
- Override the render theme hook with the `theme:` key.
- Add an entity block context with `contexts: {entity: <type>}`.
- Try the bundled `component_example` samples for reference.
- Alter discovered components with `hook_component_info_alter()`.
- Diagnose an install/uninstall that fatals while Component is enabled.
- Recognise the `plugin_manager_cache_clear` service-tag contract.
- Understand the collision with core Single-Directory Components.
