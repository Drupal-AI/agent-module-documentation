<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commercetools — submodules

## commercetools_content (coupled UI)

Backend-rendered storefront. Routes are built dynamically by
`Routing\RouteProvider` (catalog, product, cart, checkout, order, orders pages)
plus:
- `commercetools_content.api.ajax` — `/api/commercetools/ajax` (`_access: TRUE`),
  `CommercetoolsAjaxController` re-renders selected page blocks by internal
  `target_url` for in-page interactions.

Controllers: `CommercetoolsCatalogController`, `CommercetoolsProductController`,
`CommercetoolsCheckoutController`, `CommercetoolsOrderController` (single order —
gated to the current user + own customer id), `CommercetoolsOrdersController`
(order list for a user). Forms: AddToCart, Cart, CatalogFilters, ProductSearch,
OrderSubmission, ContentSettings. Blocks: product list / filters / categories /
cart summary / product search. Services: `commercetools_content.ajax_helper`,
`…html_renderer`, `…components`.

## commercetools_decoupled (decoupled UI)

Ships Web Components that render on the frontend and talk to commercetools via a
server-side GraphQL proxy. Routes:
- `commercetools_decoupled.api_proxy` — `<base>/{projectId}/graphql`
  (`_access: TRUE`, `_format commercetools_graphql`). `CommercetoolsApiController::apiProxyGraphql`
  forwards a POSTed `{query, variables}` to `commercetools.api`. Requests are
  filtered by an **operation allow-list** in
  `CommercetoolsDecoupledGraphQlProxyAccessSubscriber` (product search/list,
  categories, cart, order-from-cart, orders, customer ops), with cart operations
  bound to the session cart via `[current_cart:id]` token replacement.
- `commercetools_decoupled.fe_auth` — `GET /api/commercetools/fe-auth`
  (`_access: TRUE`). `CtAuthController::getAuth` returns a **limited-scope** OAuth
  Bearer header (`view_published_products`, `view_categories`) for the browser to
  call commercetools directly (e.g. the checkout SDK); response is private and
  cached only until the token expires.
- `commercetools_decoupled.settings` — admin form (proxy base path etc).

Pages controller `DecoupledPagesController` renders catalog/product/cart/checkout/
order Web Components. Blocks mirror the content submodule's set.

## commercetools_demo

`DemoConfigurationDeployer` + `CommercetoolsDemoForm` deploy demo B2C/B2B content,
blocks, theme config and a locale switcher so the storefront can be tried without
a real commercetools account. Demo config in `config/demo/*.yml` carries only
display settings (e.g. `items_per_page`); credentials are provisioned at deploy
time (no secrets committed).

## commercetools_entity

External Entities storage clients
(`Plugin/ExternalEntities/StorageClient/CommercetoolsProductsGraphQL`,
`CommercetoolsCategoriesGraphQl`) that expose commercetools products/categories as
Drupal external entities. Requires `drupal/external_entities` (a dev-only
`require-dev` dependency of the base module — install it explicitly to use this).
