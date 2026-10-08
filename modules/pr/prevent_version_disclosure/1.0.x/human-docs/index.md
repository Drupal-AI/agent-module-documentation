# Prevent Version Disclosure — manual setup guide

**Prevent Version Disclosure** (`prevent_version_disclosure`) is a small security
hardening module. When Drupal outputs a JavaScript file it normally appends a
version query string to the URL — for example `jquery.min.js?v=3.7.1` — and that
version number is visible in your page source. An attacker or automated scanner
can read those numbers to fingerprint exactly which library and core versions you
run, and whether a known‑vulnerable version has been patched. This module
replaces each readable version with an opaque, site‑specific hash, so
`jquery.min.js?v=3.7.1` becomes something like `jquery.min.js?v=d5t4a2hC`.

The hash is deterministic for your site (it uses a random 128‑byte salt generated
once and stored in Drupal's State), which means cache‑busting still works — the
query string still changes whenever a library's real version changes — but the
underlying version number is no longer exposed. It also can't be guessed or
matched against other sites, because every site has its own salt. This matters
most on pages where Drupal's JavaScript aggregation is off, such as `install.php`
and `update.php`, where raw `?v=` version strings would otherwise be plainly
visible.

There is **nothing to configure** — enable the module and it works immediately.
It requires the `league/commonmark` PHP library (used only to render its own help
text) and has no other module dependencies, no settings form, no permissions, and
no Drush commands.

This is deliberately a "defense in depth" / anti‑fingerprinting measure — the
maintainer describes it as minor security‑by‑obscurity, not a fix for any single
vulnerability.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no settings page and no menu item. Once enabled the module
works silently in the background, rewriting JavaScript version strings on every
page.

## How to use it

Just enable it (see [Installation](installation/index.md)). A few things worth
knowing:

- **Scope.** It rewrites **JavaScript** asset versions only. It does *not* hide
  CSS `?v=` versions, the `<meta name="Generator">` tag, the `X-Generator` HTTP
  header, or version strings baked inside library code. To cover those, pair it
  with modules such as *Remove Generator Meta Tags* and *Remove HTTP Headers*
  (both referenced in this module's README).
- **Rotating the hashes.** The obscured hashes are derived from a stored salt
  (State key `prevent_version_disclosure_salt`). Deleting that state value
  regenerates the salt and rotates every hash site‑wide.
- **Development environments.** If you want readable version strings while
  developing, simply do not enable the module there.
