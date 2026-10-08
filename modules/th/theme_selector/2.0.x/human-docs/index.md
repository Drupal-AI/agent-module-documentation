# Theme Selector — manual setup guide

**Theme Selector** (`theme_selector`) lets you change the theme a page renders
with by adding a query-string parameter to the URL. Instead of switching the
site's default theme in the admin UI, you append something like
`?theme-selector=bartik` to a link and that page loads with the chosen theme —
picked from a short list of themes you have explicitly marked as selectable.

It's a small, focused theme-negotiation helper. Common uses are previewing a
theme before you make it live, running an A/B comparison between two themes, or
giving people a link that renders your content in an alternate look. The module
adds a Theme Negotiator behind the scenes, so the switch happens cleanly during
the normal page render.

Two things are worth knowing before you rely on it. First, switching is bounded:
only themes an administrator has added as Theme Selector entities can be chosen,
so a visitor cannot force an arbitrary installed theme through the query string —
which keeps it from becoming a defacement or UX-confusion vector. It is a good
idea to double-check that only the themes you intend are configured as selectable.
Second, because the theme is decided by a query parameter, page cache is disabled
for the affected requests — that is a deliberate trade-off noted by the module's
author, so keep it in mind on high-traffic sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the themes you want to make
   selectable and the query suffix that triggers each one.

## Where it lives in the admin menu

Once enabled, you manage selectable themes at **Configuration → User interface →
Theme Selector** (`/admin/config/user-interface/theme-selector`). This is the
list of Theme Selector entities; each one ties a theme to the value you use in the
query string.

## How to use it

After you have configured at least one selectable theme, add the query parameter
to any page URL — for example `https://example.com/?theme-selector=dark`. That
page renders with the matching theme, while the rest of the site keeps its normal
theme. It changes presentation only; it does not affect content or access.
