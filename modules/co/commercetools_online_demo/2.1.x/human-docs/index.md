# commercetools Online Demo — manual setup guide

**commercetools Online Demo** (`commercetools_online_demo`) spins up a
**zero‑click commercetools demo** — a pre‑configured **B2C Lifestyle** store — on
top of the commercetools base integration, so you can see a working
commercetools‑backed storefront without any manual setup. Free demo backend data
(products, orders, etc.) is provided by EPAM and commercetools.

The problem it solves: evaluating the commercetools Drupal integration normally
means creating an account and wiring up credentials. This project skips all of
that — it deploys a fully functional demo store out of the box, letting you log in
as admin (username and password both `admin`) and explore. You can later register
a free commercetools trial account and point the demo at your own project to test
with your own products and workflows.

This is a **demo / showcase** project — it is **not intended for production**. It
builds on the whole commercetools suite and adds core translation support, so
enabling it pulls in a number of dependencies (listed under Installation). There
is no dedicated settings form of its own; you configure things on the commercetools
modules it deploys (and on its demo settings page if you connect your own account).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   demo.

There is **no separate configuration page** for this project itself — the
storefront comes pre‑configured, and any credential setup happens on the
underlying **commercetools** module's settings (or the demo settings page).

## Where it lives in the admin menu

Once deployed, browse the storefront on the front end and log in as admin
(`admin` / `admin`) via the **Log in** link. To connect your own commercetools
trial account instead of the shared demo data, use the demo settings page and the
underlying commercetools module's settings at **Configuration → commercetools**
(`/admin/config/system/commercetools`).

## How to use it

1. Install and enable the demo (see [Installation](installation/index.md)) — the
   B2C Lifestyle store deploys automatically.
2. Visit the front end and browse the pre‑built storefront.
3. Log in with `admin` / `admin` to explore the admin side.
4. Optionally register a free commercetools trial and configure it to test with
   your own catalog and workflows.
