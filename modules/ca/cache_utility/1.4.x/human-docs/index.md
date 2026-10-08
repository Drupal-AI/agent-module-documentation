# Cache Utility — manual setup guide

**Cache Utility** (`cache_utility`) exposes cache-clearing operations as HTTP
endpoints so a deployment pipeline can flush caches with a `curl` call instead of
shelling in to run Drush. It covers Drupal's own caches, cache tags, the cache
tables, and — importantly — PHP's **OPcache** and **APCu**.

The problem it solves is a real one on multi-server and containerised sites: `drush
cr` clears Drupal's database caches, but PHP's OPcache and APCu are **per-process**,
so every web node has to be told separately, and a deploy script that can't SSH into
each node has no clean way to do it. Cache Utility gives each operation a URL. There
are around a dozen routes covering clear and status for Drupal caches, cache tables,
cache tags, OPcache and APCu, plus configuration readouts. It also ships Drush
commands, a settings form, and an optional toolbar submodule.

**Understand the authentication model before you deploy it.** The endpoints do *not*
use Drupal's normal permission system — they are open routes that instead require a
shared secret sent in a `CU-ACCESS-KEY` request header, compared against a key stored
in the module's configuration. The default key is empty and empty headers are
rejected, so a freshly installed, unconfigured site is closed rather than open. But
the whole security of these cache-flush and OPcache-reset endpoints rests on that one
stored key, so treat it as a real secret. See [Configuration](configuration/index.md)
for how to set it and the handling cautions that go with it.

The module works on Drupal 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the full route list and the
security analysis — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and optionally the toolbar submodule.
2. [Configuration](configuration/index.md) — set the access key and understand how to
   store it safely.

## Where it lives in the admin menu

The settings form sits at **Configuration → Development → Cache Utility**
(`/admin/config/development/cache_utility`), gated by the **Administer cache utility
configuration** permission. The action endpoints themselves live under
`/admin/cache_utility/` and are called by machines using the access-key header, not
by clicking through the admin.

## How to use it

Enable the module, set an access key on the settings form, then call the endpoints
from your deploy pipeline (or run the Drush commands) to flush Drupal caches, cache
tags, OPcache, and APCu on each node after a release. The form shows example `curl`
and Drush commands you can copy. If you want the operations as clickable toolbar
buttons, enable the `cache_utility_admin_toolbar` submodule.

Two operational notes worth knowing: the endpoints deliberately answer **during
maintenance mode** (that's when a deploy needs them), and clearing OPcache resets it
for the **whole PHP-FPM pool**, not just this site — relevant on shared hosting.
