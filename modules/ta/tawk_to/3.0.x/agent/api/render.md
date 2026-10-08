# Tawk.to — render service & visibility API

Programmatic surface: three services wire the widget into the page footer.

## Attachment
`tawk_to_page_bottom()` (`hook_page_bottom`) adds a `#lazy_builder` placeholder calling
`tawk_to.embed_render:render` with `#create_placeholder => TRUE`, so the widget is rendered
out-of-band (per-user, cache-safe).

## `tawk_to.embed_render` — `TawkToEmbedRender` (implements `TrustedCallbackInterface`)
- Constructor reads `tawk_to.settings`: widget page/widget IDs, and — when `show_user_name`/
  `show_user_email` are on — token-replaces `user_name`/`user_email` (`Token::replace(..., ['clear'=>TRUE])`).
  `script_load_delay` cast to int.
- `render(): ?array`
  - Returns `[]` if either widget id is empty.
  - Calls `TawkToConditionPluginsHandler::checkAccess()`; if it passes, returns a `#theme => 'tawk_to'`
    render array with `#items` `{page_id, widget_id, embed_url (const https://embed.tawk.to),
    user_name, user_email, script_load_delay}` and `#cache` from the cache manager.
  - Returns `[]` when conditions fail.
- `trustedCallbacks()` → `['render']`. Const `EMBED_URL = 'https://embed.tawk.to'`.

## `tawk_to.condition_plugins_handler` — `TawkToConditionPluginsHandler`
- Uses `ConditionAccessResolverTrait`. Reads `visibility` from config.
- `getConditions()` — instantiates each stored condition plugin, applies context mapping via
  `context.repository` + `context.handler` (silently ignores `ContextException`).
- `checkAccess(): bool` — `TRUE` if no conditions configured; otherwise `resolveConditions($conditions, 'and')`
  (all conditions must pass).

## `tawk_to.cache_manager` — `TawkToCacheManager`
- `getCacheTags()` → `['config:tawk_to.settings']` merged with each condition's cache tags.
- `getCacheContexts()` → `['session', 'user']` merged with each condition's cache contexts.

## Templates
- `tawk_to` → `templates/tawk-to.html.twig`: inline `<script>` building `Tawk_API.visitor` from
  `user_name`/`user_email` and injecting `embed_url/page_id/widget_id` after `script_load_delay` ms.
- `tawk_to_iframe` → `templates/tawk-to-iframe.html.twig`: the admin widget-picker iframe + its
  postMessage → set/remove POST JS.
