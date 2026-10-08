# Commerce License — manual setup guide

**Commerce License** (`commerce_license`) is a framework for a Drupal Commerce
store to **sell access to something** — most commonly a Drupal role, but also a
local or remote resource — by issuing a **License** to the buyer when they
purchase a licensed product. Each license grants its access for a configurable
period and can expire automatically, or renew on a subscription.

Here is the shape of it. When you mark a product variation as "providing a
license" and someone buys it, the module creates a `commerce_license` entity for
that customer. What the license grants is decided by a **License type** plugin
(the built‑in one is **role**, which adds a Drupal role while the license is
active). When it expires is decided by a **License period** plugin — **unlimited**
(never expires), **rolling interval** (e.g. 30 days after purchase), or **fixed
reference date** (e.g. always the end of the year). The license moves through a
lifecycle (new → pending → active → expired/revoked/canceled) tracked by a state
machine, and cron takes care of expiring overdue licenses through a background
queue.

This is a developer‑ and store‑builder‑oriented module with real setup involved —
it does **not** do anything just by being enabled. You configure it by wiring up
Commerce entity types (checkout flow, order type, order item type, product
variation type) with two **entity traits**, then setting a license type and
expiration on each licensed product variation. It builds on Drupal Commerce and
depends on `commerce`, `commerce_checkout`, `commerce_product`, `state_machine`,
`advancedqueue`, `interval`, and `entity`. It ships **no submodules**, but
integrates optionally with **Commerce Recurring** for subscription‑renewing
licenses. It is fully extensible: you can implement your own License type or
License period plugins.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.
2. [Configuration](configuration/index.md) — the full wiring: traits on the
   Commerce entity types, license type and expiration on a product variation,
   subscriptions, and permissions.

## Where it lives in the admin menu

- Issued licenses are managed at **Commerce → Licenses**
  (`/admin/commerce/licenses`).
- License types (the bundles) are at **Commerce → Configuration → Licenses →
  License types** (`/admin/commerce/config/licenses/license-types`).
- A status **dashboard** is at `/admin/commerce/config/licenses/dashboard`.
- The traits and expiration settings live on the ordinary Commerce configuration
  pages for checkout flows, order types, order item types, and product variation
  types.

## How to use it

At a high level: enable the "Provides a license" trait on a product variation
type, enable the matching order‑item trait, then on each product variation choose
a **License type** (e.g. role) and a **License expiration** (a license period). A
customer who buys it is issued a license automatically, and access is granted and
later revoked as the license changes state. See
[Configuration](configuration/index.md) for the step‑by‑step wiring.
