<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Compose Configs exposes Drupal configuration through GraphQL.

---

GraphQL Compose Configs **exposes selected Drupal configuration through GraphQL** — making chosen config
values queryable by a decoupled front-end via the GraphQL Compose schema (e.g. site name, front-end settings).
It depends on the GraphQL Compose module, provides its own permissions, in the GraphQL Compose package.

Use it to serve site config to a headless front-end. It is a decoupled feature with an important data-exposure
consideration: **configuration can contain sensitive values** (API keys, credentials, private settings), and
exposing config over GraphQL makes it queryable — so **only expose non-sensitive config**, review exactly which
config keys are surfaced, and configure the GraphQL endpoint's access appropriately (don't expose secrets to
anonymous queries). It has no access-control role of its own beyond its permission and the GraphQL server's
access. Configure which configs to expose.

---

- Expose config through GraphQL.
- Make config queryable by a front-end.
- Use the GraphQL Compose schema.
- Depend on GraphQL Compose.
- Provide its own permissions.
- Serve decoupled front-ends.
- KNOW config can contain sensitive values.
- Only expose non-sensitive config.
- Review which config keys are surfaced.
- Configure the GraphQL endpoint access.
- Not expose secrets to anonymous queries.
- Have no access role beyond its permission + GraphQL access.
- Handle config exposure.
- Expose config.
- Configure the exposure.
- Query config.
- Handle the integration.
- Surface config.
- Protect sensitive config.
- Provide config over GraphQL.
