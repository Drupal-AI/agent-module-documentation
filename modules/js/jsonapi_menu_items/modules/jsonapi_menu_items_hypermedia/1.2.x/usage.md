<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Menu items Hypermedia is a glue submodule that makes the per-menu resources from `jsonapi_menu_items` **discoverable**: it adds a `menu_items` link for every menu to the `/jsonapi` root document using JSON:API Hypermedia.

---

This submodule integrates `jsonapi_menu_items` with the contrib
[JSON:API Hypermedia](https://www.drupal.org/project/jsonapi_hypermedia) module (both are hard
dependencies). It ships a single JSON:API Hypermedia **LinkProvider** plugin,
`jsonapi_menu_items.top_level.menu_items` (`MenuItemsLinkProvider`), with a **deriver**
(`MenuItemsLinkProviderDeriver`) that iterates every `menu` entity and produces one derivative per
menu. Each derivative adds a link with relation type `menu_items` (link key `menu_items--<menu>`)
to the JSON:API **root document** (the `entrypoint`), pointing at that menu's
`jsonapi_menu_items.menu` route (`/%jsonapi%/menu_items/<menu>`). The link is always access-allowed
(`AccessResult::allowed()`). The result: a decoupled client fetching `/jsonapi` can find each menu's
items endpoint by following the advertised `menu_items` links, instead of hard-coding the URL
pattern. The submodule has no configuration, permissions, schema, services, or Drush commands — it is
purely the derived LinkProvider plugin. (It is auto-installed by the parent's `hook_update_8001`
when `jsonapi_hypermedia` is already enabled.)

---

- Advertise every menu's `jsonapi_menu_items` endpoint in the `/jsonapi` root document.
- Let a decoupled front-end **discover** menu endpoints instead of hard-coding `/jsonapi/menu_items/{menu}`.
- Follow a `menu_items` hypermedia link to fetch the main menu's items.
- Enumerate all available menus from the JSON:API entrypoint via their `menu_items` links.
- Build a HATEOAS-style client that navigates from the API root to menu data.
- Keep client code resilient to changes in the menu items URL pattern.
- Expose the main, admin, footer, and custom menus as discoverable links automatically.
- Add a new menu and have its `menu_items` link appear in the root document with no extra code.
- Integrate menu discovery with other JSON:API Hypermedia link providers on the same site.
- Provide relation type `menu_items` that clients can key on to locate navigation resources.
- Combine menu discovery with cache-friendly JSON:API responses.
- Support headless CMS setups that rely on the API root for capability discovery.
- Avoid maintaining a separate list of menu endpoints in front-end configuration.
- Let editors create menus that immediately become discoverable to the front-end.
- Serve as a reference example of a per-entity JSON:API Hypermedia LinkProvider deriver.
