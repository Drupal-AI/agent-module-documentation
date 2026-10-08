# Mailer Plus log — manual setup guide

**Mailer Plus log** (`symfony_mailer_log`) records every email your site sends
through the **Symfony Mailer / Mailer Plus** system as a Drupal content entity, so
you can browse, inspect, and audit sent mail from the admin reports section. It is the
answer to "did that password-reset email actually go out, and what exactly did it
say?" — each logged entry captures the mail's type, subject, from/to/cc/bcc/reply-to
addresses, the HTML and plain-text bodies, headers, the theme used, the transport that
delivered it, the associated user account, and any error message if the send failed.

Logging is wired in through Symfony Mailer's own policy system rather than a simple
on/off setting. The module provides an **EmailAdjuster** plugin called "Log email";
you add that element to a Mailer policy — either a specific mail type, or the
catch-all `*All*` policy to log everything — at the Mailer settings page. On top of
that, a master **Enable logging** switch on the module's own settings form lets you
turn all logging off site-wide without touching your policies.

To stop the log growing without bound on a busy site, the settings form also offers
optional **automatic expiry**: set a maximum age (as an ISO 8601 duration such as
`P1W` for one week or `P1M` for one month) after which old entries are deleted on
cron, and cap how many are purged per cron run with a batch size. Logged mail is
listed at **Reports → Mail log**, where you can open any entry to see its full detail.

Three permissions govern viewing, deleting, and administering log entries — and
because entries can contain full email bodies and recipient addresses, "view" should
be treated as sensitive. The module depends on the **Symfony Mailer** module and
supports both Symfony Mailer 1.x and Mailer Plus 2.x automatically.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the log entity's fields and
how to query entries in code — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turning logging on, adding the "Log
   email" adjuster to a Mailer policy, the retention/expiry settings, and the
   permissions.

## Where it lives in the admin menu

Once enabled, logged mail is listed at **Reports → Mail log**
(`/admin/reports/symfony_mailer_log`). The module's own settings live at a tab under
the Mailer settings: **Configuration → System → Mailer → (Mailer Plus log) settings**
(`/admin/config/system/mailer/symfony_mailer_log/settings`). Turning logging on for a
mail type is done on the Mailer **policies** at `/admin/config/system/mailer`. See
[Configuration](configuration/index.md).
