<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Menu Tree exposes a single REST resource that returns an entire menu's link tree (nested subtrees included) from one endpoint, so decoupled/headless front-ends can build navigation in a single request.

---

The module registers one core REST resource plugin, `menu_tree`, at
`/entity/menu/{menu}/tree`, where `{menu}` is a menu config entity id (e.g. `main`). A GET loads the
full menu link tree via `menu.link_tree`, applies the default `generateIndexAndSort` manipulator,
runs core access checks per link (`checkAccess()` removes links the current user can't `view`), strips
array keys so JS clients keep the order, and returns the nested structure serialized through the
required **Menu Normalizer** module. The response carries proper cacheability: it adds the menu entity,
every link's access result and cache metadata, and list cache tags / referenced-entity tags for dynamic
links, so it render-caches yet varies correctly per user. The resource is **not enabled by default** —
after enabling the module you must turn the `menu_tree` REST resource on (via the REST UI module or by
editing `rest.settings`), pick its formats/auth, and grant the standard core permission
`restful get menu_tree` to the roles that may read it. There is no config UI, no permissions, and no
config schema of its own; access and format are governed entirely by core REST.

---

- Fetch an entire menu (e.g. `main`) as nested JSON in one request for a headless front-end.
- Build a React/Vue/Next.js site navigation from Drupal-managed menus.
- Return deeply nested menu subtrees without walking links one by one.
- Drive a mobile app's navigation from the site's menu structure.
- Expose the footer menu to a decoupled front-end separately from the main menu.
- Keep front-end nav in sync with editors' changes in Drupal's menu UI.
- Serve menu links already filtered by the requesting user's access.
- Cache menu responses correctly while varying by per-link access.
- Provide menu data over REST as a lighter alternative to a full JSON:API traversal.
- Choose the serialization format (json/hal_json/xml) via core REST settings.
- Protect the endpoint with core REST authentication (cookie, basic_auth, OAuth).
- Restrict who can read menus with the `restful get menu_tree` permission.
- Combine with REST UI to enable/configure the resource without editing YAML.
- Retrieve a custom menu created for a specific decoupled component.
- Expose site navigation to a static-site generator at build time.
