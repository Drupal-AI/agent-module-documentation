<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Frontend Menu adds a menu-tree endpoint with active-trail and resolve hints for decoupled front ends.

---

JSON:API Frontend Menu adds a menu-tree endpoint that returns a menu's structure with active-trail information and jsonapi_frontend resolve hints — so a decoupled front end can render navigation menus (with the current page highlighted) directly from JSON:API.

It builds on jsonapi_frontend; menu access follows Drupal's menu/link access. Depends on `jsonapi_frontend`; supports Drupal 10, 11, and 12.

---

- Add a menu-tree JSON:API endpoint.
- Return menu structure.
- Include active-trail info.
- Provide resolve hints.
- Support decoupled navigation.
- Highlight the current page.
- Build on jsonapi_frontend.
- Follow menu/link access.
- Depend on `jsonapi_frontend`.
- Support Drupal 10, 11, and 12.
- Render menus from JSON:API.
- Serve navigation data.
- Support front-end menus
- Expose menu trees.
- Resolve menu links.
- Support headless nav.
- Provide active trail.
- Integrate menus decoupled
