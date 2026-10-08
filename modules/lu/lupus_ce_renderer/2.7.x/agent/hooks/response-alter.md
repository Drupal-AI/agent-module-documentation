# Altering the response: hook + request-attribute override

The renderer offers two override points, applied in this order inside
`CustomElementsRenderer::renderResponse()` (both after the base envelope is built):

1. **Request attribute `lupus_ce_renderer_response_data`** — if this request attribute holds an
   array, it is merged into the response data with `array_replace_recursive()`. This is a per-request
   override intended for middleware/controllers (request attributes are internal — a remote client
   cannot set them via query/POST).
2. **`hook_lupus_ce_renderer_response_alter()`** — fired via
   `moduleHandler->alter('lupus_ce_renderer_response', …)`, so it runs after the request-attribute
   merge and has the final say. It also fires on the redirect path
   (`CustomElementsRedirectResponseSubscriber`).

## Hook signature

Declared in `lupus_ce_renderer.api.php`:

```php
/**
 * Alters response data of the custom elements renderer.
 */
function hook_lupus_ce_renderer_response_alter(array &$data, \Drupal\Core\Render\BubbleableMetadata $bubbleable_metadata, \Symfony\Component\HttpFoundation\Request $request) {
  // Override any envelope key.
  $data['title'] = 'foo';

  // Add cache metadata so your alteration invalidates correctly.
  $bubbleable_metadata->addCacheTags(['my_module:custom']);
}
```

`&$data` is passed by reference. There is no `.module` file in this module and it implements no hooks
of its own — this is the only integrator-facing hook it invokes.

## Response data keys you can alter

For a page response: `title`, `breadcrumbs` (list of `{frontpage,url,label}`), `metatags`
(`{meta:[…], link:[…]}`), `content_format` (`markup`|`json`), `content`, `page_layout`. The
late-added `local_tasks` and `messages` are appended *after* this hook by
`CustomElementsDynamicResponseSubscriber`, so altering them here has no effect. For a redirect
response the data is `{redirect:{external,url,statusCode}, messages:[…]}`.

Add any cache tags/contexts/max-age your override depends on to `$bubbleable_metadata`; it is
attached to the `CustomElementsJsonResponse` as a cacheable dependency.
