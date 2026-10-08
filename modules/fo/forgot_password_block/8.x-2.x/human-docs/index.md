# Forgot Password Block — manual setup guide

**Forgot Password Block** (`forgot_password_block`) exposes Drupal's
password‑reset request form as a **placeable block**, so the "forgot password"
feature can appear wherever you need it — next to a login form, in a sidebar, or
in a modal — instead of only on its own page at `/user/password`. A visitor types
their email address into the block and Drupal emails them a one‑time reset link.

What the block renders is simply the **core password‑reset request form**, so it
inherits all of core's behaviour. That includes core's anti‑enumeration
protection — the same generic "Further instructions have been sent" message
whether or not the email matches an account — and core's flood control. In other
words, its security is core's security.

The one thing to keep in mind is placement: because the block behaves exactly like
the core form, don't pair it with anything that would reveal whether a given
account exists (that would undo core's careful anti‑enumeration wording).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You use it by placing its
block, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no settings page. You place its block from **Structure → Block
layout** (`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Choose the region where you want the reset form to appear (for example, a login
   area or sidebar) and click **Place block**.
3. Find and place the **Forgot Password** block.
4. Set the block's visibility and title as you would any block, then save.

Once placed, visitors can request a password reset by entering their email address
right in that region — no need to send them to a separate page.
