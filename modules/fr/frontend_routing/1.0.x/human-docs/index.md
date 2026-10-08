# Frontend Routes — manual setup guide

**Frontend Routes** (`frontend_routing`) is a small helper for decoupled
(headless) Drupal sites. It manages the mapping between the routes your front-end
framework uses — Nuxt, Vue.js, or any JavaScript client — and the Drupal nodes
that supply their content. You give a front-end path a stable *key*, assign a node
to that key in Drupal, and your front end can then resolve its own routes to the
right piece of content.

This is infrastructure for the common headless pattern where Drupal is the
back end and a separate JavaScript app renders the pages. It lives in the GraphQL
package and is a natural companion to a GraphQL-based front end, though the mapping
itself is just route-key-to-node. The module adds its own permissions and stores
the mappings as configuration.

Because the mapping describes which node answers which front-end path, treat access
to that mapping data the way you would any other decoupled data surface — it should
reflect only content the consumer is entitled to see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and manage keyed route-to-node
   mappings.

## Where it lives in the admin menu

Once enabled, add and manage your keyed routes at **Configuration → Web services →
Frontend Routing** (`/admin/config/services/frontend-routing`). Your front-end
framework can also write the mappings itself by placing a
`frontend_routing.settings.yml` file in the Drupal config directory.
