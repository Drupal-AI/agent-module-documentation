# Metatag Auto Pagination — manual setup guide

**Metatag Auto Pagination** (`metatag_auto_pagination`) automatically emits
`rel="prev"` and `rel="next"` link tags in the page head whenever a page renders a
pager. Search engines have historically used these links to understand paginated
series — page 2, 3, and so on of a listing — and adding them by hand for every view
or listing is tedious. This module derives them automatically from Drupal's core
pager, so your multi-page listings signal their sequence to search engines without
any per-view work.

It is an extension of the [Metatag](https://www.drupal.org/project/metatag) module:
it ships a `PagerLinks` metatag tag plugin plus services that read the active pager
and inject the computed prev/next `<link>` elements into the response. When a page
has a pager and is not on the first or last page, the appropriate links are
attached; on out-of-range pages they are suppressed. It works on paginated views,
node listings, taxonomy term pages, and anywhere else core's pager appears.

The module has no routes, permissions, forms, or configuration entities of its own,
and it only reads the current pager state to write `<link>` tags — so there is no
untrusted input handling. It depends on the Metatag module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Metatag dependency.

There is **no configuration page** for this module. The one thing you must do after
enabling it is switch on its service in the Metatag basic settings — see "How to use
it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. Its behaviour is turned on from the
standard **Metatag** basic configuration.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the standard **Metatag** basic configuration and switch on the
   **AUTO PAGER LINKS** service.
3. That's it. On any page with a pager, the `rel="prev"` / `rel="next"` link tags
   are attached automatically — suppressed on the first page (no prev) and last page
   (no next). You can verify by viewing the page source of a paginated listing and
   checking the document head.
