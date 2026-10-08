# Builder service, RenderedContent & tokens

## `content_first.builder`

Service `content_first.builder`, class `ContentFirstBuilder`, interface
`Drupal\content_first\Builder\ContentFirstBuilderInterface`.

```php
/** @var \Drupal\content_first\Builder\ContentFirstBuilderInterface $builder */
$builder = \Drupal::service('content_first.builder');
$rendered = $builder->buildContent($entity, 'full'); // ?RenderedContent
```

- `buildContent(ContentEntityInterface $entity, string $view_mode): ?RenderedContent` — renders
  the entity through `entity_render_context.renderer`, strips `ignored_selectors`, and returns a
  `RenderedContent` (or `NULL` if it could not render). Works for any content entity.

## `RenderedContent` (`Drupal\content_first\RenderedContent`)

| Method | Returns |
|---|---|
| `getRawHtml(): string` | The rendered HTML before selector removal. |
| `getHtml(): string` | The cleaned HTML (selectors removed). |
| `getXpath(): \DOMXPath` | A DOMXPath over the cleaned HTML (used for heading/audit analysis). |
| `getMarkdown(bool $flattenProperties = FALSE): string` | Markdown (front matter per config; optionally flattened keys). |
| `getClean(): string` | Simplified HTML output. |
| `isEmpty(): bool` | Whether there is any content. |

Other services: `content_first.metatag_resolver` (`MetatagValueResolver`), `content_first.heading_analyzer`
(`HeadingAnalyzer` — `analyze()`/`buildTree()` over an H1–H6 nodelist), `content_first.filename_helper`
(`ContentFirstFilename`), `content_first.menu_markdown_builder`, `content_first.entity_architecture_exporter`.

## Tokens (`hook_token_info` / `hook_tokens`)

For every enabled node view mode the module registers two node tokens:

- `[node:content-first-markdown-<view_mode>]` → the node's Content First **Markdown** in that view mode.
- `[node:content-first-clean-<view_mode>]` → the node's Content First **simplified HTML**.

`content_first_tokens()` matches `content-first-(markdown|clean)-<view_mode>`, calls
`buildContent($node, $view_mode)`, and returns `getMarkdown()` / `getClean()`. Errors are logged and
the token resolves empty. Useful to embed clean content in emails, other fields, or LLM prompts.
