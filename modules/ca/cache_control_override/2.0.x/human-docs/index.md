# Cache Control Override — manual setup guide

**Cache Control Override** (`cache_control_override`) makes Drupal's
`Cache-Control: max-age` HTTP header tell the truth. Out of the box, Drupal sends
every cacheable page the same site‑wide "Browser and proxy cache maximum age"
value, even when the page itself contains content that should only be cached for a
few seconds. This module instead reads the **cacheability that actually bubbled up**
while the page was built and writes *that* real max‑age into the header — so a page
whose content says "cache me for 300 seconds" is advertised to browsers, CDNs and
reverse proxies (Varnish, Fastly, …) as exactly 300 seconds.

It also does one more thing: when a page's bubbled max‑age is `0` (meaning
"genuinely uncacheable"), it keeps that response out of Drupal's own Internal Page
Cache, so a personalised or time‑sensitive page is not accidentally stored and
served stale.

The module is small and code‑only: it has no admin form, no permissions, no plugins
and no menu items — just two services working quietly on every response. Its one
piece of configuration is an optional pair of **clamps**: a floor (`max_age.minimum`)
that stops any page advertising a max‑age below a value you choose, and a ceiling
(`max_age.maximum`) that stops any page advertising more than you allow. By default
both clamps are off, so out of the box the module simply *propagates* the real
max‑age without changing its size. It requires PHP 8.1+ and Drupal 10.2+.

This guide is written for a **human** installing and tuning the module. If you want
the terse, token‑cheap reference for an AI coding agent — the exact override
algorithm, the conditions that skip it, and how to extend the behaviour — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the optional floor/ceiling settings,
   how to set them (there is no admin form — you use Drush or config), and how to
   verify the header.

## Where it lives in the admin menu

Nowhere — Cache Control Override has **no admin page and no settings form**. Its
behaviour is automatic once enabled, and its two optional settings are edited via
Drush or a configuration file (see [Configuration](configuration/index.md)).

## How to use it

For most sites, simply enabling the module is the whole job: max‑age headers start
reflecting real page cacheability immediately. One thing to know — the module never
*raises* a response above what core produced, so core's page cache max‑age
(*Configuration → Development → Performance* → **Browser and proxy cache maximum
age**, i.e. `system.performance:cache.page.max_age`) must be non‑zero for any
`max-age` directive to exist in the first place. If that is set to `<no caching>`,
this module has nothing to act on.

Beyond that, you only touch the optional **floor** and **ceiling** clamps if you
want to guarantee, for example, that no page is ever cached at the edge for less
than 5 minutes or more than 1 hour. Those are covered in
[Configuration](configuration/index.md).
