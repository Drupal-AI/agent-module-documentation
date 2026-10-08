# Services, controller & hooks

## Services (`embederator.services.yml`)

### `embederator.render` — `Drupal\embederator\EmbederatorRender`
Args: `@http_client`, `@token`, `@module_handler`.

- `getEmbedMarkup($type, $entity, $settings)` — token-replaces the bundle's `embed_markup.value` with
  the entity, fires `hook_embederator_markup_alter`, returns the string.
- `getSsiMarkup($type, $entity, $settings)` — token-replaces the bundle's `embed_url`, fires
  `hook_embederator_url_alter`, GETs it via `http_client`, uses the response body as markup (on
  `ClientException` returns `"<p>Unable to load {$url}</p>"`), then fires `hook_embederator_markup_alter`.
- `generateElement($markup)` — wraps markup as `['#type' => 'processed_text', '#text' => $markup,
  '#format' => 'full_html']`. **Always full_html.**

### `embederator.utilities` — `Drupal\embederator\EmbederatorUtilities`
Args: `@entity_type.manager`, `@token`. Form helpers used by the entity add/edit form
(`customizeForm()` builds the token preview + paste-parser). `uniquify($html)` rewrites form-input
`id`/`for` attributes with a `uniqid()` suffix.

## Controller

`Drupal\embederator\Controller\AjaxRender::render(Embederator $embederator, string $settings_json)` —
backs route `embederator.lazyload`. Decodes the settings JSON, renders SSI or embed markup via
`embederator.render`, appends the iframeResizer contentWindow script when `loadstyle=iframe`, returns a
raw `Response`. Route requires `_entity_access: embederator.view`.

## Entity reference selection

`Plugin/EntityReferenceSelection/EmbederatorSelection` — lets other entity-reference fields target
`embederator` entities.

## Alter hooks (`embederator.api.php`)

```php
// Adjust the SSI fetch URL. $context = ['embederator_type','entity','settings'].
function hook_embederator_url_alter(&$url, $context) { ... }

// Rewrite markup just before it is wrapped for render.
function hook_embederator_markup_alter(&$html, $context) { ... }

// Force lazyload on/off per embed. $context includes ['entity'].
function hook_embederator_lazyload_alter(&$lazyload, $context) { ... }
```

The module's own `hook_embederator_markup_alter` implementation runs `uniquify()` when the formatter's
`append_unique_id` setting is on.
