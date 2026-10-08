<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DruxtJS is the Drupal back-end half of a decoupled Drupal + Nuxt.js site, exposing a curated set of JSON:API resources and enriching Decoupled Router path translations so a Nuxt frontend can render Drupal content and routing.

---

DruxtJS (`druxt`) bridges a Drupal back end and a Nuxt.js front end. It builds on core JSON:API plus the Decoupled Router, JSON:API Menu Items and JSON:API Views contrib modules. It adds a single `access druxt resources` permission that grants read-only access to a configurable list of JSON:API resources (by default the configuration entities a Nuxt frontend needs — blocks, views, menus, field/display config and the like — plus `menu_link_content`), a settings form at `/admin/config/services/druxt` to choose that list, and event subscribers that extend Decoupled Router's `/router/translate-path` responses so contact-form paths, Views routes and other wildcard routes resolve to JSON:API endpoints. It also enables Cross-Origin Resource Sharing so the separate Nuxt origin can call the API, provides a `request_path` condition override so block visibility conditions can be evaluated from the frontend, and creates any missing entity view displays. The exposed-resource list is validated (configuration entities only) on the form and on configuration import, and can be extended in code with `hook_druxt_resources_alter()`. What the frontend can read is governed by JSON:API access control and this resource configuration, so keep the exposed list to what the frontend actually renders.

---

- Run a decoupled Drupal + Nuxt.js (DruxtJS) site with Drupal as the JSON:API back end.
- Grant a Nuxt frontend read-only access to Drupal configuration over JSON:API with one `access druxt resources` permission.
- Serve blocks, views, menus, fields and display configuration as JSON:API resources for a headless frontend.
- Choose exactly which JSON:API resources are exposed at `/admin/config/services/druxt`.
- Resolve front-end paths to Drupal entities/routes via Decoupled Router's `/router/translate-path`.
- Return JSON:API endpoint metadata (individual URL, resource name, base path, entry point) for a resolved contact form page.
- Resolve a Views route to its JSON:API Views endpoint for the frontend.
- Resolve arbitrary wildcard routes and return the route match context to the frontend.
- Enable CORS so the separate Nuxt origin can call the Drupal API.
- Override the core `request_path` block-visibility condition so it can be driven from the DruxtJS frontend.
- Ensure every bundle/view-mode has an entity view display so JSON:API/display config is complete.
- Expose additional resources to the frontend from custom code with `hook_druxt_resources_alter()`.
- Keep a shared configuration set safe by validating the exposed-resource list on config import.
- Warn site builders on the status report when required JSON:API resources are missing or disabled.
- Grandfather `menu_link_content` so decoupled menus keep working after upgrading to the configurable list.
- Build a Nuxt site with the `druxt-site` npm module pointed at the Drupal `baseUrl`.
- Support multilingual decoupled sites by exposing `configurable_language` and language-collection configuration.
- Give a distribution a way to remove a resource it does not want exposed via the alter hook.
- Audit which resources a decoupled site exposes before granting the permission to anonymous.
- Migrate a site from a hardcoded resource list to configuration via the `druxt_update_10301` update hook.
