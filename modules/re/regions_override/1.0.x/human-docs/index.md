# Regions Override — manual setup guide

**Regions Override** (`regions_override`) lets editors **turn off theme regions on
specific pages** — so a sidebar, header or footer can be suppressed on the pages
where you don't want it. The classic case is a site that uses sidebars but also
uses core's **Layout Builder**: since Layout Builder only renders in the content
region, an editor can disable the sidebars on a particular node so Layout Builder
gets the full page width. It's also handy for splash pages an editor wants to build
top-to-bottom without the theme's usual chrome.

On entity pages and Views pages, Regions Override offers four choices for how
regions display:

- **Show all available regions** (the normal behavior),
- **No sidebars**,
- **Remove body regions** (header and footer stay),
- **Remove all regions**.

To make those choices work generically across any theme, you first tell each theme
which of its regions belong to three buckets — **header**, **sidebar** and
**footer**. The four options above then hide the right regions no matter what a
theme calls them. Two things are always protected so editors don't lock themselves
out: the **Content** region is never removed, and the **Primary Tabs** block (View
/ Edit / Delete) is never hidden.

Overrides can be set a few ways: per node via a field on the node edit form, as a
per-content-type default, or ad hoc through an admin-toolbar shortcut on each page.
It provides its own **permission** so you control which roles may override regions.
Note that hiding a region only stops it rendering on that page — the blocks in it
keep their own access rules, and this is a display feature, not an access-control
one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — permissions, mapping each theme's
   regions to header/sidebar/footer, and setting per-content-type and per-page
   overrides.

## Where it lives in the admin menu

Regions Override doesn't add one central settings page. Instead its configuration
is spread across the places it affects:

- **Permissions** at **People → Permissions** (`/admin/people/permissions`).
- **Region groupings** in each **theme's settings** (**Appearance → Settings →
  *(theme)***).
- **Per-content-type defaults** on each content type's **Edit** page
  (**Structure → Content types → *(type)* → Edit**).
- **Per-node overrides** via a field on the node edit form, plus an admin-toolbar
  shortcut on each page.

See [Configuration](configuration/index.md) for the recommended order.
