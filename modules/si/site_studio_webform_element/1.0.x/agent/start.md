<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Studio Webform Element (site_studio_webform_element) — agent index

Registers a **Webform** custom element in the Acquia Site Studio (Cohesion) builder so an editor
can place an existing Webform inside a component. Version **1.0.2**. Core `^9 || ^10 || ^11`.
Package **Site Studio**.

## Dependencies
- Drupal modules: `cohesion` (Acquia Site Studio — commercial), `webform`.
- Composer: `acquia/cohesion ^6.8 || ^7 || ^8`, `drupal/webform ^6.0`.
- No submodules, no permissions of its own, no config entities/schema, no Drush, no install hooks.
- On a site without the Site Studio stack the module has nothing to do.

## What it provides
- **CustomElement plugin** `WebformElement` (id `site_studio_webform_element`, label "Webform") —
  `src/Plugin/CustomElement/WebformElement.php`. Builder field: one `select` (`webform_id`) listing
  every Webform by label. Renders the chosen form via `#create_placeholder` + `#lazy_builder` →
  static `build()` → core `#type => 'webform'` (Webform's own access/validation/handlers apply).
- **Route** `site_studio_webform_element.webform_list` → `/api/cohesion/webform-list`
  (`WebformOptionListController::list`) returning a JSON `[{label,value}]` list of all Webforms.
- **Library + hook** — `hook_page_attachments()` attaches `webform_list` (js/script.js) site-wide;
  it defines `window.siteStudioWebformElementList()` (fetches the route) for use as a Site Studio
  component-form Select "custom function" / external data source.

## Solution docs
- [plugins/webform-element.md](plugins/webform-element.md) — the CustomElement plugin, builder
  field, lazy-build/render path, and how placement relates to Webform's own config.
- [api/webform-list-endpoint.md](api/webform-list-endpoint.md) — the `/api/cohesion/webform-list`
  route, controller, JS helper, and the dynamic/token form-selection workflow.
