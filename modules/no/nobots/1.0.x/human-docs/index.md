# No Bots — manual setup guide

**No Bots** (`nobots`) tells well-behaved search engine crawlers to leave your
site alone. When activated, it adds an `X-Robots-Tag: noindex,nofollow,noarchive`
HTTP header to responses, which asks compliant robots not to index, follow, or
archive your pages. It's the module you reach for to keep a staging, QA, or
development environment out of search results.

The key design choice is that enabling the module does **not** switch the header
on by itself — you activate it explicitly, per environment, using Drupal's
**state** system or `settings.php`. That separation is deliberate: it means you
can install the module everywhere but only *activate* it on the environments that
should be hidden, with no risk of a config export accidentally de-indexing
production. There are no routes, permissions, or settings forms.

Two important caveats. First, this only **advises** crawlers — it is a hint that
compliant bots honour, not a hard block, so don't rely on it to keep truly
sensitive content private. Second, take operational care: because it works by an
environment switch, make sure production is never accidentally left activated, or
your live site could drop out of search results.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
You activate it per environment via state or `settings.php`, described in "How to
use it" below.

## How to use it

Enabling the module makes it *available*; you then switch it on where you want
it. Either switch works — any truthy value activates the header.

**Per environment, in `settings.php`** (recommended for staging/dev, since it
lives with that environment's config and can't be exported to production):

```php
$settings['nobots'] = TRUE;
```

**At runtime, via state** (handy for toggling without editing files):

```bash
drush state:set nobots 1
```

To turn it back off, set the state value to `0` (or remove it) and/or delete the
`settings.php` line. Once activated, every response carries
`X-Robots-Tag: noindex,nofollow,noarchive`.
