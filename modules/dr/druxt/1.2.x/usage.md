<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DruxtJS is a bridge between frameworks, Drupal in the back and Nuxt.js in the front.

---

DruxtJS (druxt) bridges Drupal and Nuxt.js — providing the Drupal-side integration for a decoupled
architecture where Nuxt.js is the front end and Drupal (via JSON:API/decoupled_router) is the back end, so
Nuxt can consume Drupal content/routing. It depends on the Decoupled Router module and provides its own
permissions.

Use it for a Drupal + Nuxt (DruxtJS) decoupled site. It is a web-services/decoupled feature exposing Drupal
content to the Nuxt front end via JSON:API. The security-relevant point is the usual decoupled/JSON:API one:
what the front end can read is governed by **JSON:API's access control and your resource configuration** —
ensure the exposed API doesn't leak unpublished/restricted content or fields (JSON:API respects entity
access, but review your JSON:API/resource config). It has no access-control role of its own beyond its
permission. Configure the DruxtJS/JSON:API exposure.

---

- Bridge Drupal and Nuxt.js.
- Provide the Drupal side of a decoupled site.
- Expose content via JSON:API.
- Depend on Decoupled Router.
- Provide its own permissions.
- Serve a Nuxt front end.
- Rely on JSON:API access control.
- Not leak unpublished/restricted content.
- Review the JSON:API/resource config.
- Have no access-control role beyond permission.
- Configure the JSON:API exposure.
- Handle decoupled routing.
- Bridge frameworks.
- Configure DruxtJS.
- Serve decoupled content.
- Handle Nuxt integration.
- Expose Drupal data.
- Configure the bridge.
- Handle headless.
- Bridge to Nuxt.
