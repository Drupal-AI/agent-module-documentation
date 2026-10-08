# Commerce NZ — manual setup guide

**Commerce NZ** (`commerce_nz`) is a small localisation add-on that tailors Drupal
Commerce for **New Zealand** markets. At present its concrete feature is a **New
Zealand GST tax number type** for Commerce Tax, so a store can capture and validate
NZ GST numbers where a tax number is collected.

The problem it solves is giving NZ stores a proper GST number type instead of a
generic text field — the module registers `NewZealandGst` as a tax number type that
Commerce Tax recognises. It has no payment or access-control role of its own, and it
is intended as a home for further NZ-specific Commerce customisations over time. It
depends only on Commerce **Tax** (`commerce_tax`).

This module **works as soon as it is enabled** — there is nothing you must
configure. Once it's on, the New Zealand GST tax number type becomes available
wherever Commerce Tax lets you choose a tax number type (for example on a store or
customer profile that collects a tax number).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page** and no settings form — enabling it is all
that's required.

## How to use it

After enabling, the **New Zealand GST** tax number type is registered with Commerce
Tax. Use it wherever Commerce collects a tax number (such as a store's tax settings
or a customer profile's tax-number field) — Commerce will then treat entered values
as NZ GST numbers and validate them accordingly. There are no other screens or
options.
