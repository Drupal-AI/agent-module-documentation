# EVA - Email Validator — manual setup guide

**EVA - Email Validator** (`email_validator`) — this is the **3.0.x** release —
validates email addresses for deliverability by calling the external **e‑va.io**
service over HTTPS, and rejects addresses whose reported state you have not chosen
to allow. It is aimed at keeping fake and disposable accounts off your platform.

Compared with the older 1.0.x line, this version is considerably more capable. It
**replaces Drupal core's `email.validator` service** with its own `EVA` class (so
validation can run anywhere core validates an address) and it also adds a
validator to the specific forms you list. On its settings form you paste the
e‑va.io **Access Key**, list which forms and fields to validate (one
`form_id:field` per line), choose which deliverability **states** count as
acceptable, and set logging plus a **fail‑open / fail‑closed** policy for when the
service is down or out of credits. Validation results are cached for an hour per
address to cut down on API calls. This release requires the `guzzlehttp/guzzle`
HTTP library.

Two things are worth understanding. First, EVA **sends the submitted email
addresses to the third‑party e‑va.io service** — a data‑egress and privacy
consideration you should confirm is acceptable and disclose to your users where
required. Second, it authenticates with an **Access Key** sent in an `api-key`
request header; the key is stored in module configuration as plain text, so treat
any exported configuration as sensitive and keep the key out of public
repositories.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings in
   Guzzle) and enable the module.
2. [Configuration](configuration/index.md) — enter your Access Key, target forms,
   allowed states, logging and the fail policy.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → EVA - Email
Validator** (`/admin/config/system/email-validator`). Access is gated by the
**Administer EVA API settings** permission.
