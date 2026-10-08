# Configuration

APE ships no default configuration — its settings only exist once you save the
form. This page walks through the form and explains how each lifetime is applied.

## Open the settings form

1. Log in as a user with the **Administer APE** permission.
2. Go to **Configuration → Development → Performance → APE**, or navigate directly
   to `/admin/config/development/performance/ape`.

This single form edits two things: core's global default (`system.performance`'s
page cache maximum age) and everything else APE adds (`ape.settings`). Because of
that, APE hides the max-age selector on the core Performance form and sends you
here instead.

## How APE decides the lifetime

For each cacheable page response, APE works out a `max-age` like this:

1. It starts from the **global default** (core's page cache maximum age).
2. If the path matches your **alternative** list, it uses the **alternative
   lifetime** instead.
3. **Response-code overrides win over the above:** a 301, 302, or 404 uses its own
   lifetime, and a 403 is always forced to `max-age=0`.
4. Pages on the **exclusion** list are never cached at all.

## The settings, field by field

### Global default (page cache maximum age)

The baseline lifetime for every page that doesn't match a more specific rule. This
is core's own `cache.page.max_age` value — APE just edits it here rather than on
the core Performance page.

### Alternative paths

A list of paths (one per line) that should use the alternative lifetime instead of
the default. It uses Drupal core's standard path-matching syntax: a leading slash,
one path per line, and `*` as a wildcard. For example:

```
/
/news
/news/*
```

Here the homepage (`/`) and everything under `/news` get the alternative lifetime.

### Alternative lifetime

The `max-age`, in **seconds**, applied to the alternative paths above. For example
`300` for five minutes.

### 301 lifetime

The `max-age` (seconds) for **301 Moved Permanently** redirects. Since these are
permanent, a long value lets a CDN cache them aggressively.

### 302 lifetime

The `max-age` (seconds) for **302 Found** (temporary) redirects — usually a shorter
value than 301.

### 404 lifetime

The `max-age` (seconds) for **404 Not Found** responses. Caching these briefly can
cut backend load from bad or bot-generated URLs.

> **403 responses** are always sent with `max-age=0` and can't be configured —
> Access Denied pages are never cached.

### Excluded paths

A list of paths (same syntax as the alternative list) that should **never** be
page-cached. Use it for dynamic or sensitive pages such as `/cart` or `/user/*`.
These pages are denied caching entirely and are served with
`no-cache, must-revalidate`.

## Save

Click **Save configuration**. Changes apply to subsequent responses. Since these
values are stored in `ape.settings` (plus the core `system.performance` default),
you can export them with your configuration and deploy the same cache policy
across environments.

## For developers

- `ape_cache_set($age)` — call early in a request to force a base max-age (this is
  how the Rules integration injects a value).
- `hook_ape_cache_alter(&$max_age, $original_max_age)` — adjust the final computed
  value in code for logic configuration can't express.

See the [`agent/`](../agent/start.md) docs for both.
