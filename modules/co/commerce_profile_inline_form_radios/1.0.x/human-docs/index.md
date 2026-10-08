# Commerce Profile Inline Form Radios — manual setup guide

**Commerce Profile Inline Form Radios** (`commerce_profile_inline_form_radios`)
provides an alternative Commerce inline form that renders a customer's saved
profiles — their address-book billing and shipping addresses — as **radio buttons**.
Instead of the default rendering, a returning customer sees their stored profiles
listed as selectable options and can pick one with a single click rather than
re-entering their details.

It is a checkout-UX refinement, nothing more: it swaps in a friendlier way to choose
an existing profile. It carries no access-control role of its own, needs no API keys,
and depends only on **Commerce Order** (`commerce_order`). It supports Drupal 9, 10,
and 11.

On its own the base module only *defines* this inline form — it has no visible
checkout effect until something puts it to use. The project ships three optional
submodules that do exactly that, each swapping in the radio-button form for one
integration: a **shipping** pane for Commerce Shipping, a **payment** pane for
Commerce Payment, and a **paypal** override for the Commerce PayPal
add-payment-method form. Enable whichever match the checkout integrations you use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and pick the shipping/payment submodules you need.

There is **no global settings form**. You put the inline form to use by selecting it
as the widget on a profile field or by using the provided checkout panes, described
below.

## Where it lives in the admin menu

The module adds no settings page of its own. Its inline form and the submodules'
checkout panes are selected where you configure checkout — in the relevant profile
field's form display and in your **Commerce → Configuration → Checkout flows**
setup.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). For alternative
   shipping or payment panes, enable the matching submodule too.
2. Use the module's inline form where a customer profile is collected so that saved
   profiles render as radio buttons, letting returning customers pick an existing
   address quickly.
3. Test the storefront checkout as a returning customer with more than one saved
   profile to confirm the radio selection behaves as expected.
