<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TS DX bundles assorted developer-experience helpers for Drupal theming and site building: Twig extension functions, utility services, Drush commands and convenience admin routes.

---

The module registers several services: a Twig extension (`ts_dx.twig_extension`, functions prefixed `ts_`) built on theme and extension-path resolvers; `ts_dx.menu_tools` (menu tree helpers), `ts_dx.theme_tools` (admin-context/route theme helpers), `ts_dx.context_tools` (current-route/entity-repository context helpers) and `ts_dx.misc_tools`. It also provides Drush commands (`DxCommands`) and three "toolbar redirect" routes under `/admin/...` that jump straight to the edit form of the most recently matching entity selected by query parameters — handy for wiring a custom admin menu link like "edit the homepage node" without hardcoding an id.

The redirect routes (`ts_dx.node_edit`, `ts_dx.term_edit`, `ts_dx.entity_edit` at `/admin/{entity_type}/edit`) are gated by the core `access content overview` permission and simply issue a redirect to the target entity's canonical edit-form route, which enforces its own access check — so they grant no access the user does not already have, and fall back to a 404 when nothing matches. This is a developer/site-builder toolkit rather than a runtime feature module; its README is partly in French and it originates from a Drupal sandbox project.

---
- Add `ts_`-prefixed Twig functions for use in theme templates.
- Resolve theme/extension paths from within Twig.
- Build menu trees programmatically with the menu-tools service.
- Detect admin context / current route in theme logic.
- Read the current route's entity via the context-tools service.
- Wire an admin menu link that redirects to the latest homepage node's edit form.
- Redirect to a taxonomy term's edit form selected by query parameters.
- Redirect to an arbitrary entity type's edit form via `/admin/{entity_type}/edit`.
- Run the module's Drush commands for developer tasks.
- Inject `ts_dx.misc_tools` for miscellaneous helper functions.
- Speed up editorial access to frequently-edited entities from the toolbar.
- Use context tools to fetch the translated entity for the current route.
- Extend theming with reusable Twig helpers instead of preprocess boilerplate.
- Select entities by field value via query params on the redirect routes.
- Fall back to a 404 when no entity matches the redirect query.
- Combine menu-tools and theme-tools to build dynamic admin menus.
- Prefix all custom Twig functions with `ts_` to avoid collisions.
