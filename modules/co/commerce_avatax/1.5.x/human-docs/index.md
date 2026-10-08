# Commerce AvaTax — manual setup guide

**Commerce AvaTax** (`commerce_avatax`) connects **Drupal Commerce** to
**Avalara AvaTax** for real‑time sales‑tax calculation. Instead of maintaining
your own tax rates and rules, it sends each order's line items and shipping
addresses to Avalara's tax service and applies the tax that comes back as order
adjustments. It also commits and voids transactions in AvaTax as orders are
placed and cancelled, validates customer addresses at checkout, and supports tax
exemptions for B2B/wholesale customers.

Technically, the module adds an `avatax` remote tax type to Commerce. During
order refresh it calls Avalara's REST v2 API, applies the returned tax, and — on
order placement — commits a sales invoice transaction (voiding it again if the
order is cancelled or deleted). It adds a few fields along the way: a per‑store
company code, a per‑product‑variation Avalara tax code, and per‑user customer
code and tax‑exemption fields. An optional address‑validation feature offers
customers corrected‑address suggestions during checkout.

To use it you need an **Avalara AvaTax account** — an account ID and a license
key, which you enter on the settings form (store these as environment
variables/secrets rather than committing them). You can point the module at
Avalara's **sandbox** while developing and switch to **production** when you go
live. The settings form even checks your credentials and company code against
Avalara when you save.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Commerce is required).
2. [Configuration](configuration/index.md) — the settings form field by field,
   the per‑store/per‑product/per‑user fields, address validation, and the two
   permissions.

## Where it lives in the admin menu

The settings form sits under Commerce at **Commerce → Configuration → AvaTax
settings** (`/admin/commerce/config/avatax`). It is gated by the restricted
**Administer commerce AvaTax** permission, so only trusted administrators can see
your Avalara credentials.
