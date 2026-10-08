# jQuery 4 Migrate — manual setup guide

**jQuery 4 Migrate** (`jquery_4_migrate`) restores the old jQuery functions that
were removed in jQuery 4. Starting with Drupal 11, core bundles jQuery 4 instead
of jQuery 3, and jQuery 4 finally deleted several long‑deprecated helpers — like
`jQuery.isFunction()` and `jQuery.type()` — that plenty of older third‑party
plugins (carousels, lightboxes, countdown timers, and similar widgets) still
call. The moment a site moves to Drupal 11, those plugins can throw JavaScript
errors and stop working, with no warning during the upgrade itself.

This module packages **jQuery Migrate 4.x**, a small compatibility script from
the jQuery Foundation, as a standard Drupal library
(`jquery_4_migrate/jquery-migrate`). jQuery Migrate re‑adds the removed functions
as thin wrappers, so old plugin code keeps working exactly as before — without you
having to find, patch, or replace each plugin by hand. Think of it as a practical
stopgap that buys you time to update those plugins properly later.

You can use it in one of two ways. Either add
`jquery_4_migrate/jquery-migrate` as a dependency to just the specific library
that needs it, or flip on the module's single sitewide toggle to load jQuery
Migrate automatically wherever core jQuery loads. That sitewide toggle is gated
behind its own permission, so only trusted roles can turn on something that
affects every page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, place the
   jQuery Migrate library file, and enable the module.
2. [Configuration](configuration/index.md) — the settings form and its single
   sitewide toggle.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → jQuery 4
Migrate Settings** (`/admin/config/system/jquery-4-migrate-settings`). Reaching
it requires the **Administer jQuery 4 Migrate** permission.

> **Note:** This module only matters on Drupal 11, where jQuery 4 is bundled. It
> has no effect on earlier core versions still running jQuery 3.x. It also won't
> cover APIs removed in some future jQuery 5 — treat it as a bridge, not a
> permanent home.
