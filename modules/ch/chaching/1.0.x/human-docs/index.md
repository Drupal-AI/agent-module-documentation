# Cha-ching — manual setup guide

**Cha-ching** (`chaching`) is a donation register. It records **PayPal Instant
Payment Notification (IPN)** data — the server-to-server messages PayPal sends
when a payment completes — and publishes aggregate donation metadata (amounts and
dates) as **JSON** and **RSS** feeds and as a rendered **graph**. That makes it
easy to drive a public "donations so far" widget or a live fundraising chart. It
was originally built for Noisebridge, a hackerspace in San Francisco.

Here's the flow: PayPal POSTs an IPN to your site at `/paypal/ipn` (a legacy alias
`/lm_paypal/ipn` also works). Cha-ching's controller re-posts the exact payload
back to PayPal over HTTPS with `cmd=_notify-validate` and only accepts it when
PayPal replies `VERIFIED`. It then checks the payment's `receiver_email` against an
allow-list you configure before storing the row. Read routes then expose the data:
totals and lists as JSON (with an optional sanitized JSONP callback) or RSS, a
jqPlot chart, and an API docs page with example calls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

**On the "public" IPN routes:** the IPN endpoints are intentionally open
(`_access: TRUE`, POST-only) because PayPal is an unauthenticated caller — that's
how IPN works. This is safe here because *every write is gated*: nothing is stored
until PayPal itself confirms the payment (`VERIFIED`) **and** the receiver email
matches your allow-list, and only known schema fields are saved. The read feeds
require the **`access chaching metadata`** permission and expose only non-personal
amount/date aggregates (no PII). It supports Drupal 10.2 and 11.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set your accepted PayPal receiver
   email(s), point PayPal at the IPN URL, and use the feeds.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Cha-ching**
(`/admin/config/services/chaching`), gated by **Administer site configuration**.
The public data routes are the JSON/RSS feed at
`/v1/donations/{type}/{period}/{format}/{filter}`, the graph at `/graph/{period}`,
and the API docs at `/docs`.
