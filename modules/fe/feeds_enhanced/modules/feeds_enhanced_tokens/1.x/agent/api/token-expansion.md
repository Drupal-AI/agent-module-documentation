<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Enhanced Tokens — token-expansion pipeline

Zero-config token expansion for the Feeds import pipeline. Enable with
`drush en feeds_enhanced_tokens -y && drush cr` (needs `token`, `feeds`, `dx_toolkit`). No settings.

## Event subscriber — TokenExpansionSubscriber

`src/EventSubscriber/TokenExpansionSubscriber.php` (service
`feeds_enhanced_tokens.event_subscriber`). Subscribes:
- `FeedsEvents::INIT_IMPORT` → `onInitImport` **priority 1000** (runs before any fetch/parse/process
  reads config or source).
- `FeedsEvents::IMPORT_FINISHED` → `onImportFinished` **priority -1000** (runs last; clears cache).

`onInitImport(InitEvent $event)`:
- `expandFeedEntityFields($feed)` — iterates `$feed->getFields()`, and for each field-item property:
  string → `TokenExpander::expandString($value, $feed)`; array → `expandConfiguration($value, $feed)`;
  else unchanged. Writes back via `$property->setValue()` only when the value changed. This covers
  base fields (source, label) **and** any custom/contrib fields on the Feed entity.
- `expandPluginConfigurations($feed, $feedType)` — for the fetcher, parser and processor, expands
  `$plugin->getConfiguration()` and `setConfiguration()` back **at the feed-type level only**. It
  intentionally does **not** expand/persist feed-level plugin config (that would overwrite the
  stored tokens with expanded values); plugins needing feed-level tokens expand at runtime — e.g.
  `SftpFetcher::fetch()` expands its `host` itself.

`onImportFinished(ImportFinishedEvent $event)` → `TokenExpander::clearCache()`.

## Service — TokenExpander

`src/TokenExpander.php` (service `feeds_enhanced_tokens.token_expander`; args `token`,
`current_user`, `entity_type.manager`, logger).

- `expandString(string $text, FeedInterface $feed, array $additionalData = []): string`
  - `containsTokens()` early-exit: only proceeds when the text contains both `[` and `]`.
  - Memoizes in `$expandedTokenCache` keyed by `md5($text . serialize($additionalData))`.
  - Builds context and calls `Token::replace($text, $data, ['clear' => FALSE])` — **unmatched tokens
    are left intact**, not stripped.
- `buildTokenContext(FeedInterface $feed)` = `['feed' => $feed, 'feed-type' => $feed->getType(),
  'current-user' => $currentUser->getAccount(), 'site' => NULL, 'date' => NULL]`. So `[feed:*]`,
  `[feed-type:*]`, `[current-user:*]`, `[site:*]`, `[date:*]` and any global/custom tokens resolve;
  `current-user` is the account running the import (interactive user or cron user).
- `expandConfiguration(array, $feed)` → `traverseAndExpand()` recurses arrays and expands each string
  leaf. `clearCache()` empties the per-import cache.

No `eval`, no PHP/Twig execution — expansion is entirely through core's Token replacement API, so a
malformed token degrades to literal text rather than executing.

## Form integration — feeds_enhanced_tokens.module

- `hook_form_alter()`: on forms whose id starts with `feeds_feed_` or `feed_type_` (and not
  containing `delete`/`confirm`), appends a collapsed **"Available Tokens"** details element
  (`#weight 99`) containing a `token_tree_link` (`#global_types => TRUE`, `#dialog => TRUE`) so
  editors can browse valid tokens.
- `hook_help()`: help text for `help.page.feeds_enhanced_tokens`.

## Operating notes

- Tokens are entered by users who can edit Feeds/Feed Types (a restricted, admin-level capability)
  and are evaluated with the importing user's context — a config-trust surface owned by feed
  editors, as with any token-enabled field.
- Troubleshooting: `drush cr`; check the `feeds_enhanced_tokens` log channel
  (`drush wd-show --type=feeds_enhanced_tokens`); verify token syntax at `/admin/help/token`.
