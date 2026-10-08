# Plugin reference

## Argument-default plugins (`@ViewsArgumentDefault`)

All three extend `ArgumentDefaultPluginBase`, implement `CacheableDependencyInterface`, and pass
their `fallback_value` through `token.replace($value, ['user' => currentUser])`.

### `session` — "Session variable from session"

Class `Plugin/views/argument_default/Session`.

| Option | Default | Notes |
|---|---|---|
| `session_key` | `''` | Path into `$_SESSION`; nested via `key1::key2` (walks the array). |
| `fallback_value` | `FALSE` | Used when the session value is empty; token-replaced (user). |
| `cache_time` | `-1` | `getCacheMaxAge()`; set `0` if the session value changes mid-session. |

`getArgument()` returns the session value (recursing with `findArrayValue()`), else the
token-replaced fallback. Cache context: `session`.

### `cookie` — "Cookie variable from cookie"

Class `Plugin/views/argument_default/Cookie`.

| Option | Default | Notes |
|---|---|---|
| `cookie_key` | `''` | Actual cookie read is `$_COOKIE['Drupal_visitor_' . cookie_key]` — the `Drupal_visitor_` prefix is added automatically (matches Drupal's `user_cookie_save()`). |
| `fallback_value` | `FALSE` | Token-replaced (user) fallback when the cookie is absent. |

`getCacheMaxAge()` = `Cache::PERMANENT`. Cache context: `cookies:Drupal_visitor_<key>`.

### `tempstore` — "TempStore variable"

Class `Plugin/views/argument_default/TempStore`.

| Option | Default | Notes |
|---|---|---|
| `tempStore_unique_name` | `''` | Namespace passed to `PrivateTempStoreFactory::get()`. |
| `tempStore_key` | `''` | Key read from that store. |
| `fallback_value` | `FALSE` | Token-replaced (user) fallback. |
| `cache_time` | `-1` | `getCacheMaxAge()`. |

Cache context: `session`.

Config schema for these option sets lives in
`config/schema/views_extras.argument_default.schema.yml` (`views.argument_default.session`,
`.cookie`, `.tempstore`).

## Area handler — `extra_result` (`@ViewsArea`)

Class `Plugin/views/area/ExtraResult`, registered by `views_extras_views_data()` on the `views`
table. Single option `content` (default `'Displaying @start - @end of @total'`). It does **not**
render on summary-style displays (`DefaultSummary`).

Supported replacement tokens in `content`:

| Token | Meaning |
|---|---|
| `@start` | First record number on the page |
| `@end` | Last record number on the page |
| `@total` | Total records (forces `get_total_rows`) |
| `@label` | View's human label |
| `@per_page` | Items per page |
| `@current_page` | Current page number (1-based) |
| `@current_record_count` | Records shown on the current page |
| `@page_count` | Total page count |
| `@more` | `@total - @current_record_count` (line hidden if 0; also forces total rows) |

Output is filtered with `Xss::filterAdmin()`, so admin-safe HTML is allowed in `content`.
