<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cha-ching is a donation register: it records PayPal Instant Payment Notification (IPN) data and publishes aggregate donation metadata as JSON, RSS and a graph.

---

PayPal POSTs IPNs to `/paypal/ipn` (and legacy `/lm_paypal/ipn`). The controller re-posts the payload back to PayPal with `cmd=_notify-validate` over HTTPS (cURL, default TLS verification) and only accepts it when PayPal replies `VERIFIED`; it then checks the `receiver_email` against the configured allow-list before inserting the row into `chaching_paypal_ipns`. Only fields present in the module schema are stored. Read routes expose the data: `/v1/donations/{type}/{period}/{format}/{filter}` returns totals/lists as JSON (with an optional sanitised JSONP `callback`, `\W` rejected) or RSS, `/graph/{period}` renders a jqPlot chart, and `/docs` shows API examples. The IPN routes are intentionally `_access: TRUE` (public, POST-only) because PayPal is unauthenticated — but every write is gated by the PayPal round-trip verification and receiver-email check. All read routes require the `access chaching metadata` permission, which exposes only non-PII amount/date aggregates.

Setup: configure receiver email(s) at `/admin/config/services/chaching` and point your PayPal IPN URL at `/paypal/ipn`. (Reviewed as SOUND: the IPN callback verifies with PayPal before recording.)

---
- Record PayPal donations via IPN automatically
- Validate every IPN against PayPal before storing it
- Reject IPNs whose receiver_email is not on the allow-list
- Configure one or more accepted PayPal receiver emails
- Expose total donations for a period as JSON
- Expose a list of donations as JSON
- Serve donation data as JSONP with a sanitised callback
- Publish a donations RSS feed
- Render a donation graph with jqPlot
- Show month-to-date / year-to-date / all-time totals
- Provide an API docs page with example calls
- Grant a role `access chaching metadata` for the feeds
- Support legacy `/lm_paypal/ipn` callback path
- Drive a public "donations so far" widget
- Keep donation feeds cache-tagged and invalidated on new IPNs