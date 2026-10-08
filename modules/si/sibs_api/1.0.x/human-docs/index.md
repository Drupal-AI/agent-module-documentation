# SIBS API — manual setup guide

**SIBS API** (`sibs_api`) is the base integration layer for **SIBS**, the leading
electronic-payment processor in Portugal and one of Europe's largest. On its own it
is not a checkout button you drop onto a page — it is the client/service library that
knows how to talk to the SIBS payment API: authenticating with your merchant
credentials, creating payments, and querying their status. Higher-level modules build
on top of it, most notably **SIBS API Commerce**, which turns this foundation into an
actual Drupal Commerce payment gateway.

Think of SIBS API as the plumbing. It gives Drupal a reliable, authoritative way to
create and check SIBS payments — supporting the payment methods SIBS is known for in
Portugal, such as MB WAY, direct credit-card payments, and ATM (Multibanco) reference
payments — while leaving the storefront and order handling to the modules layered
above it. It provides its own permissions and belongs to the SIBS package.

Because this library **calls the SIBS payment API over the network using your merchant
credentials (API keys)**, two things matter for security. First, those credentials
authorise real payment operations, so store them as **secrets** — in an environment
variable or via the Key module — never hard-coded or committed, and always send them
over HTTPS. Second, payment status should always be taken from SIBS's own
authoritative API (which is exactly what this layer provides) rather than trusted from
anything a browser sends. Note that using SIBS requires a **contract with SIBS** to
activate the API for your site.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

SIBS API is a foundation module: on its own it exposes no storefront. In practice you
install it together with a module that uses it — such as **SIBS API Commerce** for
Drupal Commerce — and you supply your SIBS **merchant credentials**, kept as secrets.
The credentials you configure here are what the higher-level gateway uses to create
and verify payments against SIBS's authoritative API.
