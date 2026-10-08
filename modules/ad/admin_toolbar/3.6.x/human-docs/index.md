# Admin Toolbar — manual setup guide

**Admin Toolbar** (`admin_toolbar`) turns Drupal's core Toolbar into a fast,
fully expandable drop‑down administration menu. Instead of clicking a top‑level
item and waiting for a page to load before you can drill deeper, you hover and
the entire admin menu tree fans out as nested fly‑out menus — so any settings
page is one motion away. It adds no menu items of its own; it simply renders the
existing admin menu (plus anything other modules add to it) as drop‑downs, and it
depends only on core's Toolbar module.

The module works the moment you enable it — there is nothing you *must* configure.
An optional settings form lets you tune how the toolbar behaves (sticky
positioning, a keyboard toggle, hoverIntent timing, menu depth). Three optional
submodules extend it: **Extra Tools** (`admin_toolbar_tools`) adds one‑click
action links such as *Flush all caches* and *Run cron* under the Drupal icon,
**Search** (`admin_toolbar_search`) adds a type‑to‑filter box for admin links,
and **Links Access Filter** (`admin_toolbar_links_access_filter`, deprecated on
Drupal 10.3+) hides links a user cannot reach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Admin Toolbar settings page under Configuration → User interface](images/settings.png)

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the optional settings form, field by
   field, for tuning how the toolbar behaves.

## Where it lives in the admin menu

Once enabled, the toolbar is active site‑wide immediately. Its own settings form
sits at **Configuration → User interface → Admin Toolbar**
(`/admin/config/user-interface/admin-toolbar`).
