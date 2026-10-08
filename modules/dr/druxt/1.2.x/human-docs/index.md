# DruxtJS — manual setup guide

**DruxtJS** (`druxt`) is the Drupal side of a bridge between Drupal and
[Nuxt.js](https://nuxt.com/). It lets you run a **decoupled (headless)** site
where Nuxt is the front end and Drupal is the back end: Nuxt consumes your
Drupal content and routing over **JSON:API**, and DruxtJS prepares Drupal so
that works cleanly. It depends on the
[Decoupled Router](https://www.drupal.org/project/decoupled_router) module and
provides its own permission for read access to the JSON:API resources Druxt
needs.

On the Drupal side, enabling the module and granting one permission is most of
the job. Druxt bundles a single **read‑only** permission (`access druxt
resources`) covering the JSON:API resources the Nuxt front end reads, adds
support for Views routes (via JSON:API Views and Decoupled Router), bypasses
condition plugins for Block resources so blocks resolve for the front end, and
enables **CORS** so the separate Nuxt origin can call the API.

The other half lives outside Drupal: a **Nuxt.js application** using the
`druxt-site` npm package, pointed at your Drupal site's base URL. That front‑end
setup is done in your JavaScript project, not the Drupal admin UI.

One security point is worth keeping in mind, and it is the usual decoupled one:
what the front end can read is governed by **JSON:API's access control and your
resource configuration**, not by Druxt. Review your JSON:API/resource config so
the exposed API does not leak unpublished or otherwise restricted content and
fields. Druxt has no access‑control role of its own beyond the permission above.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the Drupal module, grant the
   Druxt permission, and connect a Nuxt front end.

There is **no dedicated Drupal settings form** for this module. Its Drupal‑side
setup is the permission described below; the rest of the configuration is in your
Nuxt application.

## Where it lives in the admin menu

Druxt adds no admin settings page of its own. Its one Drupal‑side control is a
permission at **People → Permissions** (`/admin/people/permissions`): grant
**Access Druxt resources** to the role your front end authenticates as (or to
anonymous, if the front end reads public content unauthenticated).

## How to use it

1. Enable Druxt and its Decoupled Router dependency on Drupal (see
   [Installation](installation/index.md)).
2. At **People → Permissions**, grant **Access Druxt resources** to the
   appropriate role.
3. Review your JSON:API and resource configuration so only content you intend to
   expose is reachable.
4. In your Nuxt project, install `druxt-site` and point its `baseUrl` at your
   Drupal site, for example:

   ```js
   // nuxt.config.js
   module.exports = {
     modules: ['druxt-site'],
     druxt: {
       baseUrl: 'https://your-drupal-site.example',
     },
   }
   ```
