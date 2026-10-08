<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: parser, extension, allowed_html

The module defines three plugin types, each with its own manager. All live under
`src/Plugin/Markdown/` and use annotation plugins.

## 1. Parser (`plugin.manager.markdown.parser`)

- Manager `ParserManager`; annotation `@MarkdownParser`; interface `ParserInterface`
  (extensible parsers implement `ExtensibleParserInterface`). Base classes `BaseParser`,
  `BaseExtensibleParser`.
- A parser adapts an external Markdown library. Shipped adapters (installed ones show on this
  site): `commonmark`, `commonmark-gfm`, `parsedown`, `parsedown-extra`, `php-markdown`,
  `php-markdown-extra`. An unavailable library resolves to `_missing_parser`
  (`MissingParser`).
- Parsers are **installable plugins**: `isInstalled()` reflects whether the underlying
  Composer library is present.

Minimal custom parser:

```php
namespace Drupal\MYMODULE\Plugin\Markdown;

use Drupal\markdown\Plugin\Markdown\BaseParser;

/**
 * @MarkdownParser(
 *   id = "my_parser",
 *   label = @Translation("My Parser"),
 *   installed = "\\My\\Library\\Parser",
 * )
 */
class MyParser extends BaseParser {
  public function convertToHtml($markdown, $language = NULL) { /* ... */ }
}
```

## 2. Extension (`plugin.manager.markdown.extension`)

- Manager `ExtensionManager`; interface `ExtensionInterface`; base `BaseExtension`.
- Extensions add features to an **extensible** parser (e.g. CommonMark's tables, autolinks,
  strikethrough). They are enabled/configured per parser in the admin UI.
- Missing extensions resolve to `MissingExtension`.

## 3. Allowed HTML (`plugin.manager.markdown.allowed_html`)

- Manager `AllowedHtmlManager` (also aware of the filter plugin manager, theme handler/manager
  and the parser/extension managers); interface `AllowedHtmlInterface`.
- An `allowed_html` plugin **declares which HTML tags/attributes** a parser, module or theme
  contributes, feeding the filter's HTML restrictions / render strategy so valid output HTML
  is preserved and unsafe HTML is stripped.

## Info-alter hooks

`hook_markdown_parser_info_alter()`, `hook_markdown_extension_info_alter()`,
`hook_markdown_allowed_html_info_alter()` let you alter each plugin type's definitions (see
hooks/hooks.md).
