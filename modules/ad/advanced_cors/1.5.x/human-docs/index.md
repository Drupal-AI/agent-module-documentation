# Advanced CORS — manual setup guide

**Advanced CORS** (`advanced_cors`) lets you set CORS (Cross‑Origin Resource
Sharing) response headers on a **per‑path‑pattern** basis. Drupal core can only
apply one global CORS policy for the whole site (edited in `services.yml`);
Advanced CORS lets you define several named policies as config entities and target
each at specific URL patterns — so, for example, `/api/*` can allow a particular
front‑end origin while the rest of the site sends no CORS headers at all.

Each policy holds a list of path patterns, a weight, and the CORS values
(allowed origins, methods, headers, exposed headers, max‑age, and whether
credentials are supported). On every response the module resolves the current
request path (following URL aliases) and applies the **first** enabled policy
whose pattern matches, ordered by weight. Only one policy applies per request.

For the `Access-Control-Allow-Origin` header the module is deliberately careful:
it echoes back the request's `Origin` **only** if that origin is in the policy's
allowed list; otherwise it returns the first configured origin (a mismatch the
browser will reject). It never reflects an arbitrary, unlisted origin.

> **Security matters here.** CORS headers control which other websites' JavaScript
> may read responses from your site. A wrong configuration can expose data across
> origins. In particular, never combine `allowed_origins: *` with
> `supports_credentials: true` — see the [configuration guide](configuration/index.md)
> for the safe way to set this up.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — creating CORS policies, every field,
   how patterns match, and the security caveats.

## Where it lives in the admin menu

Once enabled, manage your CORS policies at **Configuration → Web services → CORS
Settings** (`/admin/config/services/advanced_cors`). Only users with the core
**Administer site configuration** permission can add, edit, or delete policies.

## How to use it

Go to the CORS Settings page, add one or more policies, and give each a set of
path patterns and CORS header values. Order overlapping policies with the
**weight** field so the most specific one is matched first. After changing
policies, rebuild caches (`drush cr`) so the new pattern list is picked up. The
[configuration guide](configuration/index.md) walks through every field.
