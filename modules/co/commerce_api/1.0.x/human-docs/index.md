# Commerce API — manual setup guide

**Commerce API** (`commerce_api`) exposes Drupal Commerce over **JSON:API** so you
can build a decoupled (headless) storefront — a React, Next.js, or mobile front
end — on top of a Drupal Commerce backend. It provides the commerce-shaped
endpoints a storefront needs: a *current store* resource, cart and checkout
resources, and webhook endpoints for driving order state transitions from an
external system.

Its most distinctive feature is the **cart token**. Normally a Drupal cart is
tied to the visitor's PHP session cookie, which is awkward for a JavaScript app.
Commerce API lets an anonymous shopper hold a cart without a Drupal session: a
request carrying the `Commerce-Cart-Token` header has its cart looked up from a
shared tempstore keyed by that token instead of the session. There is also a
`?cartToken=` query-parameter form, which exists so you can hand a cart from a
decoupled front end to Drupal's own checkout via a redirect.

Rather than reinventing a REST layer, the module builds on the contrib
`jsonapi_resources` and `jsonapi_hypermedia` modules and core JSON:API. It adds a
UUID param converter (so paths use UUIDs instead of internal ids), field access
control, address and shipment normalizers, and hypermedia links so a client can
discover the available checkout steps. It has **no configuration form, no
permissions of its own, no config schema, and no Drush commands** — installing it
and its dependencies is essentially all the setup there is.

This guide is written for a **human** setting up the backend. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside its
   Commerce and JSON:API dependencies, then enable it.

## Where it lives in the admin menu

Nowhere — Commerce API adds no admin pages. It registers JSON:API endpoints under
the `%jsonapi%` prefix (for example `/jsonapi/current-store`) and the webhook
routes `/webhooks/fulfillment/{order}` and `/webhooks/order/{order}/{transition}`.
Your storefront and integrations talk to those URLs directly.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)). Enabling it also brings up JSON:API,
   `jsonapi_resources`, and `jsonapi_hypermedia`.
2. From your front end, fetch **`/jsonapi/current-store`** to get the active
   store's details, and use the cart and checkout resources to build a cart and
   run checkout through JSON:API calls.
3. For anonymous carts, send the `Commerce-Cart-Token` header on cart requests so
   the cart is tracked without a Drupal session. Use the `?cartToken=` query form
   only for the redirect hand-off into Drupal's own checkout.
4. To sync order status from a fulfilment provider, have that system call the
   webhook routes to apply an order transition. Both webhook routes require
   `commerce_order.update` entity access, so an unauthenticated caller cannot
   drive them unless your site grants that access — plan how those calls will be
   authenticated.
5. Standard JSON:API tooling and the hypermedia links in responses let a client
   discover the available checkout steps and related resources.
