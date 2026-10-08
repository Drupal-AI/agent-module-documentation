<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translate View Path (tvp) — agent index

Makes a **Views page's URL follow the per-language path alias** you create for it in core's URL
Alias UI. A view is reached by a *route*, so core does not substitute a route path with its alias
when building or resolving the URL — this module does. Its headline case is **Facets Pretty Paths**,
whose URLs are the view path plus dynamically generated facet segments and would otherwise stay in
the source language. Version **1.1.2**. Core `^8.8.0 || ^9 || ^10 || ^11`, PHP `>=8`.

## What it actually is
A single service, `tvp.page_path_processor` = `Drupal\tvp\PathProcessor\TvpProcessor`
(`src/PathProcessor/TvpProcessor.php`), tagged as **both** an inbound path processor (priority 1000)
and an outbound path processor (priority -1000) in `tvp.services.yml`. It is NOT a Views plugin, a
field, a block, or a config entity. There are **no routes, no permissions, no settings form, no
config schema, no Drush commands, no hooks** except `tvp_help()` (a static help blurb) in
`tvp.module`.

## Mechanism
- `getViewPathOptions()` — `Views::getAllViews()`, collect every display's `display_options.path`,
  skipping `admin/` paths.
- `getViewPathAliases()` — for each view path × each enabled language, look up the core alias via
  `AliasManagerInterface::getAliasByPath()`. Result cached **24h** under cache id
  `view_path_aliases_cid` in `cache.default`. **Clear caches after changing a view path or its
  aliases.**
- `processOutbound()` → `getOutboundPath()` — if the URL's `$options['language']` matches a language
  that has an alias for the matched view path, rewrite path → alias. Skips `/admin`, `/`.
- `processInbound()` → `getInboundPath()` — only acts when the request path equals the incoming path,
  is non-admin, current language ≠ default language, no direct alias already resolves it, and the
  path contains the language segment; then rewrites the aliased/prefixed path back to the view route
  path so routing resolves.
- `strReplaceFirst()` — helper doing a first-occurrence `substr_replace`, with an alias-manager
  guard to avoid mis-rewriting.

## Setup (all in core, no module UI)
See [configure/setup.md](configure/setup.md). In short: create the view, then at
`/admin/config/search/path` add a URL alias of the view's path for each language, then clear caches.

## Dependencies
Core `path_alias` and `views`. Services injected: `path_alias.manager`, `language_manager`,
`path_alias.repository`, `cache.default`, `request_stack`.

## Security
No routes, no access-controlled surface, no user-facing rendered output, no DB queries, no external
requests. Path processing is string rewriting over paths discovered from view config and core
aliases. No role or access dimension. See usage.md for behavioural caveats (round-tripping, the 24h
cache).
