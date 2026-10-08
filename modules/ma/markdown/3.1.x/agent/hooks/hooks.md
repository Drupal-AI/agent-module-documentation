<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (`markdown.api.php`)

All hooks receive a `$context` array that may include `parser`
(`MarkdownParserInterface`), and optionally `filter` (`FilterInterface`), `format`
(`FilterFormat`) and `language`.

| Hook | Signature | Use |
|---|---|---|
| `hook_markdown_alter` | `(&$markdown, array $context)` | Alter the **raw Markdown string before parsing**. Docs warn this can be costly for bulk content; prefer a parser **extension** where possible. |
| `hook_markdown_html_alter` | `(&$html, array $context)` | Alter the **generated HTML after parsing**. Same performance caveat. |
| `hook_markdown_compatible_filters_alter` | `(array &$compatibleFilters)` | Mark a filter as (in)compatible with the Markdown filter — `$compatibleFilters[$filterId] = FALSE` to exclude. |
| `hook_markdown_parser_info_alter` | `(array &$info)` | Alter discovered **parser** plugin definitions. |
| `hook_markdown_extension_info_alter` | `(array &$info)` | Alter discovered **extension** plugin definitions. |
| `hook_markdown_allowed_html_info_alter` | `(array &$info)` | Alter discovered **allowed-HTML** plugin definitions. |

Example:

```php
function MYMODULE_markdown_html_alter(&$html, array $context) {
  // Post-process the rendered HTML (e.g. add rel="nofollow" to external links).
  $html = str_replace('<a href="http', '<a rel="nofollow" href="http', $html);
}
```

The two content-alter hooks (`markdown`/`html`) are best reserved for parsers that are **not**
extensible; for extensible parsers (CommonMark) write an extension plugin instead.
