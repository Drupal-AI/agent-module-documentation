# Services, link template & token

## Services you can call

| Service id | Class | Use |
|---|---|---|
| `markdownify.entity_converter` | `MarkdownifyEntityConverter` | `convertEntityToMarkdown($entity, $view_mode = 'full', $langcode = NULL, ?BubbleableMetadata)` → renders the entity then converts to Markdown. The one-call entry point. |
| `markdownify.entity_renderer` | `MarkdownifyEntityRenderer` | `toHtml($entity, $view_mode, $langcode, ?BubbleableMetadata)` — renders a supported entity to HTML (fires `hook_markdownify_entity_build_alter` / `_html_alter`). |
| `markdownify.html_converter` | `MarkdownifyHtmlConverter` | `convert(string $html, ?BubbleableMetadata)` → runs the configured converter plugin (fires `_markdown_alter`). Used by markdownify_views too. Returns `''` on empty input or on a caught exception (logged). |
| `markdownify.supported_entity_types.validator` | `MarkdownifySupportedEntityTypesValidator` | `isSupported($entity_type_id)`, `getSupportedEntities()` (applies the `markdownify_supported_entities` alter), `getSupportedEntityTypes()` (**deprecated** 1.1.1, removed 2.0.0). |
| `plugin.manager.html_to_markdown_converter` | `HtmlToMarkdownConverterManager` | the converter plugin manager (see plugins doc). |
| `markdownify.supported_entities.config_form` | `SupportedEntitiesConfigForm` | builds the entity/bundle/language/view-mode subform embedded in the settings form. |

Programmatic conversion:

```php
$md = \Drupal::service('markdownify.entity_converter')
  ->convertEntityToMarkdown($node, 'full');
```

## Link template

`markdownify_entity_type_alter()` adds a **`markdownify`** link template
(`<canonical path>.md`) to every supported entity type that has a `canonical` template:

```php
$url = $node->toUrl('markdownify')->setAbsolute()->toString();  // e.g. /node/1.md
$has = $node->hasLinkTemplate('markdownify');                    // TRUE when supported
```

## Token

`markdownify_token_info_alter()` / `markdownify_tokens()` add
`[<entity_type>:markdownify-url]` (e.g. `[node:markdownify-url]`, `[taxonomy_term:markdownify-url]`)
for supported entity types — the absolute URL of the Markdown version.

## Response / negotiation internals

- `MarkdownResponse` — a `CacheableResponse` with `Content-Type: text/markdown; charset=utf-8`.
- `MarkdownifyServiceProvider` registers `text/markdown` as the `markdown` request format on
  core's negotiation middleware.
- `MarkdownifyNegotiationMiddleware` (http_middleware, prio 250) turns `Accept: text/markdown`
  into `?_format=markdown` **before** page cache, so cached HTML and Markdown never collide.
- `MarkdownRequestFormatRouteFilter` (route_filter, prio 100) sets the request format to
  `markdown`; `MarkdownifyPathProcessor` handles the `/markdownify/...` inbound prefix.
- `MarkdownifyEntityRoutesSubscriber` + `MarkdownifyVaryAcceptSubscriber` add `Vary: Accept`
  to supported canonical routes for safe proxy caching.
- `MarkdownifyNoIndexSubscriber` adds `X-Robots-Tag: noindex` to any `text/markdown`
  response when `markdownify.settings:noindex` is TRUE.

## Routes & access

Dynamic routes come from `MarkdownifyEntityRoutes::routes()` — per supported entity type it adds
`entity.<type>.markdownify` (`/markdownify/<canonical>`) and `entity.<type>.canonical_markdownify`
(the canonical path with `_format`/`_content_type_format` = `markdown`). Both carry
requirements `_entity_access: <type>.view`, `_entity_type: <type>`, and
`_markdownify_entity_access: <type>` — so the Markdown version always requires the entity's own
`view` access **and** that the type/bundle/language is enabled in `supported_entities`.
