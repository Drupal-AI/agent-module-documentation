<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commercetools — agent start

Base integration between Drupal and the **commercetools** headless/API-first commerce
platform (2.2.0, core `^9 || ^10 || ^11`). Connects to a commercetools **project** over the
REST/GraphQL API using **OAuth2 client credentials** and caches responses locally so product
pages render fast. Products, customers and orders live on the commercetools side — the Drupal
DB stores only cached catalog data, not PII.

This is the **base module and ships no end-user UI**. Add one UI submodule:
- **commercetools_content** — coupled: renders storefront on the backend (pre-rendered pages).
- **commercetools_decoupled** — decoupled: ships Web Components that load data on the frontend
  via a GraphQL proxy (usable in React/Vue/Angular SPAs).

Admin hub: **Configuration → commercetools** — `/admin/config/system/commercetools`
(route `commercetools.settings`, form `GeneralSettingsForm`, perm `administer site configuration`).

## Dependencies (composer)

Third-party PHP libs (real, from `composer.json`): `commercetools/commercetools-sdk ^10.14`,
`webonyx/graphql-php ^14.11`, `cfpinto/graphql ^2.0`, `symfony/intl`, `punic/punic`. No Drupal
module dependencies. (Bootstrap CSS is used by default templates but is **not** required — a
`BootstrapChecker.js` lib just warns if absent; templates are overridable.)

## Submodules (in this project, documented here)

| Submodule | Purpose |
|-----------|---------|
| `commercetools_content` | Backend-rendered storefront: catalog/product/cart/checkout/order controllers, blocks, forms, an Ajax block-render endpoint. |
| `commercetools_decoupled` | Frontend Web Components + a GraphQL **proxy** endpoint and a limited-scope FE-auth token endpoint. |
| `commercetools_demo` | Deploys demo B2C/B2B content + config without a real commercetools account. |
| `commercetools_entity` | External Entities storage clients mapping CT products/categories to Drupal entities (dev-only `external_entities`). |

## Subdocs

- API service, OAuth2 auth, hosts, GraphQL execution & caching → [api-and-auth.md](api-and-auth.md)
- Config objects, settings forms, routes, permission, cache invalidation → [configuration.md](configuration.md)
- Submodules: content (UI/routes/Ajax), decoupled (proxy/FE-auth), demo, entity → [submodules.md](submodules.md)

## Key services (base module `*.services.yml`)

- `commercetools.api` (`CommercetoolsApiService`) — the API/GraphQL gateway (OAuth2, host build,
  response caching). Interface `CommercetoolsApiServiceInterface`.
- `commercetools` (`CommercetoolsService`), `commercetools.config` (`CommercetoolsConfiguration`),
  `commercetools.localization`, `commercetools.products`, `commercetools.carts`,
  `commercetools.customers`, `commercetools.messages`, `commercetools.subscriptions`.
- Cron (`CommercetoolsCron`) polls CT **messages** to invalidate caches; commercetools
  **Subscriptions** (webhook) can replace cron for instant invalidation.

## Config & extension surface

- Config objects: `commercetools.api`, `commercetools.settings`,
  `commercetools.subscriptions_settings`, `commercetools.subscriptions_destination_sqs`,
  `commercetools.locale`. Schema in `config/schema/commercetools.schema.yml`.
- Permission: `view own commercetools orders`.
- Plugin type: **subscription destination** (`plugin.manager.commercetools_subscriptions_destination`,
  attribute/annotation `SubscriptionDestinationType`; ships an `sqs` plugin).
- Events: `CommercetoolsGraphQlOperationEvent` / `…ResultEvent` (alter/allow GraphQL ops & cache),
  `CommercetoolsConfigurationEvent`, `CommercetoolsMessageEvent`, `CommercetoolsOrderCreate`.
  Hook/extension docs in `commercetools.api.php`.

## Credentials (accurate mechanism)

Client ID / Client secret / Project key / API scope / hosted region are entered on the settings
form and stored in the `commercetools.api` **config object** (plaintext Drupal config — there is
no built-in Key/env integration). The service reads them via `config.factory`, so a settings.php
**config override** (`$config['commercetools.api']['client_secret'] = getenv('…');`) is the
standard way to keep the secret out of committed config sync. The OAuth token endpoint, API host
and session host are fixed to `https://{api,auth,session}.<region>.commercetools.com`, with
`<region>` chosen from a fixed select list of 5 commercetools regions.
