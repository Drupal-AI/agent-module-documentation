# Access Conditions Commerce — manual setup guide

**Access Conditions Commerce** (`access_conditions_commerce`) connects the
[Access Conditions](https://www.drupal.org/project/access_conditions) module to
Drupal Commerce's checkout. It gives you drop-in replacements for the standard
Commerce checkout panes — login, contact information, billing, order summary,
review, payment and coupon — whose visibility is driven by reusable **access
models** you define once in Access Conditions.

Use it when different customers should see different checkout steps. For example,
you might hide the payment pane for a segment whose orders are always zero-value,
or show a coupon-redemption field only to certain roles. Instead of writing
custom code for each rule, you build an access model once and point any number of
panes at it.

The visibility is display-only. If any selected access model grants access, the
pane is shown; otherwise it is hidden. Leaving a pane's access-models setting
empty falls back to that pane's normal default visibility, and the payment
process pane keeps Commerce's own logic (it stays hidden when the order is already
paid or free). Because it only shows and hides panes, it never bypasses
Commerce's real order and access logic — treat it as a presentation aid, not a
security control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, and enable the
   checkout / payment / promotion submodules you need.

## Where it lives in the admin menu

This module has no settings page of its own. Everything is configured on your
existing **Commerce checkout flow** at **Commerce → Configuration → Checkout
flows** (`/admin/commerce/config/checkout-flows`), where its panes appear
alongside the standard ones.

## How to use it

1. First create your access models in **Access Conditions** — the panes reference
   these by name, so they must exist before you can select them.
2. Enable the submodule(s) that cover the panes you need (checkout, payment,
   promotion — see [Installation](installation/index.md)).
3. Edit your checkout flow. Each replacement pane is labelled as the
   "…with access conditions" variant of a standard pane (for example *Login with
   access conditions*). Drag the variant onto the checkout step where you want it,
   in place of the standard pane.
4. Open that pane's settings and, under **Visible to certain access models**,
   pick one or more access models. If *any* of them grants access to the current
   visitor, the pane is shown; if none do, it is hidden.
5. Save the checkout flow.

The replacement panes default to the hidden `_disabled` step until you place them
onto a flow, so nothing changes in checkout until you configure them. Test the
result as both an anonymous guest and a logged-in customer, and — before going
live — confirm the payment panes still appear for paying customers.
