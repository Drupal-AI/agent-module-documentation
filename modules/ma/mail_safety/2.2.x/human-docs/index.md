# Mail Safety — manual setup guide

**Mail Safety** (`mail_safety`) is a development and staging safety net: it intercepts
every outgoing email on your Drupal site and, when enabled, stops it from actually being
delivered. Instead of reaching real recipients, each mail can be captured to an in‑site
**dashboard** where you can read, preview, resend, or delete it, and/or **rerouted** to a
single safe address. That means you can exercise all your mail‑sending code — password
resets, registration emails, order notifications — on a copy of production without any risk
of spamming real users.

It's deliberately simple. When Mail Safety's master switch is on, it sets every message's
"send" flag to false so nothing leaves the server, then two independent options decide what
happens next: **send to dashboard** stores a copy of the message in a database table you can
browse, and **send to default address** rewrites the recipient to one configured address
(stripping Cc/Bcc) and lets that single copy send. You can use either, both, or neither —
though with the master switch on and both destinations off, mail is simply dropped.

From the dashboard you can render each caught mail (using the site's configured mail theme),
inspect its full details and parameters, resend it to its **original** recipients, resend it
to the **default** address, or delete it — plus a "Clear" action to empty the table. A log
retention setting purges old captured mail on cron so the table doesn't grow forever. Two
permissions separate "change the settings" from "use the dashboard", so you can give QA
testers dashboard access without letting them alter mail configuration. Other modules can
hook in for things like attachment handling.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form field by field, the
   dashboard, retention, and permissions.

## Where it lives in the admin menu

- **Dashboard** — **Configuration → Development → Mail Safety**
  (`/admin/config/development/mail_safety`): the list of caught emails, with view/resend/
  delete actions.
- **Settings** — the same section, at `/admin/config/development/mail_safety/settings`.

> **Only turn this on where you want mail stopped** — typically development, staging, or QA
> environments. On production it would prevent real emails from reaching your users.
