<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SPA integrates a single-page application into Drupal.

---

SPA **helps integrate a single-page application into Drupal** — mounting a JavaScript SPA (React/Vue/etc.)
at a Drupal route/element, with form-element helpers for configuration. It depends on Plugin Form Element and
Multivalue Form Element, provides its own permissions, in the Custom package.

Use it to embed a JS SPA in a Drupal page. It is a developer/front-end feature. Security note: the SPA is
front-end code you supply — ensure the SPA and any endpoints it calls handle **access control and data exposure**
themselves (a decoupled front-end must not assume Drupal gates its API calls; the SPA's API endpoints need their
own auth). It has no access-control role beyond its permission. Configure the SPA mount.

---

- Integrate a JS SPA into Drupal.
- Mount a SPA at a route/element.
- Provide form-element helpers.
- Depend on Plugin/Multivalue Form Element.
- Provide its own permissions.
- Serve front-end integration.
- KNOW the SPA is front-end code you supply.
- Ensure the SPA's endpoints have their own auth.
- Not assume Drupal gates the SPA's API calls.
- Have no access-control role beyond permission.
- Configure the SPA mount.
- Handle SPA integration.
- Mount SPAs.
- Configure the mount.
- Embed SPAs.
- Handle the integration.
- Add a SPA.
- Integrate front-ends.
- Secure the endpoints.
- Provide SPA integration.
