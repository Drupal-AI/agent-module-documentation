# GraphQL Compose Configs — manual setup guide

**GraphQL Compose Configs** (`graphql_compose_configs`) extends
[GraphQL Compose](https://www.drupal.org/project/graphql_compose) so you can
**expose selected Drupal configuration through GraphQL**. Chosen config values —
the site name, mail address, slogan, or settings from any config object — become
type‑safe, queryable data for a decoupled (headless) front end, alongside the
content GraphQL Compose already exposes. The module generates GraphQL types for
each exposed configuration automatically and provides an admin interface for
choosing what to surface.

You decide exactly which configuration objects, and which fields within them, are
exposed. For example, once you expose `system.site`, a client can run:

```graphql
query {
  systemSite {
    name
    mail
    slogan
  }
}
```

The module converts configuration names into valid GraphQL type names
automatically (`system.site` becomes `systemSite`).

There is an important caution that comes with this power. **Drupal configuration
can contain sensitive values** — API keys, credentials, private settings — and
exposing config over GraphQL makes it queryable. So expose **only non‑sensitive
config**, review exactly which keys you surface, and make sure your GraphQL
endpoint's access is configured so secrets are never queryable by anonymous
clients. The module adds one permission for managing exposure but has no
access‑control role beyond that and the GraphQL server's own access model.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (GraphQL Compose is required).
2. [Configuration](configuration/index.md) — choose which configuration to expose,
   and do so safely.

## Where it lives in the admin menu

Configuration exposures are managed at
`/admin/config/graphql/compose/configs`, protected by the **Administer GraphQL
configuration exposure** permission.
