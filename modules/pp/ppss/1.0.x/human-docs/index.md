# Platform of Payments and Sales Simple — manual setup guide

**Platform of Payments and Sales Simple** (`ppss`) is a lightweight way to accept
payments on a Drupal site without standing up a full commerce stack. It is aimed
at small service agencies that only sell a handful of subscription plans — for
example a monthly or yearly plan — and just need a "pay" button rather than a
catalogue, cart, and checkout.

The module provides a configurable **payment button/block** that you place on your
site and wire up to a payment gateway. On its own it does very little; its value
comes from bridging your content to a gateway so visitors can pay for a plan or a
service directly. You choose which gateway to use, which content types show the pay
button, and where visitors are sent after a successful payment or an error.

Because it handles real payments, the gateway credentials it uses are secrets and
must be stored securely rather than pasted into configuration that ends up in
version control. Access is governed by two permissions: **`view ppss button`**
controls who can see the pay button, and **`administer ppss`** controls who can
configure the module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This module does not carry Drupal's security advisory coverage. Review
> it yourself before using it to process real payments, and keep it updated.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choosing a gateway, storing its
   credentials securely, and setting the return URLs.

## Where it lives in the admin menu

The module provides a settings form for choosing the gateway, the content types
that show the button, and the return URLs, reachable by a user with the
**`administer ppss`** permission. The pay button itself is a **block**, so you
place it through **Structure → Block layout** (or embed it where your content type
allows).
