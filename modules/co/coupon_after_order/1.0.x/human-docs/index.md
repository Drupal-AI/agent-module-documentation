# Coupon After Order — manual setup guide

**Coupon After Order** (`coupon_after_order`) is a Drupal Commerce add-on that
automatically generates a promotion **coupon** once a customer's order is placed, and
emails it to them. It is the classic "thank-you / come-back-soon" reward: a shopper
completes a purchase and receives a fresh discount code for their next order, with no
manual work from your team.

The module hooks into the Commerce order lifecycle (via **State Machine**) and, when
an order reaches the configured state, creates a new coupon for a promotion you have
already set up in Commerce, then sends it to the customer by email. Because of that it
depends on **Commerce** and its **Order**, **Price** and **Promotion** components,
plus **State Machine** — Drupal will pull these in as dependencies when you install
the module.

A word of caution before you turn it on: the coupons this module generates carry
**real monetary value**. The safety limits do not come from this module — they come
from the **promotion** the coupons belong to. Make sure that promotion has sensible
constraints (a usage cap, an expiry date, and single-use-per-customer where
appropriate) so an auto-generated code can't be shared and redeemed for unlimited
discounts. This module provides its own permission but has no other access-control
role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Commerce dependencies.

The module has no dedicated settings page of its own; the behaviour is driven by the
Commerce **promotion** you point it at and by its permission, both described below.

## How it fits together

1. **Create (or choose) a Commerce promotion** under **Commerce → Promotions**, and
   give it the coupon rules you want the reward to follow — the discount, and
   crucially the **limits**: total usage, per-customer usage, and an end date.
2. **Coupon After Order** watches orders and, when one is placed, generates a coupon
   for that promotion and emails it to the customer.
3. Because the value lives in the promotion, tightening the promotion's limits is how
   you keep the reward safe from abuse.

## Permissions

The module provides its own permission, which you grant under **People → Permissions**
(`/admin/people/permissions`) to the roles that should administer this reward
behaviour. Grant it only to trusted staff roles, since it governs a feature that hands
out money-valued coupons.
