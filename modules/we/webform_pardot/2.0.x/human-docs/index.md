# Webform Pardot — manual setup guide

**Webform Pardot** (`webform_pardot`) connects [Webform](https://www.drupal.org/project/webform)
to **Salesforce Pardot** (Account Engagement). It adds a Webform handler that sends each
submission to a Pardot **Form Handler** endpoint, so leads captured on your Drupal forms flow
straight into your Pardot marketing pipeline. Compared to Webform's generic "remote post", it
adds Pardot-specific niceties: field-name mapping, a queued/cron delivery model, and a
per-submission log you can review in the admin.

Rather than posting inline while the visitor waits, the handler **queues** each submission and
sends it on the next cron run. That keeps form submission fast and means Pardot errors are
captured rather than shown to the visitor. When cron processes the queue, the module remaps
your webform field keys to the Pardot field names you specified and POSTs the data to your
Pardot endpoint over a verified (`verify: true`) HTTPS connection. The response is inspected —
a "field is required" message or a non-success status is recorded as an error — and the outcome
(status code plus a short log) is stored on a `pardot_submission` log entity.

Administrators can review every Pardot submission, its status and its log at
`/admin/structure/webform/pardot_submissions`, which is handy for troubleshooting why a lead
did or didn't reach Pardot. The Pardot endpoint URL is entered by an admin on the handler form
and validated as a URL.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — add and configure the Pardot handler on a
   webform, and where to review submissions.

## Where it lives in the admin menu

There is **no global settings page** — configuration lives on each webform's **Handlers** tab
(**Structure → Webforms → [your webform] → Settings → Emails / Handlers**). The submissions log
is at **Structure → Webforms → Pardot submissions**
(`/admin/structure/webform/pardot_submissions`), gated by the module's **View pardot
submission** permission. Delivery happens on cron, so make sure cron is running.
