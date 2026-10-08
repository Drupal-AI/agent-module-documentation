# IP Country Logger — manual setup guide

**IP Country Logger** (`ip_country_logger`) records the **country** associated with
the current user's IP address. On each request it resolves the visitor's IP to a
country and logs it, giving you a record of where your visitors are coming from —
useful for analytics or for country‑aware decisions elsewhere on your site.

It's a small, background utility: enable it and it starts logging. Note that the
module's machine name is `ip_country_logger`, but it is shipped by the Drupal
project **`country_trace`** — so the Composer package you install is
`drupal/country_trace` (see [Installation](installation/index.md)).

Because it processes IP addresses — which are personal data — treat the logs it
produces accordingly: retain them only as long as you need, restrict who can view
them, and handle them in line with your site's privacy policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the `country_trace` project
   with Composer and enable the module.

IP Country Logger runs in the background and has **no configuration page** —
enabling it is all that's needed for it to begin logging.

## How to use it

Once enabled, the module logs the country resolved from each user's IP
automatically — there is nothing to switch on per request. Use the collected
country data for analytics or to inform geo‑based logic elsewhere. Since the logs
contain IP‑derived personal data, review your log retention and access controls to
stay aligned with your privacy obligations.
