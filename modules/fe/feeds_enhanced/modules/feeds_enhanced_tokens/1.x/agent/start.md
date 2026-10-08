<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Enhanced - Token Support (feeds_enhanced_tokens) — agent index

Submodule of **Feeds Enhanced**. Universal token expansion for all Feeds/Feed-Type text fields and
plugin configurations during import. Package `Feeds`. Core `^10.1 || ^11`. GPL-2.0-or-later.
Part of project `feeds_enhanced` (installed 1.0.0-beta14; version-dir `1.x`).

- **Deps** (info.yml): `dx_toolkit`, `feeds`, `token`. (Note: it does *not* declare a dependency on
  the parent `feeds_enhanced` module.)
- **No** routes, permissions, config schema, or Drush. One event subscriber, one service, one
  `hook_form_alter`, one `hook_help`.

## What it provides (from source)

- Service `feeds_enhanced_tokens.token_expander` = `TokenExpander` (`src/TokenExpander.php`); args
  `token`, `current_user`, `entity_type.manager`, logger channel.
- Event subscriber `feeds_enhanced_tokens.event_subscriber` = `TokenExpansionSubscriber`
  (`src/EventSubscriber/TokenExpansionSubscriber.php`), tagged `event_subscriber`.
- `feeds_enhanced_tokens.module`: `hook_help()` (help page text) and `hook_form_alter()` adding an
  "Available Tokens" `token_tree_link` details element to `feeds_feed_*` / `feed_type_*` forms
  (skips `delete`/`confirm` forms).
- `src/Extension.php` — static `name()`/`label()` helpers.

## Mechanism

`TokenExpansionSubscriber::getSubscribedEvents()` → `INIT_IMPORT` `onInitImport` @1000,
`IMPORT_FINISHED` `onImportFinished` @-1000.
- `onInitImport`: `expandFeedEntityFields($feed)` walks every field item property (string →
  `expandString`, array → `expandConfiguration`) and writes back changed values;
  `expandPluginConfigurations($feed, $feedType)` expands fetcher/parser/processor **feed-type-level**
  config in memory (deliberately does **not** persist feed-level config, so stored tokens survive).
- `onImportFinished`: `TokenExpander::clearCache()`.

`TokenExpander`: `containsTokens()` early-exit on `[`+`]`; `expandString()` md5-caches by
text+data, builds context `buildTokenContext()` = `feed`, `feed-type`, `current-user` (account),
`site`, `date`, and calls `Token::replace($text, $data, ['clear' => FALSE])`.
`expandConfiguration()`/`traverseAndExpand()` recurse arrays. No PHP/Twig eval — pure Token API.

## Solution doc

- Full token-expansion pipeline, context, caching, form browser → [api/token-expansion.md](api/token-expansion.md)
