# File Cache — manual setup guide

**File Cache** (`filecache`) is a cache backend that stores Drupal's cache bins as
files on disk (or on a RAM disk) instead of in the database. It's a way to take
the pressure of big, busy cache bins — like `render`, `page`, or `entity` — off
your database without adding a Redis or Memcached dependency.

Enabling the module simply registers a new cache backend service,
`cache.backend.file_system`. Nothing changes until you tell Drupal to *use* it,
which you do entirely in **`settings.php`** — there is no admin UI, no
permissions, and no Drush commands. You point one or more cache bins at the
backend and tell it which directory to write to; File Cache creates a subdirectory
per bin automatically.

Two things are worth understanding up front. First, the storage directory **must**
live outside your web root and be owner-only (`chmod 700`) — cache files can
contain sensitive rendered data, so they must never be web-accessible. Second,
File Cache offers two strategies per bin: the default **standard** strategy clears
files on a normal cache rebuild (`drush cr`), while the **persist** strategy keeps
them across rebuilds — handy for expensive data fetched from slow external
services, at the cost of not fully following the cache API.

This guide is written for a **human** editing configuration files. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the `settings.php` keys: choosing
   bins, storage directories, strategy, and the optional compressing serializer.

## Where it lives in the admin menu

Nowhere — File Cache has **no admin page**. All configuration is in `settings.php`
/ `settings.local.php`. The only place it surfaces in the UI is the **Status
report** (`/admin/reports/status`), which shows File Cache self-checks.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. In `settings.php`, point the cache bins you want at
   `cache.backend.file_system` and set a storage directory (outside the web root,
   `chmod 700`). See [Configuration](configuration/index.md).
3. Rebuild caches (run the CLI as the **web-server user** so file ownership stays
   correct) and check the Status report.
