<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consumer Base URL — agent index

**Consumer Base URL** (`consumer_base_url`), release **1.0.0-beta2** (version-dir 1.0.x).
info.yml name: *Consumer Base URL*; package *Web services*; core `^10.3 || ^11`.
Dependencies: core `path_alias`, contrib `consumers`. Composer `drupal/consumers:^1.7`
(dev-only: `graphql:^5.0`, `token:^1.0`). No routes, no config entities, no permissions,
no config schema, no `.install`, no Drush of its own.

Purpose: give each **Consumers** entity (decoupled front-end client) its own **base URL**,
then rewrite Drupal's outbound URL generation for that consumer so canonical links, URL
tokens and redirects point at that front end instead of the Drupal backend. Primarily
exercised with a single default consumer + **GraphQL 4.x** (maintainer's note).

## Mechanism

- **`base_url` base field** (`consumer_base_url.module`, `hook_entity_base_field_info`): adds a
  revisionable, non-translatable `string` field (max_length 255, default `''`) to the
  `consumer` entity, shown on the consumer view/form. Set it by editing a consumer at
  **Configuration → Web services → Consumers** (`/admin/config/services/consumer`), gated by
  the Consumers module's entity-edit permission (`administer consumer entities` /
  `update own consumer entities`). Format `https://example.com`. Clear caches after changing
  it on an existing consumer.

- **`BaseUrlProvider`** (`consumer_base_url.base_url_provider`):
  - `loadBaseUrl(Consumer)` → the field value or `NULL`.
  - `getConsumerRoutes()` → a **global** (not per-consumer) list of route names that get
    rewritten: `<front>`, `entity.node.canonical`, `entity.node.revision`,
    `entity.taxonomy_term.canonical`, `entity.user.canonical`; plus
    `entity.node.latest_version` when `content_moderation` is on, and
    `entity.media.canonical` when `media.settings:standalone_url` is true. Invokes
    `hook_consumer_base_url_routes_alter(&$routes)` (see `consumer_base_url.api.php`) so other
    modules can add/remove route names. `isConsumerRoute(Url)` tests membership.
  - `@todo` in source: per-consumer route lists are not yet supported.

- **Outbound URL rewriting** (two tagged processors, both priority 200):
  - `ConsumerRouteProcessor` (`route_processor_outbound`) sets a route option flagging whether
    the route is a consumer route (resolving `<current>` via the current route match).
  - `ConsumerPathProcessor` (`path_processor_outbound`) — for flagged consumer routes, when a
    consumer is negotiated and has a base_url, sets `$options['base_url'] = trim(base_url,'/')`
    and `$options['absolute'] = TRUE`. Skips external paths, `/admin` paths, and GraphQL
    requests.

- **Token rewriting** (`hook_tokens_alter`): rewrites `url`- and `site`-type tokens
  (e.g. `[node:url:absolute]`, `[site:url]`) to the consumer base URL **only for GraphQL
  requests** and only for routes in `getConsumerRoutes()`. Needs the `token` module.

- **Redirect subscriber** (`ConsumerBaseUrlRedirectResponseSubscriber`): registers the service
  name `redirect_response_subscriber`, extending/replacing core's redirect subscriber
  site-wide. It honors the `?destination=` query param and, when the negotiated consumer has a
  base_url whose host matches the redirect target, emits a `TrustedRedirectResponse` so a
  redirect to that consumer's configured front-end domain is allowed; otherwise it falls back
  to core's local-only behavior (`LocalRedirectResponse`).

## Consumer negotiation

Which consumer is in effect comes from the Consumers `Negotiator`: `X-Consumer-ID` header, or
`?consumerId=<client_id>` (legacy `?_consumer_id`), else the default consumer. This is how a
request selects which base_url applies.

## Files

- `consumer_base_url.module` — base field, help, consumers-list column, token alter,
  `consumer_base_url_is_graphql_request()`.
- `src/BaseUrlProvider.php`, `src/HttpKernel/ConsumerPathProcessor.php`,
  `src/HttpKernel/ConsumerRouteProcessor.php`,
  `src/EventSubscriber/ConsumerBaseUrlRedirectResponseSubscriber.php`.
- `consumer_base_url.api.php` — `hook_consumer_base_url_routes_alter`.
- Tests under `tests/` (Unit/Kernel/Functional, incl. a GraphQL test submodule).

## Notes for agents

- No admin settings page; configuration is the per-consumer `base_url` field only.
- The route list is shared across all consumers; only the base_url value differs.
- Token/URL rewriting is scoped (tokens: GraphQL only; paths: non-admin, non-GraphQL).
