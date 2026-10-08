# Etsy API — manual setup guide

**Etsy API** (`etsy`) is the base integration that connects a Drupal site to the
**Etsy** marketplace via version 3 of the Etsy API, authenticating with **OAuth2**.
It is designed for a shop owner who wants to integrate a single Etsy shop with their
Drupal website — pulling listings, orders or other shop data.

By itself, Etsy API is a **connectivity layer**: it provides a service wrapper
around the Etsy API and does nothing user‑facing on its own. Other modules and
custom code (including the companion *Etsy Shop* module, which is a base/example
implementation) build shop features on top of it by depending on this module. If you
just want the plumbing to talk to Etsy, this is the module you need.

Because it authenticates against a third‑party API, it involves **egress** (your
site calls Etsy's servers) and **credentials** (an Etsy keystring and shared secret).
Those credentials are entered and stored through the required **OAuth2 Client** module
(at `/admin/config/system/oauth2-client`), and the resulting access token is kept in
Drupal's state store; the Etsy API settings form itself only holds the shop id and a
cache lifetime. Access to those settings is gated by the **Administer Etsy settings**
permission (`administer etsy settings`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its OAuth2 / image dependencies.
2. [Configuration](configuration/index.md) — connect your Etsy shop with OAuth2 and
   store the API credentials safely.

## How to use it

On its own, Etsy API just establishes and authenticates the connection to your Etsy
shop. To surface Etsy data on your site, either use the companion *Etsy Shop* module
as a starting point or build your own features against the service this module
provides. Once the connection is authorized, your custom integration can fetch
listings, orders and shop data through the wrapper.
