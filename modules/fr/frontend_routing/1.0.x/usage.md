<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Frontend Routes manages mapping between frontend routes and nodes, for decoupled/GraphQL front ends.

---

Frontend Routes manages the mapping between front-end routes and Drupal nodes — so a decoupled front end
(often GraphQL-based) can resolve its own routes/paths to the corresponding Drupal content. This is
infrastructure for headless setups where the JavaScript front end needs to know which node a given path
maps to. It is in the GraphQL package and provides its own permissions.

Use it on decoupled sites to expose route→node mapping to the front end. It is a decoupled/routing feature;
the mapping reflects content the consumer is entitled to (respecting access as the front end resolves
content), and access to the mapping API should be controlled like any decoupled data surface. Configure the
route mappings.

---

- Map frontend routes to nodes.
- Resolve decoupled routes to content.
- Support GraphQL front ends.
- Provide route-to-node mapping.
- Provide its own permissions.
- Enable headless routing.
- Let the front end resolve paths.
- Reflect entitled content.
- Control mapping-API access.
- Configure route mappings.
- Support decoupled sites.
- Map paths to nodes.
- Handle frontend routing.
- Resolve content by route.
- Provide routing infrastructure.
- Support headless front ends.
- Configure the mapping.
- Handle decoupled routes.
- Map routes to content.
- Enable frontend routes.
