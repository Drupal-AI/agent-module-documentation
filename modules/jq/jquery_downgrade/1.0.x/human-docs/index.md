# jQuery Downgrade — manual setup guide

**jQuery Downgrade** (`jquery_downgrade`) is a compatibility helper for Drupal 11,
which ships jQuery 4. Some older JavaScript — a legacy contrib module, a third-party
plugin, a Views-provided script, an old datepicker or carousel — was written for
jQuery 3 and breaks under jQuery 4. Rather than downgrading your whole site, this
module lets you selectively serve jQuery 3 only on the specific pages that need it.

You tell it *where* to downgrade in three ways: by **node** (list the node IDs), by
**Views page** (tick the Views displays whose JS assumes jQuery 3), or by **theme**
(switch on theme-based downgrade and pick the themes that should use jQuery 3). On any
matching request, the module removes core's jQuery 4 from the page and instead loads
jQuery 3.6.4 from a CDN. Everywhere else, jQuery 4 stays in place.

This makes it a practical bridge while you migrate: whitelist only the pages you have
not yet made jQuery-4-compatible, then remove them from the list one by one as each is
verified — no core patches, no theme hacks. It is a small, focused module: one
settings form, one config object, one runtime hook, and one library definition. It
adds no permissions of its own (it reuses the core "administer site configuration"
permission) and no Drush commands.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the exact config keys and the attachment-altering hook —
read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   choosing which nodes, Views pages, and themes get jQuery 3.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Development → jQuery Downgrade**
(`/admin/config/development/jquery-downgrade`), gated by the core **Administer site
configuration** permission.
