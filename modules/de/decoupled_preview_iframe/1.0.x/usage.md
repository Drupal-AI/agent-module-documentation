<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Decoupled Preview Iframe lets editors preview content as their decoupled front end will render it: for the content types you enable, the Drupal entity view embeds an `<iframe>` pointing at the front-end application's preview URL, so authors see the real design without leaving Drupal.

---

On a headless site, Drupal's own node page shows raw fields that look nothing like what visitors get. This module bridges that gap. Its settings form (`/admin/config/decoupled_preview_iframe/settings`, permission `administer site configuration`) stores a `preview_url` for the front-end application, the `preview_types` (which node/taxonomy bundles get the iframe), a `route_sync` value used to keep the framed route aligned with the Drupal path, a `draft_provider` for how draft/preview authentication is handled (`none` or `graphql_compose_preview`), and a `redirect_anonymous` flag with a `redirect_url` so anonymous visitors hitting the Drupal domain are sent to the front end instead of the editorial page. Rendering is done through `hook_entity_view_alter()`, which swaps in the `preview_iframe` theme hook (`preview-iframe.html.twig`) for enabled bundles in the `default`/`full` view mode — on the canonical page, on core's node-preview page, and on revision/latest-version routes, where a "Show Published" toggle switches the iframe between the draft revision and the published URL. A JS/CSS library manages iframe sizing, a loading spinner, and two-way route syncing via `postMessage`. It also hides the core preview form's view-mode select (`hook_form_node_preview_form_select_alter()`) so the bar makes sense inside the iframe. There are no permissions of its own, no Drush commands, and the module is deliberately front-end agnostic — Next.js, Nuxt, Astro or anything that can render a preview URL.

---

- Let editors preview content in the decoupled front end from inside Drupal.
- Show the real front-end design instead of raw Drupal field output.
- Preview unpublished drafts and forward revisions against the front-end application.
- Toggle a preview between the draft revision and the published URL.
- Restrict previewing to selected node or taxonomy bundles.
- Redirect anonymous visitors off the Drupal domain to the front end.
- Keep the Drupal admin URL in sync as the user navigates inside the iframe.
- Support Next.js draft mode from a Drupal preview (`NEXT_DRUPAL_ROUTE_SYNC`).
- Forward a GraphQL Compose preview token to the front end for draft data.
- Give reviewers a realistic preview link that opens in a new tab.
- Avoid maintaining a separate preview tool for the front-end team.
- Preview responsive layouts inside the admin UI.
- Use one preview URL base for all previewable content types.
- Keep editors inside Drupal during content moderation review.
- Configure preview behaviour as exportable, deployable config.
- Show the front-end rendering during a moderation workflow.
- Preview a node before publishing to the live front end.
- Give stakeholders a preview without direct front-end access.
- Reduce round trips between the Drupal and front-end teams.
- Theme the preview wrapper by overriding the shipped template.
- Turn the iframe off for content types that have no front-end route.
- Preview on the core node-preview page as well as the canonical view.
