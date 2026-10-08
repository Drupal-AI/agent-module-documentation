# Sparkpost — manual setup guide

**Sparkpost** (`sparkpost`) sends your site's outgoing mail through
[SparkPost](https://www.sparkpost.com), a transactional email delivery service,
instead of the local PHP `mail()` function.

This matters more than it sounds. Mail sent by `mail()` from a web server largely
does not arrive: it fails SPF and DKIM checks, the sending IP has no reputation,
and the messages that matter most — password resets, order confirmations, account
activations — are exactly the ones silently filed as spam. A transactional
provider like SparkPost owns the delivery infrastructure, authenticates your
domain properly, and, crucially, **reports what happened to each message**, which
turns "the email did not arrive" from a guess into a fact. SparkPost is one of the
established providers alongside SendGrid, Mailgun and Postmark. The module
provides the Drupal integration, including a settings form and a **test-send
form** so you can confirm delivery from the admin UI.

Two things are worth getting right. First, **the API key is a live credential** —
it can send mail as your domain and read your delivery data — so store it in an
environment variable and reference it through a Key entity, never in exported
configuration, and scope it to sending rather than issuing an account-wide key.
Second, **plan for delivery failure**: if the provider becomes unreachable or the
key is rotated without updating the site, Drupal's mail simply stops, usually
unnoticed until a user reports a missing reset — so monitor SparkPost's bounce and
rejection reporting rather than assuming silence means success.

> **This release is an alpha** (3.0.0-alpha2). For a component that carries every
> password reset on the site, weigh that maturity carefully before relying on it
> in production.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — entering your SparkPost API key,
   routing Drupal's mail through it, and sending a test message.

## Where it lives in the admin menu

Once enabled, the settings and test-send form sit at **Configuration → Web
services → Sparkpost** (`/admin/config/services/sparkpost`), served by the
`sparkpost.settings_form` route and gated by the **Administer Sparkpost**
permission.
