# OAuth refresh token validity extension — manual setup guide

**OAuth refresh token validity extension** (`refresh_token_validity_extension`)
solves one specific, quietly painful problem: **Azure OAuth2 refresh tokens
expire after 90 days of non-use**, and when they lapse, OAuth2-authenticated SMTP
mail sending (through PHPMailer OAuth2) silently stops working. This module keeps
that refresh token alive by exercising it on a schedule, so your Microsoft 365 /
Outlook mail keeps flowing without anyone having to rotate the token by hand.

It registers a single **Ultimate Cron** job that runs at noon on the 1st of every
month. Each run exchanges the stored refresh token for a fresh access token using
PHPMailer OAuth2's Azure provider, then writes the newly issued refresh token back
into the PHPMailer OAuth2 settings. Because that happens monthly — well inside
Azure's 90-day window — the refresh token never gets a chance to lapse.

There is no settings page, no route and no permission: the module is purely a
scheduled cron callback. On success it logs an informational message (the token
value itself is **not** logged) and shows a status message; on failure it logs the
exception and shows an error.

**A security trade-off worth understanding.** Keeping a long-lived refresh token
perpetually valid is a deliberate convenience-vs-exposure choice. A refresh token
that never expires is a credential that stays useful to anyone who obtains it for
as long as the integration exists — a larger exposure window than a token that
naturally lapses. That is an acceptable trade for unattended SMTP, but it means
the stored refresh token (and access to the PHPMailer OAuth2 settings and the site
logs) should be protected accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm its dependencies.

There is **no configuration page** for this module — it has no settings form. It
piggybacks on the existing PHPMailer OAuth2 and Ultimate Cron configuration, as
described below.

## Where it lives in the admin menu

This module adds no configuration page of its own. Its work is done by an Ultimate
Cron job. You can see and manually trigger that job in the **Ultimate Cron** jobs
list under **Configuration → System → Cron** — look for the *OAuth Refresh Token
Validity Extension* job.

## How to use it

1. Make sure **PHPMailer OAuth2** is fully configured with a working Azure app
   registration and an initial, valid refresh token, and that OAuth2 SMTP mail is
   actually working. This module extends that setup — it does not create it.
2. Make sure **Ultimate Cron** is installed and running (it is what schedules the
   monthly job).
3. Enable this module. The monthly job is registered automatically and runs at
   noon on the 1st of each month.
4. To run it on demand — for example to confirm it works right after install — go
   to the Ultimate Cron jobs list and run the *OAuth Refresh Token Validity
   Extension* job manually. Check the **Azure SMTP OAuth** logger channel to
   confirm the rotation succeeded.

If you want a different cadence than monthly, adjust the shipped Ultimate Cron job
configuration — but keep it comfortably inside Azure's 90-day window.
