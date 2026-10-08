# Syncart — manual setup guide

**Syncart** (`syncart`) is a **vendor-specific custom Commerce cart module** from
the Synapse suite. It extends Drupal Commerce's cart, checkout and order flow with
that vendor's customizations, and it is the e-commerce half of a pair — it is
commonly deployed alongside [`syncabinet`](https://www.drupal.org/project/syncabinet),
which provides profile and authentication for the same stack.

Its public description is minimal ("Custom syncart"), which is a fair signal that
this module is tailored to a particular Synapse/syncart deployment rather than
being a general-purpose cart. It builds on Drupal Commerce's own Cart, Checkout
and Order modules (and Commerce Checkout Link), layering its customizations on top
of Commerce's existing access and behaviour.

Use it only within the Synapse/syncart stack it belongs to. Because it is
vendor-specific, lightly documented, and touches the **cart, checkout and order**
flow — and pairs with an authentication module — it is worth **reviewing its
actual behaviour in your context** before relying on it, especially around cart
ownership, the checkout steps, and any order or price handling. It supports Drupal
8, 9, 10 and 11, and is covered by Drupal's security advisory policy.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, alongside its
   Commerce dependencies, and enable the module.

## How to use it

Syncart's customizations surface within the Drupal Commerce cart and checkout
experience it extends, as part of the Synapse/syncart suite rather than as a
standalone feature. There is no general settings page documented here — consult
the vendor's documentation for how it is configured in your deployment, and
review the cart/checkout/order behaviour it introduces before going live.
