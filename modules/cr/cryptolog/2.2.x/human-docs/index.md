# Cryptolog — manual setup guide

**Cryptolog** (`cryptolog`) is a privacy‑enhancing module that replaces the
client IP address Drupal sees with an **ephemeral, non‑reversible identifier**.
Instead of a visitor's real IP being written into Drupal's logs and database
tables, Drupal records a rotating pseudonym — a keyed hash of the IP that changes
on a schedule. This reduces the personal‑data footprint of your site (IP
addresses are personal data under GDPR, CCPA/CPRA and similar regulations) while
keeping enough consistency to be useful in the short term.

The clever part is the *ephemeral* nature of the identifier. The same visitor
maps to the same pseudonym for the salt's lifetime (24 hours by default), so you
can still do useful statistics such as counting unique visitors per day, and
Drupal's IP‑based **flood control** (which throttles repeated failed logins and
similar abuse) keeps working. Once the salt rotates, the mapping resets and old
pseudonyms can no longer be tied back to an IP.

This is a **positive privacy control** with an important trade‑off: because the
real IP is replaced early in the request, any feature that genuinely needs the
true client IP — precise geolocation, IP allow‑lists, forensic investigation —
will only see the pseudonym. Decide whether that is acceptable for your site
before enabling it, and tune the rotation to match your needs. Cryptolog has no
special requirements, though an in‑memory cache (APCu, Memcache, or Redis) is
recommended, and the Sodium PHP extension is used for hashing when available.
This branch (2.2.x) supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, where you control
   how the salt is stored and how often the identifier rotates.

## Where it lives in the admin menu

Once enabled, Cryptolog begins pseudonymizing IPs immediately. Its settings form
is provided at the **Cryptolog settings** page (config route
`cryptolog.settings`), reachable under **Configuration → People**. See
[Configuration](configuration/index.md) for the details.
