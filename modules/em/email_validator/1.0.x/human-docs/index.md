# Email Validator (EVA) — manual setup guide

**Email Validator (EVA)** (`email_validator`) — this is the **1.0.x** release —
checks the deliverability of email addresses against the external **e‑va.io**
service, so your forms can reject fake or disposable addresses before an account
is created. It follows a simple three‑step setup: install the module, create an
account at e‑va.io and generate an API key, then configure the module with that
key.

Once configured, EVA validates addresses as part of form submission, reducing the
number of undeliverable or throwaway signups your site accepts. It provides its
own permission for managing the integration.

Two things are worth understanding. First, EVA **sends the submitted email
addresses to a third‑party service** (e‑va.io) to check them — a data‑egress and
privacy consideration you should confirm is acceptable for your site and disclose
to your users where required. Second, it authenticates to that service with an
**API key**; treat the key as a secret and make sure the calls travel over HTTPS.

> **Newer release available.** A later **3.0.x** major version of this same
> project exists with a considerably richer configuration form (choosing exactly
> which forms and fields to validate, which deliverability states to allow, a
> fail‑open/fail‑closed policy, logging, and result caching). If you are starting
> fresh, look at the 3.0.x guide as well. This page documents the 1.0.x line.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — get an e‑va.io API key and enter it
   in the module's settings.

## Where it lives in the admin menu

After enabling the module, open its settings form under **Configuration** and
paste in the API key you generated at e‑va.io. See
[Configuration](configuration/index.md) for the details.
