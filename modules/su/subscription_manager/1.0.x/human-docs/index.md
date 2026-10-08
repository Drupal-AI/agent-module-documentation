# Subscription Manager — manual setup guide

**Subscription Manager** (`subscription_manager`) lets a Drupal site grant paid
subscriptions — and the roles that come with them — to logged-in users, while the
actual billing lives with a remote provider such as Stripe, Recharge, Chargebee, or
Shopify. It gives your site a consistent "My Membership / Manage Billing" surface
without your site having to own any payment logic.

The way it works is that Subscription Manager stores **local** Subscription and
Subscription Plan entities that mirror a contract held in the remote billing
service, and it routes users to that provider's hosted portal or checkout through
**connector plugins**. A connector maps the remote service's customers, plans, and
subscriptions onto the local entities, so you can sell access that grants specific
Drupal roles — for example, selling access to certain content. Connectors react to
their provider's webhook events to create, update, and delete subscriptions, and
all the user-facing copy is config-driven so you can reword and theme the subscribe
flow without patching the module.

This module is the **framework**; on its own it does not talk to any one provider.
You install a separate **connector module** (Stripe Subscription, Recharge
Subscription, Chargebee Subscription, or Shopify Subscription), set it as the
default connector, create your plans, and grant users the permission to manage
their own subscription. The module itself has **no contributed-module
dependencies**.

Security here is deliberately hardened, which is worth knowing when you rely on it:
every route is permission-gated, and the self-service routes also require the user
to be logged in. The "manage subscription" route checks ownership twice — once
before the controller runs and once inside it — so an authenticated user cannot
open someone else's billing portal. And the post-purchase auto-login flow uses
signed, expiring tokens (HMAC-SHA256, verified with a constant-time comparison,
keyed from the site's private key) rather than a guessable order id, closing a hole
that such flows can otherwise have. There are no anonymous mutating endpoints.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the terser sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add a connector.
2. [Configuration](configuration/index.md) — set the default connector, create
   plans, grant permissions, and wire up the member-facing links.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Subscription Manager**
(`/admin/config/services/subscription_manager`), behind the *Administer
subscription manager* permission. Members reach their subscription through
`/user/my-subscriptions` (which redirects to a configured manage route) and
`/user/{user}/manage-subscription`; there are also JSON API endpoints under
`/subscription-manager/api/…` for decoupled front ends.
