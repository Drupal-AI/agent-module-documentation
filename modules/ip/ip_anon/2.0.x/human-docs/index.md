# IP Anonymize — manual setup guide

**IP Anonymize** (`ip_anon`) enforces an IP-address **retention policy** on your
site. On each cron run it looks through the tables that store visitors' client IP
addresses and scrubs any that are older than a retention period you choose,
overwriting the stored IP so the original is no longer recoverable. It's a
practical privacy tool — a common building block for GDPR-style data-minimization,
where you keep IPs only as long as you genuinely need them.

You control it with two kinds of setting: a master **policy** switch that turns
scrubbing on or off site-wide, and a **retention period per table** that says how
long IPs may live in each place before they're anonymized. Different data sources
can have different windows — for example, keep session IPs for just an hour but
retain log IPs a little longer for spam investigation, or keep some "forever" while
aggressively scrubbing others.

Out of the box it covers Drupal's core `sessions` table, and it automatically
adds more tables when the relevant modules are present — comment, Database Logging
(watchdog), Commerce orders, Login History, Simple Access Log, Tether Stats,
Visitors, Voting API, and Webform. Other modules (or your own) can register
additional tables through a hook. Two Drush commands let you scrub on demand and
review the current policy.

One honest caveat, straight from the module's README: IP Anonymize cannot
guarantee true anonymity. IPs are still stored at least briefly (until the next
scrub) and may be logged elsewhere on your stack. For stronger guarantees the
README points to the Cryptolog module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the retention-policy form, field by
   field, plus the Drush commands.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → People → IP address
anonymization** (`/admin/config/people/ip_anon`). Scrubbing runs automatically on
cron once you switch the policy on.
