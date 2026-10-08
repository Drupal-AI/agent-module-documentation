# Commerce Zones — manual setup guide

**Commerce Zones** (`commerce_zones`) lets you define reusable **territorial
zones** — groupings of geography built from countries, subdivisions
(states/provinces), and postal codes — that other Commerce features can use to
apply zone‑based logic such as shipping rates, availability, or other rules keyed
to where an order ships or is billed.

The problem it solves: many stores treat certain regions specially, and repeating
the same country/postal‑code lists across features is tedious and error‑prone.
Commerce Zones stores each zone as a **config entity** and exposes a Commerce
**condition plugin** based on the billing and shipping address, so any Commerce
entity that supports conditions can be gated by a zone. Its UI is built on top of
the Address module's `address_zone` widget.

It depends on the **Address** (`address`) and **Commerce** (`commerce`) modules
and provides its own permissions. Note that Commerce Zones **does not handle tax
zones** — it is aimed at shipping and other zone‑based logic. It ships two
submodules: an **example** module and a **shipping** integration.

Because zones are managed as config entities (not through a single settings form),
setup happens by creating zone entities and then referencing them from the
relevant Commerce features — see *How to use it* below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and choose the submodules you need.

There is **no single settings page** — you create and manage individual zone
entities and reference them from shipping or other Commerce logic, as described
next.

## Where it lives in the admin menu

Commerce Zones adds zone management within the Commerce configuration area. You
create zones there and then select them from the features that consume them (for
example a shipping method's conditions). Access is governed by the permissions the
module provides.

## How to use it

1. Enable the module (and, if you want shipping integration, the
   `commerce_zones_shipping` submodule).
2. Create one or more **zones**, each defined by the countries, subdivisions,
   and/or postal codes it covers, using the Address‑based zone widget.
3. Reference a zone from a Commerce feature — for example add the Commerce Zones
   **condition** (based on the billing/shipping address) to a shipping method, so
   the method only applies within that zone.
4. Reuse the same zone definitions across as many features as you need.
