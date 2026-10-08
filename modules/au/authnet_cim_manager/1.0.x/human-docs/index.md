# Authorize.Net CIM Manager — manual setup guide

**Authorize.Net CIM Manager** (`authnet_cim_manager`) integrates Drupal with
[Authorize.Net's Customer Information Manager (CIM)](https://www.authorize.net/) — the
part of Authorize.Net that stores a customer's profile and their payment methods at the
gateway. The module lets you **create and update CIM customer and payment profiles**, so
that once a customer's details are stored, repeat transactions are smoother because the
card data lives at Authorize.Net rather than being re-entered each time.

It talks to the Authorize.Net API using your merchant credentials — an API login ID, a
transaction key, and an environment (sandbox or production) — which you configure in the
site's settings. It exposes a form where card and customer details can be submitted to
create a profile at the gateway.

Because this module handles payment data, treat it carefully. The card details entered
into the creation form **pass through your server** on the way to Authorize.Net, which
carries **PCI-DSS obligations** — the same responsibilities any site touching card data
takes on. The merchant credentials are secrets and must be kept out of committed
configuration (see [Configuration](configuration/index.md)). Just as importantly, the
CIM creation form is only gated by the weak **`access content`** permission by default,
which most roles have — so you must restrict who can reach it (details below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — set the merchant credentials safely,
   restrict the CIM creation form, and understand the PCI implications.

## Where it lives in the admin menu

The merchant credentials (API login ID, transaction key, environment) are configured
under the **Administer site configuration** permission. The CIM creation form is exposed
at **`/authnet-cim-manager/cim-creation-fom`** (note the spelling in the route as
shipped).
