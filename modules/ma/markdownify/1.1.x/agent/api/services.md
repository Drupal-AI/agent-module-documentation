# Services, link template & token

## Services you can call

| Service id | Class | Use |
|---|---|---|
| `markdownify.entity_converter` | `MarkdownifyEntityConverter` | `convertEntityToMarkdown($entity, $view_mode = 'full', $langcode = NULL, ?BubbleableMetadata)` → renders the entity then converts to Markdown. The one-call entry point. |
| `markdownify.entity_renderer` | `MarkdownifyEntityRenderer` | renders a supported entity to HTML (fires `hook_markdownify_entity_build_alter` / `_html_alter`). |
| `markdownify.html_converter` | `MarkdownifyHtmlConverter` | `convert(string $html, ?BubbleableMetadata)` → runs the configured converter plugin (fires `_markdown_alter`). Used by markdownify_views too. |
| `markdownify.supported_entity_types.validator` | `MarkdownifySupportedEntityTypesValidator` | `isSupported($entity_type_id)`, `getSupportedEntities()`, `getSupportedEntityTypes()` — reads `supported_entities` config + applies the alter hooks; also enforces bundle/language include/exclude. |
| `plugin.manager.html_to_markdown_converter` | `HtmlToMarkdownConverterManager` | the converter plugin manager (see plugins doc). |

Programmatic conversion:

```php
$md = \Drupal::service('markdownify.entity_converter')
  ->convertEntityToMarkdown($node, 'full');
```

## Link template

`markdownify_entity_type_alter()` adds a **`markdownify`** link template
(`<canonical path>.md`) to every supported entity type that has a `canonical` template:

```php
$url = $node->toUrl('markdownify')->setAbsolute()->toString();  // e.g. /markdownify/node/1 or /node/1.md
$has = $node->hasLinkTemplate('markdownify');                    // TRUE when supported
```

## Token

`markdownify_token_info_alter()` / `markdownify_tokens()` add
`[<entity_type>:markdownify-url]` (e.g. `[node:markdownify-url]`, `[taxonomy_term:markdownify-url]`)
for supported entity types — the absolute URL of the Markdown version.

## Response / negotiation internals

- `MarkdownResponse` — a `CacheableResponse` with `Content-Type: text/markdown`.
- `MarkdownifyNegotiationMiddleware` (http_middleware, prio 250) turns `Accept: text/markdown`
  into `?_format=markdown` **before** page cache, so cached HTML and Markdown never collide.
- `MarkdownifyEntityRoutesSubscriber` + `MarkdownifyVaryAcceptSubscriber` add `Vary: Accept`
  to supported canonical routes for safe proxy caching.
- `MarkdownifyNoIndexSubscriber` adds `X-Robots-Tag: noindex` when
  `markdownify.settings:noindex` is TRUE.
