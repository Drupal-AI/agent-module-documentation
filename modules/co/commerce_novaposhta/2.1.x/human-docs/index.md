# Commerce Novaposhta — manual setup guide

**Commerce Novaposhta** (`commerce_novaposhta`) integrates **Nova Poshta**,
Ukraine's main parcel carrier, with Commerce Shipping. It adds Nova Poshta as a
shipping method, provides a custom checkout field where the customer picks a
settlement/city and a Nova Poshta warehouse (branch), and calculates the delivery
cost by calling the Nova Poshta API 2.0. Use it for Ukrainian stores that ship to
Nova Poshta pickup points.

The problem it solves is offering real Nova Poshta rates and branch selection at
checkout instead of a flat guess. It depends on **Commerce Shipping**
(`commerce_shipping`) and works alongside the **Physical** module's dimension and
weight field types, which you add to your shippable products so the rate query is
accurate.

This is not a works-on-enable module: it needs configuration. You enter your Nova
Poshta API key on the module's settings form, add a Nova Poshta shipping method, add
dimension/weight fields to your products, and enable the Novaposhta address field on
the relevant profile type so customers can choose a branch.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and Commerce Shipping.
2. [Configuration](configuration/index.md) — enter your API key, add the shipping
   method, and wire up the product and profile fields.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → Web services → Commerce
Novaposhta** (`/admin/config/services/commerce-novaposhta`, route
`commerce_novaposhta.novaposhta_config_form`). The shipping method itself is added
under **Commerce → Configuration → Shipping methods**
(`/admin/commerce/shipping-methods`).
