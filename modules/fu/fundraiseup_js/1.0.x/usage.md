<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fundraise Up JS adds the third-party Fundraise Up donation widget loader to every non-admin page and exposes its JS API to your markup.
---
The module configures a single Site ID (`/admin/config/services/fundraiseup-js`) and, via `hook_page_attachments()`, injects the Fundraise Up bootstrap `<script>` (loaded from `https://cdn.fundraiseup.com/widget/<site_id>`) into the HTML head of all front-end pages. It also emits a small inline script setting `window.fundraiseup_livemode` from the "Live Mode" toggle, so you can run donations in test vs. live mode. Admin routes are excluded from the injection.

The Site ID is validated on save to be alphanumeric/underscore only (`^[a-zA-Z_0-9]+$`) and is additionally passed through `Html::escape()` and a Twig `inline_template` context variable before output, so the injected value is sanitized. Config access is gated by the `administer fundraise up js configuration` permission. A companion Drupal behavior (`js/fundraiseup_js.js`) wires any element carrying `data-fundraiseup-js-open-checkout="<campaignId>"` to call `FundraiseUp.openCheckout()` on click.

Typical setup: install, set the Site ID from your Fundraise Up dashboard, choose live/test mode, then drop Fundraise Up element markup (e.g. `<a href="#CODE">`) or `data-fundraiseup-js-open-checkout` attributes into your content.
---
- Add the Fundraise Up donation widget to a nonprofit site.
- Configure the Fundraise Up Site ID at the settings form.
- Toggle live vs. test donation mode site-wide.
- Load donation buttons via Fundraise Up element markup (`<a href="#CODE">`).
- Open the checkout modal from any element using a data attribute.
- Trigger `FundraiseUp.openCheckout(campaignId)` on click without custom JS.
- Call Fundraise Up JS API methods (`on`, `track`, `set`, ...) via `window.FundraiseUp`.
- Log or react to `checkoutOpen` and other Fundraise Up events.
- Keep the widget off admin pages automatically.
- Restrict who can change the Site ID via a dedicated permission.
- Run in test mode on staging and live mode in production.
- Pass live-mode state to front-end JS through `drupalSettings`.
- Embed donation calls-to-action inside body/WYSIWYG content.
- Add multiple campaign buttons referencing different campaign IDs.
- Ensure the Site ID is sanitized before it reaches the page (module does this).
- Integrate donations without a custom theme template change.
- Confirm the CDN script only loads when a Site ID is configured.
- Warn (log) when the Site ID is missing on a page build.
- Provide fundraising integration for a decoupled-friendly progressive site.
- Audit the third-party script origin (cdn.fundraiseup.com) for CSP policy.
