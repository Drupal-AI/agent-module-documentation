# Metatag Paths — manual setup guide

**Metatag Paths** (`metatag_paths`) lets you assign meta tags based on **URL path
patterns**, with wildcard support. Instead of setting meta tags entity by entity,
you define a pattern like `/news/` or `/blog/*` and attach a set of meta tags to
every page whose path matches. It's ideal for applying consistent metadata across a
whole section of the site — or for providing sensible fallbacks where entity-level
tags are missing.

It builds on the [Metatag](https://www.drupal.org/project/metatag) module and also
uses core's Path Alias module. Path-based tags sit in a well-defined precedence:
they apply above global defaults but below entity-specific and route-specific tags,
and they take precedence over bundle and entity-type defaults. When several patterns
match the same page, the most specific one wins (the longest non-wildcard path).

A handy option, **Replace Empty Token Results**, makes path-based tags act as
fallbacks: if an entity's meta tag uses a token (say `[node:title]`) that resolves
to an empty value, the path-based tag's value is used instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Metatag dependency.

The path patterns are managed inside the Metatag configuration rather than on a
separate settings page — see "How to use it" below.

## Where it lives in the admin menu

Path patterns are managed from **Administration → Configuration → Search and
metadata → Metatag**, where the module adds an **Add metatag for path pattern**
action.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Search and metadata → Metatag** and click **Add metatag
   for path pattern**.
3. Enter a **label**, a **machine name**, the **path pattern**, and choose whether
   to enable **Replace empty token results**.
4. Save, then configure the meta tags for that pattern like any other Metatag
   default.

### Pattern syntax

- **Prefix match** (trailing `/`) — matches everything under a prefix at any depth.
  `/news/` matches `/news/article` and `/news/sports/scores`.
- **Wildcard match** (`*`) — matches exactly one path segment. `/blog/*` matches
  `/blog/post-1` but not `/blog` or `/blog/a/b`. `/user/*/edit` matches
  `/user/5/edit`.
- **Partial wildcard** — use `*` within a segment. `/blog/post-*` matches
  `/blog/post-1` and `/blog/post-2` but not `/blog/other`.

When multiple patterns match, the most specific (longest non-wildcard path) wins.
