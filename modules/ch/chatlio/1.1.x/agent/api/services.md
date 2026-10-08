<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chatlio — render pipeline, services, cache & JS

## Entry point

`chatlio_page_bottom()` (`chatlio.module`, implements `hook_page_bottom()`) runs on every page:

```php
$page_bottom['chatlio_widget'] = \Drupal::service('chatlio.embed_render')->render();
```

`hook_help()` for `help.page.chatlio` returns a short blurb linking to chatlio.com.

## Services (`chatlio.services.yml`)

### `chatlio.embed_render` → `ChatlioEmbedRender` (`src/Service/ChatlioEmbedRender.php`)
Args: `config.factory`, `token`, `chatlio.condition_plugins_handler`, `chatlio.cache_manager`,
`current_user`, `router.admin_context`, `path.current`.

- **Constructor** resolves `user_name`/`user_email` through `Token::replace(..., ['clear' => TRUE])`
  only when `show_user_name` / `show_user_email` are set.
- **`render(): ?array`** returns NULL (widget not shown) when:
  - `chatlio_enable` is false, or
  - `chatlio_enable_admin` is false **and** `AdminContext::isAdminRoute()` is true, or
  - `ChatlioConditionPluginsHandler::checkAccess()` returns false.
- Otherwise returns a render array:
  - `#markup => Markup::create($settings->get('chatlio_code'))` — the pasted vendor snippet.
  - `#attached['library'] => ['chatlio/integration']`.
  - `#attached['drupalSettings']['chatlio']` = `disable_mobile`, `enabled`, and (when
    `user_identify` and the user is authenticated) `uid`, `name`, `mail`, and a `loggedinas`
    translated link built with `Url::fromRoute('entity.user.canonical', ...)`.
  - `#cache` = contexts/tags from the cache manager.

### `chatlio.condition_plugins_handler` → `ChatlioConditionPluginsHandler` (`src/Service/…`)
Args: `config.factory`, `context.handler`, `context.repository`, `plugin.manager.condition`.
Uses `ConditionAccessResolverTrait`.

- **`checkAccess(): bool`** — if `visibility` is empty, returns TRUE (show everywhere); otherwise
  builds condition instances and returns `resolveConditions($conditions, 'and')` (**all** conditions
  must pass).
- **`getConditions(): array`** — instantiates each configured condition via the condition manager;
  for `ContextAwarePluginInterface` conditions it applies runtime context mapping, catching
  `ContextException` (swallowed, `@todo` noted) so a missing context does not fatal the page.

### `chatlio.cache_manager` → `ChatlioCacheManager` (`src/Cache/ChatlioCacheManager.php`)
Arg: `chatlio.condition_plugins_handler`.

- **`getCacheTags()`** — starts with `['config:chatlio.settings']` and merges each condition's
  `getCacheTags()` (for `CacheableDependencyInterface` conditions).
- **`getCacheContexts()`** — starts with `['session']` and merges each condition's
  `getCacheContexts()`.

## Library & JS (`chatlio.libraries.yml`, `js/chatlio.js`)

Library `chatlio/integration` attaches `js/chatlio.js` and depends on `core/jquery`,
`core/drupal`, `core/drupalSettings`. `Drupal.behaviors.chatlio.attach()`:

- Returns early if `window._chatlio` is undefined (the vendor snippet defines it).
- If `disable_mobile` and `enabled`: on the `chatlio.ready` event, hides the widget
  (`window._chatlio.hide()`) for iPhone/iPad/Android user agents.
- If `settings.chatlio.uid` is set: on `chatlio.ready`, calls `window._chatlio.identify(...)`.
  **Known bug:** the arguments are passed as **literal strings** (`'settings.chatlio.uid'`,
  `'settings.chatlio.name'`, etc.) rather than the actual `settings.chatlio.*` values, so user
  identification does not currently forward real data to Chatlio.

## What it does NOT do

No entities, no permissions file, no Drush, no plugin types, no external module deps, and no
server-side HTTP calls (the module never fetches a remote URL; the chat script is loaded
client-side by the admin-supplied embed code).
