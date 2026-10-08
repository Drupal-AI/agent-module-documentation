# Fix Teaserlinks — manual setup guide

**Fix Teaserlinks** (`fixteaserlinks`) lets you hide the links that Drupal shows
under a node in **teaser** view — links such as *Read more*, *Add new comment*,
and *Log in or register to post comments*. It's aimed at site builders who want a
cleaner look for teaser lists, card grids, front pages, and Views‑based listings
without editing theme templates.

It works by altering the node links render array in teaser view mode only, based
on a small settings form, so it's a safe, theme‑agnostic way to tidy up listings.
It defines no entities, services, or permissions of its own — just the settings
form and a couple of hook implementations. It can also surface extra help text
through the optional *advanced_help_hint* module if you have that installed.

> **Worth knowing before you start:** on Drupal 8 and later, if you simply want to
> *remove* teaser links, you may not need this module at all. You can go to a
> content type's **Manage display** for the teaser view mode and drag the
> **Links** field down into the *Disabled* section. For that reason this module is
> considered **deprecated** in favour of core's Manage display — reach for it only
> when the core approach doesn't cover your case.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and rebuild caches.
2. [Configuration](configuration/index.md) — the settings form, where you choose
   which teaser links to hide.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Fix Teaserlinks**
(`/admin/config/system/fixteaserlinks`), and it requires the **Administer site
configuration** permission.
