<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Serving `/llms.txt` and extending it

## Route + controller

| Route | Path | Access | Controller |
|---|---|---|---|
| `llmstxt.content` | `/llms.txt` | `_access: 'TRUE'` (public), `_disable_route_normalizer: 'TRUE'` | `\Drupal\llmstxt\Controller\LlmsTxtController::content()` |

`_disable_route_normalizer: 'TRUE'` stops the core path normalizer from redirecting the exact
`/llms.txt` path.

## How the body is assembled

`content()` builds the response like this:

1. Starts with the configured `llmstxt.settings:content` string.
2. Calls `$this->moduleHandler->invokeAll('llmstxt')` and appends every returned string.
3. `array_map('trim', ...)` then `array_filter(...)` (drops empty entries), then
   `implode("\n", ...)`.
4. Returns a `CacheableResponse` (HTTP 200) with header `content-type: text/plain`, cache tag
   `llmstxt`, and cache context `url.site`.

Only admin-authored config and module-provided hook lines are emitted; the controller does
not query nodes, users, or any other entities.

## `hook_llmstxt()` — add lines programmatically

Implement this hook to append lines to the file from your own module (declared in
`llmstxt.api.php`):

```php
/**
 * Implements hook_llmstxt().
 *
 * @return string[]
 *   Lines appended after the configured content.
 */
function mymodule_llmstxt() {
  return [
    '## API',
    '- [OpenAPI spec](https://example.com/openapi.json)',
  ];
}
```

Each returned element is trimmed and empty ones are removed, then all are joined with `\n`
after the config body. There is no ordering/weight control — additions follow the config
content in module invocation order.

## Cache invalidation

The response is cached under tag `llmstxt`. The settings form invalidates that tag on save;
if you change `llmstxt.settings` or the output of a `hook_llmstxt()` implementation
programmatically, invalidate it yourself:

```php
\Drupal\Core\Cache\Cache::invalidateTags(['llmstxt']);
```
