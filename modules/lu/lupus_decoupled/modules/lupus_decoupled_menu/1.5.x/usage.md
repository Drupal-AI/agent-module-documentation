<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Menu exposes Drupal's menus over an API so the front end can render site navigation.

---

Navigation is one of the things a decoupled front end cannot invent. Menus live in Drupal, editors change them there, and the front end needs the current tree — with access filtering applied, since a menu link to an admin page should not appear for an anonymous visitor.

This submodule provides those endpoints, and it is a hard dependency of the top-level module because a site without navigation is not a site. The front end fetches the menu tree and renders it in its own components, so styling and behaviour are the front end's business while structure and access remain Drupal's.

The practical benefit is that editors keep the workflow they already have: menu changes are made in Drupal's menu UI and appear on the front end, rather than navigation becoming a front-end deployment. The thing to plan for is caching — a menu fetched on every page render is a request per page, so the front end should cache the tree and the site should invalidate that cache when menus change.

---

- Render site navigation in a decoupled front end.
- Fetch a Drupal menu tree over an API.
- Keep menu editing in Drupal's UI.
- Apply access filtering to menu links.
- Hide admin links from anonymous visitors.
- Render a footer menu in the front end.
- Style navigation entirely in the front end.
- Avoid redeploying to change navigation.
- Cache the menu tree in the front end.
- Invalidate the front end's menu cache on change.
- Support several menus on one site.
- Expose a multilingual menu.
- Debug a menu link that does not appear.
- Keep structure in Drupal and presentation in Nuxt.
- Plan menu caching for a high-traffic site.