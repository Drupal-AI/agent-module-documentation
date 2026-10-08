# Cryptolog — manual setup guide

**Cryptolog** (`cryptolog`) is a privacy‑enhancing module that replaces the
client IP address Drupal sees with an **ephemeral, non‑reversible identifier**,
so raw visitor IPs never land in Drupal's logs or database tables. It does this
with an **HTTP middleware** that runs early on every main request: before Drupal
reads the client IP, Cryptolog substitutes a **128‑bit keyed hash** of the real
IP, rendered in IPv6 notation. The hash is keyed by a random 32‑byte salt that is
cached and regenerated every rotation period (24 hours by default), so a given
visitor maps to a stable pseudonym for the salt's lifetime and a fresh one after
rotation.

This design keeps the parts you want. Because the pseudonym is stable within a
rotation window, statistics such as unique‑IP counts per day still work, and
Drupal's IP‑based **flood control** (login throttling and similar abuse
protection) keeps functioning. Hashing uses the **Sodium** PHP extension's
generic‑hash when it is available, falling back to HMAC‑MD5 otherwise. This is a
**positive privacy control** aimed at GDPR/CCPA data minimization.

There is a trade‑off worth understanding: because the real IP is replaced so
early, any feature that genuinely needs the true client IP — precise geolocation,
IP allow‑lists, forensic investigation — will only ever see the pseudonym. Tune
the salt's rotation period (TTL) to balance privacy against how much short‑term
correlation you need.

This branch (2.3.x, version 2.3.0) targets **Drupal 11.2+ and 12** and requires
PHP compiled with IPv6 support; an in‑memory cache such as APCu, Memcache, or
Redis is recommended. It has no module dependencies and no custom permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form: salt storage,
   rotation TTL, regenerating the salt, and reverse‑proxy diagnostics.

## Where it lives in the admin menu

Once enabled, Cryptolog begins pseudonymizing IPs immediately. Its settings form
sits at **Configuration → People → Cryptolog**
(`/admin/config/people/cryptolog`, config route `cryptolog.settings`), and it
requires the **Administer site configuration** permission. See
[Configuration](configuration/index.md) for a field‑by‑field walkthrough.
