<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HtmlPurifier — the strip-to-text configuration

Class `Drupal\entity_to_text\HtmlPurifier` (`src/HtmlPurifier.php`), service id
**`entity_to_text.htmlpurifier`**. Constructor arg: `@file_system`. Wraps the `ezyang/htmlpurifier`
library (`^4.14`). Reused by `NodeToText`, `ParagraphsToText`, and available to any caller.

## Methods

- `getHtmlPurifierConfig(): \HTMLPurifier_Config` — builds the default config:
  - Resolves `public://` realpath and a cache dir `public://HtmlPurifier` (constant
    `HTMLPURIFIER_CACHE_NAME`), created via `FileSystemInterface::prepareDirectory(...)`.
  - Writes a protective `.htaccess` on that cache dir with `FileSecurity::writeHtaccess()`.
  - Sets `Cache.SerializerPath` to that dir, `AutoFormat.RemoveEmpty = TRUE`,
    `HTML.AllowedElements = []`, and `CSS.AllowedProperties = []`.
  - The empty allow-lists mean **all tags and all CSS are removed** — the purifier is used as an
    HTML-to-plain-text flattener, not a sanitizing allow-list of safe HTML.
- `init(?\HTMLPurifier_Config $config = NULL): \HTMLPurifier` — returns a new `\HTMLPurifier`; uses the
  default config above unless one is passed in (so callers can override the config).

## Usage

```php
$purifier = \Drupal::service('entity_to_text.htmlpurifier')->init();
$plain = trim($purifier->purify($some_html));
```

Pass a custom `\HTMLPurifier_Config` to `init()` to keep specific tags if plain-text stripping is not
wanted.
