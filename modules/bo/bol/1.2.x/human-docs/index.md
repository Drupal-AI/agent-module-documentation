# BOL (Bill of Lading) — manual setup guide

**BOL (Bill of Lading)** (`bol`) produces a **bill of lading** — the
inventory/shipping document that lists the goods in a shipment — from your site's
content and data. It is a business/logistics helper: rather than an integration
with any external marketplace, it generates the shipping document itself for use
in logistics workflows. This release targets Drupal 10 and 11.

A bill of lading contains real **business and shipment data** — shipper and
consignee details, and the goods being moved. Handle and protect the generated
documents according to your own data policy. The module has no access‑control
role of its own.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, use the module to generate a bill of lading from your content/data
for your logistics workflow. Because the resulting document carries shipment and
party details, store and share it only as your data‑handling policy allows.

> The upstream documentation for this module is thin; the description above
> reflects what its own docs state (a bill‑of‑lading document generator). Confirm
> the exact generation workflow against the module on your site.
