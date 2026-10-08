# Cloudflare — manual setup guide

**Cloudflare** (`cloudflare`) integrates a Drupal site with the Cloudflare CDN. It
handles two jobs out of the box: it authenticates against the Cloudflare API using
your account credentials, and it **restores each visitor's real IP address** —
which the Cloudflare proxy would otherwise hide behind one of its own edge IPs. A
bundled submodule, **Cloudflare Purger**, adds the ability to clear the Cloudflare
cache by tag, by URL, or for the whole zone.

The IP-restoration piece matters more than it sounds. Because Cloudflare sits in
front of your site, everything Drupal sees — flood control, rate limiting,
analytics, security logging, geolocation, Views that show a visitor IP — would
otherwise record Cloudflare's address instead of the real visitor's. This module's
HTTP middleware reads Cloudflare's `CF-Connecting-IP` header and rewrites the
request so the rest of Drupal sees the true origin, optionally verifying first that
the request really came from a Cloudflare edge IP.

Configuration lives in a small admin wizard. You connect your account with either
a scoped **API token** (recommended) or the legacy **API key + email**, choose the
zone(s) your site uses, and toggle client-IP restoration. Note that actual cache
purging is **not** in this base module — it ships in the separate Cloudflare Purger
submodule, which builds on the Purge module.

> **Keep credentials out of code.** Cloudflare API tokens and keys are secrets.
> Store them in an environment variable or a Key entity rather than committing them
> to configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires
   CTools), enable the module, and optionally the purger submodule.
2. [Configuration](configuration/index.md) — the settings wizard: authentication,
   zones, client-IP restoration, and the permission that gates it.

## Where it lives in the admin menu

The settings wizard is at **Configuration → Web Services → Cloudflare**
(`/admin/config/services/cloudflare`). If you enable the purger submodule, its
settings sit just below at `/admin/config/services/cloudflare/purger`. Both are
gated by the single **Administer Cloudflare** permission.

## How to use it

1. Create an API token in your Cloudflare dashboard scoped to the zone(s) you want
   Drupal to manage, and store it in an environment variable (or a Key entity).
2. Open **Configuration → Web Services → Cloudflare** and step through the wizard —
   choose token authentication, provide the credential, and select your zone(s).
3. Turn on **client IP restoration** so Drupal logs and sees real visitor IPs.
4. If you want CDN cache clearing, enable the **Cloudflare Purger** submodule and
   configure it through the Purge module (see [Installation](installation/index.md)).
