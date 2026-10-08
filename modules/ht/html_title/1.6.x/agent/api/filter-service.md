<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `html_title.filter` service

Service id **`html_title.filter`** → `Drupal\html_title\HtmlTitleFilter`
(constructor args: `@config.factory`, `@renderer`). This is the whole public API — the
module has no plugin types, no hooks of its own, no Drush.

```php
$filter = \Drupal::service('html_title.filter');

// Filtered plain text (string). Accepts a string OR a render array (rendered first).
$text = $filter->decodeToText($node->label());

// Same, wrapped in \Drupal\Core\Render\Markup so Twig/render won't re-escape it.
$markup = $filter->decodeToMarkup($node->label());

// The currently-allowed tag names, e.g. ['br','sub','sup'].
$tags = $filter->getAllowHtmlTags();
```

## What the methods do
- `decodeToText($str)` — if `$str` is an array it is rendered via `renderer->renderPlain()`,
  then `Html::decodeEntities()` converts entities to characters, then `filterXss()` runs a
  DOMDocument pass (escaping stray text nodes) followed by
  `Xss::filter($body, $this->getAllowHtmlTags())`. Returns a trimmed string containing only
  allowlisted tags.
- `decodeToMarkup($str)` — `Markup::create($this->decodeToText($str))`. Use this when placing
  a title into a render array / Twig so the safe markup is not double-escaped.
- `getAllowHtmlTags()` — reads `html_title.settings:allow_html_tags` and returns the parsed
  array of tag names.

## When you'd call it
- Rendering a node title yourself (custom controller, block, mail) and wanting the same
  markup treatment the module gives page titles.
- The module already applies this automatically to: the page title, `field__node__title`,
  breadcrumbs, search results, and the node create/update confirmation message; you only need
  the service for output paths the module doesn't already cover.

Security: `decodeToText()` always ends in `Xss::filter()` against the configured allowlist, so
output is safe to treat as markup — never bypass it by printing the raw stored title.
