# Custom Admin URL — manual setup guide

**Custom Admin URL** (`custom_admin_url`) restricts Drupal's admin and user routes
to a designated **back‑office host/URL**. When those pages are reached through the
"wrong" (front‑office) host, it returns a **403**, so administration is only
reachable through the host you nominate. It does this with a real access check, not
by merely hiding links.

The typical setup is a site served on two hostnames — a public front‑office host
and a separate back‑office host — where you want `/admin/*` and `/user/*` to work
only on the back‑office one. This is an **access‑hardening** layer.

Two things are important to understand before relying on it. First, this is
**defense‑in‑depth that complements — never replaces — Drupal's role and permission
checks.** Don't make it your only protection for admin routes; keep permissions
correct regardless. Second, its correctness depends on **trusted host
resolution**: configure Drupal's `trusted_host_patterns` so the host it keys on
can't be spoofed via the `Host` header, and make sure the front‑office host
genuinely cannot serve admin routes. (Restricting the admin path this way is a form
of security‑by‑obscurity — helpful as one layer, but not real protection on its
own.)

The module has no dependencies and works on Drupal 10 and 11. You must set the
back‑office URL after installing — see [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the back‑office URL and the host
   settings it relies on.

## Where it lives in the admin menu

Its settings form is at **Configuration → System → Custom Admin URL**
(`/admin/config/system/custom-admin-url`), where you set the back‑office URL — see
[Configuration](configuration/index.md).
