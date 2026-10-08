# Fundraise Up JS — manual setup guide

**Fundraise Up JS** (`fundraiseup_js`) connects your Drupal site to
[Fundraise Up](https://fundraiseup.com/), a hosted donation platform. Once you
enter your Fundraise Up **Site ID**, the module loads Fundraise Up's JavaScript
widget on every front‑end page and makes its JS API available to your markup —
so you can drop donation buttons and checkout links straight into your content
without touching a theme template.

Under the hood it attaches the Fundraise Up bootstrap `<script>` (served from
`https://cdn.fundraiseup.com/widget/<site_id>`) to the HTML `<head>` of all
non‑admin pages, and emits a small inline flag reflecting the live/test‑mode
toggle. Admin routes are deliberately excluded, so the widget never loads in the
Drupal back‑end. A companion behaviour wires any element carrying a
`data-fundraiseup-js-open-checkout="<campaignId>"` attribute to open the
Fundraise Up checkout on click, meaning you can build donation calls‑to‑action
with plain HTML.

The Site ID is a public identifier, not a secret — it is validated to be
alphanumeric/underscore only and escaped before it reaches the page. Because the
module loads a third‑party script that sees every page a visitor views, treat it
as an egress and consent consideration: add `cdn.fundraiseup.com` to your
Content‑Security‑Policy if you run one, and make sure loading it fits your
privacy/consent posture.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Site ID and choose
   live vs. test mode.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Fundraise Up JS**
(`/admin/config/services/fundraiseup-js`). Access is gated by the
`administer fundraise up js configuration` permission.

## How to use it

Once the Site ID is set, add Fundraise Up elements to your content:

- **Standard Fundraise Up elements** — paste the element markup from your
  Fundraise Up dashboard (for example `<a href="#XXXX">Donate</a>`, where `XXXX`
  is a campaign code) into a body field or block.
- **Open the checkout from any element** — add
  `data-fundraiseup-js-open-checkout="<campaignId>"` to a link or button and the
  module wires it to call `FundraiseUp.openCheckout()` on click, no custom JS
  required.
- **Call the JS API directly** — the `window.FundraiseUp` object exposes methods
  like `on`, `track`, and `set`, so you can react to events such as
  `checkoutOpen` from your own scripts.
