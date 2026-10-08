# Extended Path Aliases — manual setup guide

**Extended Path Aliases** (`path_alias_xt`) finishes a job that core's Path module
leaves half‑done. When you alias `node/123` to `about-us`, core only aliases that
one base path — the entity's task tabs and related links stay ugly and
machine‑generated: `/node/123/edit`, `/node/123/revisions`, and so on. This module
carries your clean, SEO‑friendly alias through to those tabs and links, so the
edit tab on your About Us page shows as `about-us/edit` instead of
`node/123/edit`. The same applies to `/taxonomy/term/%` and `/user/%` paths — a
user's track page can read `/dries/track` rather than `/user/5/track`.

It also lets aliases be used with **wildcards** in page‑specification contexts. If
you configure a block to appear on `about-us*`, the block correctly shows on the
aliased tab pages too — where core would only match the raw system path
(`node/123*`).

An important clarification: this is a **URL/routing** feature, not an access
feature. Aliasing the edit tab does not change who can edit the page — the edit
tab is still governed by normal Drupal permissions. All the module does is make
that tab's URL respect your alias.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The core behaviour — aliased tabs, aliased links, and wildcard matching — works
the moment you enable the module, with no configuration required, so this guide
does not include a separate configuration chapter. (The module does register a
settings form and its own permissions; the one feature that needs extra setup is
described under "How to use it" below.)

## Where it lives in the admin menu

There is nothing you *must* configure — enable the module and clean aliases start
extending to tabs and links immediately. The module registers a settings form
(route `path_alias_xt.settings_form`) among the site's configuration pages for the
advanced behaviour noted below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Make sure a base alias exists for the path you care about (create it by hand at
   **Configuration → Search and metadata → URL aliases**, or bulk‑generate
   aliases with **Pathauto**). Extended aliases are derived from that base alias —
   if there's no alias for `node/123`, there's nothing for the tabs to extend.
3. Visit the aliased page and click its **Edit** (or other) tab — the URL should
   now read `about-us/edit` rather than `node/123/edit`.

### Advanced: carrying aliases through to block visibility on `*` tabs

Three of the module's four headline behaviours work as soon as it is enabled. The
fourth — making blocks configured for `about-us/*` stay visible on the aliased
tab pages — requires one extra one‑time step, because it changes how core matches
paths at a low level. The module's included **README** documents two ways to do
it: inserting a statement into core's `include/path.inc`, or installing the PECL
`runkit` library. The `path.inc` edit is simple and reliable but must be
reapplied after each core update (a core install overwrites the file); the runkit
approach is a one‑off that survives future core installs. Consult the module's
README for the exact instructions before choosing an approach.

## Works well alongside

Extended Path Aliases is designed to cooperate with **Pathauto** (recommended for
generating base aliases), **Redirect**, and **Domain Access**.
