# Shopify eCommerce — manual setup guide

**Shopify eCommerce** (`shopify`) brings a Shopify store into your Drupal site. Your
products and collections live and are managed on Shopify — with Shopify's clean
back-office and its checkout — but they are synced down into Drupal as ordinary
Drupal entities so you can display them the Drupal way: fieldable, themeable, and
sitting comfortably alongside the rest of your content. Customers browse the
catalog on your Drupal site and check out through Shopify's own checkout flow.

The idea is to get the best of both worlds. You keep Drupal as your content and
presentation layer, and you let Shopify handle the hard parts of commerce —
inventory, payments, taxes, the checkout. Product entities synced from Shopify can
be styled and arranged just like any other content type, so the storefront feels
native to your site rather than an embedded widget.

This module needs configuration before it does anything useful: you have to connect
it to your Shopify store with API credentials so it knows where to sync from. Two
things are worth stressing on the security side, because they come straight from the
module's own guidance. First, the Shopify API key/token is a secret — store it as an
environment variable or a Key entity, never hard-coded or committed. Second, if you
let Shopify send webhooks to your site (for product or order updates), those webhooks
must be verified: Shopify signs each one with an HMAC signature, and the point of
verifying it is to reject forged calls that only pretend to come from Shopify. Note
also that this module is a community project, not an official Shopify product, and
its releases are not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Shopify store and sync
   products.

## Where it lives in the admin menu

The module's settings form is registered as the `shopify.admin` route. That is
where you enter your Shopify connection details and manage syncing — see
[Configuration](configuration/index.md).
