# Commerce Agree to Terms — manual setup guide

**Commerce Agree to Terms** (`commerce_agree_terms`) adds a single checkout pane
to [Drupal Commerce](https://www.drupal.org/project/commerce): an "I agree to the
Terms and Conditions" checkbox that links to a page of your choice and **blocks
the customer from completing the order until they tick it**. It is the simple,
compliance-friendly way to capture explicit consent — terms of sale, a privacy
policy, distance-selling or GDPR-style acceptance — right at the point of purchase.

The pane links its checkbox label to any existing node on your site (your Terms &
Conditions page, for example), and you control all of the wording: the prefix text
around the link, the link text itself, an optional help description, and the exact
error message shown if the customer forgets to tick the box. You can also choose
whether the terms link opens in a new tab so the customer doesn't lose their cart.

The module is deliberately tiny — one checkout pane and nothing else. It has **no
global settings page, no permissions, and no Drush commands**: everything is
configured inside the pane's own form on your Commerce checkout flow, which is why
the configuration page here walks through that flow editor rather than a dedicated
admin screen.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Commerce must be present).
2. [Configuration](configuration/index.md) — add the pane to a checkout flow,
   point it at your terms page, and set the wording.

## Where it lives in the admin menu

There is no page of the module's own. You add and configure the pane from
**Commerce → Configuration → Checkout flows**
(`/admin/commerce/config/checkout-flows`) by editing the checkout flow you want the
terms checkbox to appear in.
