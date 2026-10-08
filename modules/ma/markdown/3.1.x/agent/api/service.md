<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: the `markdown` service & Twig

## Service `markdown` (`Drupal\markdown\Markdown`)

Constructor deps: `@cache.markdown`, `@config.factory`, `@file_system`, `@http_client`,
`@plugin.manager.markdown.parser`. Methods (`MarkdownInterface`):

| Method | Purpose |
|---|---|
| `parse($markdown, ?LanguageInterface $language = NULL)` | Parse a Markdown **string**; returns a `ParsedMarkdownInterface` (stringifies to HTML). |
| `getParser($parserId = NULL, array $configuration = [])` | Get a parser plugin instance (default parser if id omitted). |
| `loadFile($path, $id = NULL, ?LanguageInterface $language = NULL)` | Parse a Markdown **file** (throws `MarkdownFileNotExistsException` if missing); cached by id. |
| `loadUrl($url, $id = NULL, ?LanguageInterface $language = NULL)` | Fetch + parse a **URL** (throws `MarkdownUrlNotExistsException`); cached. |
| `load($id)` | Return previously cached `ParsedMarkdown` by id (or NULL). |
| `save($id, ParsedMarkdownInterface $parsed)` | Store a parsed result in the `markdown` cache bin. |

Example:

```php
$markdown = \Drupal::service('markdown');
$html = (string) $markdown->parse("# Title\n\nSome **bold** text.");

// Specific parser:
$parser = $markdown->getParser('commonmark-gfm');

// Render a file (e.g. a module README), cached:
$readme = (string) $markdown->loadFile(DRUPAL_ROOT . '/modules/contrib/foo/README.md');
```

`ParsedMarkdown` objects are renderable/cacheable; cast to string (or render) for the HTML.
Results are cached in the dedicated `cache.markdown` bin (chainedfast backend).

## Twig

The module registers a Twig extension (`twig.extension.markdown`) named `markdown`:

- Filter: `{{ some_variable|markdown }}`
- Function: `{{ markdown(some_variable) }}`

Both call `Markdown::parse()` and are marked `is_safe: html`. Use them in templates to render
Markdown stored in a variable.

## Param converter

`markdown:parser` (service `paramconverter.markdown`, priority 10) upcasts a `{parser}` route
slug to a parser plugin instance — used by the admin parser routes.
