# Commerce Referral — manual setup guide

**Commerce Referral** (`commerce_referral`) provides a **refer-a-friend reward
system** for Drupal Commerce, built on top of Commerce promotions. Each customer
gets a unique referral code to share; when a friend uses it at checkout they get a
discount, and once the order is placed (or paid), the referrer automatically
receives a **kickback** reward coupon they can spend on a future order.

The problem it solves is running a two-sided referral programme without wiring
promotions and coupons together by hand. Commerce Referral generates the referral
codes automatically, applies the friend's discount through a promotion, tracks who
referred whom, and issues the referrer's kickback coupon on the trigger you choose.
It supports multiple referral **types** (each mapped to different promotions),
lets you control who may generate referral codes via configurable conditions,
**prevents users from using their own code**, and gives admins reporting on
successful referrals. It depends on **Commerce** (`commerce`) and **Commerce
Promotion** (`commerce_promotion`) and provides its own permissions.

Because kickbacks have real monetary value, treat this as security-sensitive.
Referral codes are user-visible, so attribution must be validated server-side, and
the built-in self-use prevention is important — keep it on. Referral and reward
data ties to real users (personal and financial information), so handle it
accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Promotion.
2. [Configuration](configuration/index.md) — set up referral types, the kickback
   trigger, access conditions, and the underlying promotions.

## Where it lives in the admin menu

Commerce Referral is administered under **Commerce**, where you configure the
referral programme (types, kickback timing, and access) and view referral
reporting. The customer-facing referral page is where a visitor's unique code is
generated.
