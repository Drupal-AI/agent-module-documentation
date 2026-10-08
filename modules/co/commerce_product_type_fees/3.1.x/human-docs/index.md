# Commerce Product Type Fees — manual setup guide

**Commerce Product Type Fees** (`commerce_product_type_fees`) lets you add
configurable **percentage fees per Commerce product type**. When a customer's cart
contains a product of a given type, the fee you defined for that type is applied to
the order — a handling charge, a deposit, a surcharge, or any similar extra. You can
define as many fees as you like.

You manage the fees from a single settings form: pick a product type, add one or
more percentage fees, and save. From then on, any order containing products of that
type has those fees applied to its subtotal automatically. Because the fees are
applied through Commerce's order-processing pipeline, they are calculated
server-side and are authoritative — the customer sees the fee reflected in the order
total, not just as a display gimmick.

It depends on **Commerce** (`commerce`), **Commerce Order** (`commerce_order`), and
**Commerce Product** (`commerce_product`). It has no access-control role and needs no
API keys.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add percentage fees per product type.

## Where it lives in the admin menu

The module provides a fee configuration form under **Commerce → Configuration**,
where you choose a product type and add the percentage fees that apply to it.
