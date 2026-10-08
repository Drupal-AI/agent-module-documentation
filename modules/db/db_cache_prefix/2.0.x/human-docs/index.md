# Database cache prefix — manual setup guide

**Database cache prefix** (`db_cache_prefix`) prepends a configurable string to
every cache ID written to Drupal's database cache backend, so that several
installations sharing one cache store cannot collide.

The need arises whenever more than one Drupal instance reads and writes the same
cache table: shared hosting where one database serves multiple sites, a multi-site
arrangement with a common cache table, a **blue-green deployment** where two
versions run against the same infrastructure, or a set of environments pointed at
one backend for convenience. Without a prefix, a cache ID like `config:system.site`
means different things in each instance, and whichever writes last wins — which
produces the confusing class of bug where a setting changed on one site appears on
another, or a fresh deployment serves the previous release's rendered output. A
prefix scopes the keys so the collision cannot happen.

Three things are worth understanding before you rely on it:

1. **Changing the prefix invalidates everything.** That is the intended behaviour
   when a new deployment wants a clean cache — but it is a cold start on a busy
   site, so treat a prefix change as a *deployment event*, not a casual
   configuration tweak.
2. **A prefix is not isolation in the security sense.** Entries still live in the
   same table and are readable by anything with database access. It prevents
   *accidental collision*, not deliberate reading. Where the requirement is
   confidentiality between tenants, use genuinely separate cache stores.
3. **Core may already cover this.** Drupal core offers `$settings['cache_prefix']`
   for the database backend in some arrangements. The first question is whether
   your site needs this module at all, or whether the core setting already covers
   it — which depends on the cache backend in use.

This is a release candidate at the documented version (**2.0.0-rc3**), so test it
in a staging environment before production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and set the prefix in `settings.php`.

There is **no configuration page** for this module. The prefix is set in
`settings.php`, described on the Installation page.

## Where it lives in the admin menu

The module adds no admin page. Its only setting is a line in `settings.php`
(`$settings['db_cache_prefix']`), and changing it takes effect on the next request
— invalidating the existing cache. See [Installation](installation/index.md).
