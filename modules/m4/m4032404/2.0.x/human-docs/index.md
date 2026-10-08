# 403 to 404 — manual setup guide

**403 to 404** (`m4032404`) converts Drupal's "403 Access Denied" responses into
"404 Not Found". The effect is that a protected page looks like it simply doesn't
exist, rather than existing but being forbidden — which hides its existence from
anonymous visitors, crawlers and anyone probing URLs. It's a common, one-line
hardening step: it stops an attacker from telling "exists but you can't see it"
apart from "not here" while enumerating URLs.

The module is intentionally tiny — a single event subscriber that catches the
access-denied exception and swaps it for a not-found one. A short settings form
lets you scope the behaviour: apply it everywhere (the default), limit it to admin
routes only, or target a specific list of paths — and you can flip that list
between "redirect these paths" and "redirect everything except these paths". CSRF
confirmation routes are left alone so token-based flows keep working.

Two permissions come with it. **Access 403 page** is a per-user escape hatch: users
who have it keep seeing the real 403 (handy for editors and debugging), while
everyone else gets the 404. **Administer 403 to 404 settings** gates the settings
form. Saving the form rebuilds the router, so changes take effect immediately. The
module has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant permissions.
2. [Configuration](configuration/index.md) — scope the behaviour by admin routes
   or paths, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → System → 403 to 404**
(`/admin/config/system/m4032404`), reached with the **Administer 403 to 404
settings** permission. Both permissions are granted at **People → Permissions**.
