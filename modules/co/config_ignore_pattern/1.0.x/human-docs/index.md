# Config ignore pattern — manual setup guide

**Config ignore pattern** (`config_ignore_pattern`) keeps configuration objects
whose names match a set of **regular-expression patterns** out of your
configuration export and import, so environment-specific or user-generated config
isn't overwritten or deleted during deployment. The classic use case: webforms
created by editors on a production site. Without this module, a `drush config:import`
during deployment would delete those production webforms because they don't exist in
`config/sync`. With it, they're preserved.

It works quietly through Drupal's config transform events. On **export**, it removes
matching config from the outgoing storage so it never lands in `config/sync`. On
**import**, it writes the current active value back into the incoming storage so the
import treats the item as unchanged — preventing deletion or overwrite. Patterns are
matched against each active config name **and its declared dependencies**, so
anything depending on ignored config is ignored too.

There's an important nuance that keeps the module flexible: config that **already
exists** in your sync/file storage keeps syncing normally, even if its name matches
an ignore pattern. So you can ignore all webforms in general, yet still deliberately
manage one specific webform by placing its config file in `config/sync` (the easiest
way is a *Single item* export from
`/admin/config/development/configuration/single/export`).

The module has **no admin UI, no routes, and no permissions** — it's driven entirely
from `settings.php`. That means the patterns are trusted, code-level settings. It
requires no other modules and supports Drupal 10 and 11.

> **Author patterns carefully.** A too-broad regex can silently drop config you
> actually wanted to export. Anchor your patterns (`^...$`) to match exact names,
> and use the debug flag (below) to confirm what's being ignored before you deploy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — all setup happens in `settings.php`, described
below.

## Where it lives

This module adds no admin page. Its behaviour is controlled by two variables in
`settings.php` and is visible in the debug messages it can emit on the
configuration synchronization screen and during `drush config:export` /
`drush config:import`.

## How to configure it (in settings.php)

Add an array of PCRE regex patterns matched against configuration object names:

```php
/**
 * Ignored config name regex patterns.
 */
$settings['config_ignore_patterns'] = [
  '/^webform\.webform\.[a-z_]+$/',
];
```

With the example above, webforms created via the UI are not exported during
`drush config:export`, and such webforms are not deleted during
`drush config:import`. Any configuration that depends on a matched object is also
ignored.

To see exactly what is being ignored (messages appear on
`/admin/config/development/configuration` and during the Drush commands), turn on
debugging:

```php
/**
 * Config ignore pattern debugging.
 */
$settings['config_ignore_pattern_debug'] = TRUE;
```

To keep managing one specific object whose name matches a pattern, add its config
file to your sync directory — for example via a **Single item** export from
`/admin/config/development/configuration/single/export`. Existing tracked config in
file storage always continues to sync.
