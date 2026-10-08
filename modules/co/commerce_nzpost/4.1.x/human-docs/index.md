# Commerce NZ Post — manual setup guide

**Commerce NZ Post** (`commerce_nzpost`) adds a Commerce Shipping method that
fetches **live international shipping rates** from the **NZ Post RateFinder API** at
checkout. It's for New Zealand merchants shipping overseas: at checkout the module
sends the parcel's dimensions, weight, declared value and destination country to NZ
Post and offers the returned services (keyed by NZ Post service code) as shipping
options.

The problem it solves is quoting real NZ Post international prices instead of a flat
rate. Note one important limitation carried over from the project: it provides
**international estimates only** — because Commerce Shipping can't express a "not New
Zealand" condition in the UI, the module simply returns no rates for domestic (NZ)
destinations. It depends on Drupal **Commerce** and **Commerce Shipping**.

This is not a works-on-enable module: it needs configuration. You add an NZ Post
shipping method, enter your NZ Post API key on it, and make sure your package types
carry dimensions and weight so the rate query is accurate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and Commerce Shipping.
2. [Configuration](configuration/index.md) — add the NZ Post shipping method and
   enter your API key.

## Where it lives in the admin menu

NZ Post is a shipping method, so you set it up under **Commerce → Configuration →
Shipping methods** (`/admin/commerce/shipping-methods`) — add a shipping method and
choose the **NZ Post** plugin.
