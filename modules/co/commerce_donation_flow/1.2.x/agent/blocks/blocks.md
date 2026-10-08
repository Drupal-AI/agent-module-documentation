<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks

Source: `src/Plugin/Block/DonateBlock.php`, `QuickDonationBlock.php`, `BackToSiteBlock.php`,
`templates/block--commerce-donation-flow-quick.html.twig`.

## `commerce_donation_flow_link` — Donate (`DonateBlock`)

Renders a single **"Donate"** link to `commerce_donation_flow.donation.default` (`/donate`).
Config `return_path` (bool): when on, appends a `donate_return` query arg built from the current
page (front page → `/`, otherwise the redirect destination resolved through the path-alias manager),
so the flow's "Back to Site" link can return the donor where they started. `validateConfigurationForm`
blocks configuring the block unless `donation_route` is `donate`/`both`. Cache contexts: `url.path`,
`url.query_args`.

## `commerce_donation_flow_quick` — Quick Donation (`QuickDonationBlock`)

Renders up to four preset-amount links (`$<amount>`) to `commerce_donation_flow.donation.quick`
(`/donate/{amount}/now`), which creates a draft order at that amount and jumps to payment. Config
`levels` — four `#type => number, #min => 5, #step => 5` amounts (schema
`block.settings.commerce_donation_flow_quick`, sequence of integers). Same route-mode validation
guard as the Donate block. Template `block__commerce_donation_flow_quick` wraps the links in a
`<ul class="commerce--donate--mini-donation-links">`.

## `back_site_block` — Back to Site (`BackToSiteBlock`)

Modeled on core's user-login block. Renders a **"Back to Site"** link: to `<front>` when there is no
`donate_return` query arg, otherwise to `Url::fromUri('internal:' . <donate_return>)`. The
`internal:` scheme means core rejects external/protocol-relative targets — a `//host` value resolves
to an empty href and backslash-tricked values throw, so the link cannot point off-site. Cache
contexts: `url.path`, `url.query_args`.
