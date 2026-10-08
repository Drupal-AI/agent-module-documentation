<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generator service & value objects (epub_generator)

The core API third-party code calls. Two services + two immutable value objects + two helpers.
All in `src/`.

## `EpubGeneratorService` (service id `epub_generator.generator`)

`src/EpubGeneratorService.php`. Constructor args (`epub_generator.services.yml`): `@file_system`,
`@config.factory`, `@logger.factory`, `@epub_generator.html_sanitizer`, `@extension.list.module`,
`%app.root%`, `@file.mime_type.guesser`, `@string_translation`.

Key methods:

- `generate(EpubMetadata $meta, EpubChapter[] $chapters, array $options = []): string`
  — builds the book and returns the path to a `.epub` written under
  `getTempDirectory() . '/epub_generator_' . uniqid()`. Steps: sort chapters by `sortWeight`;
  extract + resolve images across all chapters; merge strip selectors; `Epub::create()` with
  metadata, stylesheet, cover, embedded image resources, optional title page, TOC page (only when
  >1 chapter), and a nested chapter tree; `$epub->save($filepath)`.
- `generateDownloadResponse(EpubMetadata, EpubChapter[], array $options = []): BinaryFileResponse`
  — wraps `generate()`; sets `Content-Type: application/epub+zip`, attachment disposition, and
  `deleteFileAfterSend(TRUE)`.
- `isBundleEnabled(string $bundle, string $entityType = 'node'): bool` — TRUE when
  `enabled_bundles` is empty, else membership test on `"$entityType:$bundle"`.

`$options` keys: `stylesheet` (CSS string or file path), `generate_title_page` (bool, default TRUE),
`strip_selectors` (string[] added to the site-wide list, never replacing it).

Internals worth knowing:
- `buildMetadata()` maps to `PhpEpub\Metadata`: publisher falls back config → site name; language
  falls back config → `en`; adds default accessibility metadata; applies `fixedLayout()` when
  `layout === 'pre-paginated'`.
- `buildChapterTree()` / `buildChapterFromNode()` turn the flat `level`-tagged chapter list into a
  nested `PhpEpub\Chapter` tree; `buildPhpEpubChapter()` rewrites image `src` and runs the sanitizer.
- `resolveImagePath()` embeds **local images only** — it returns NULL for `http(s)://` sources
  (no remote fetch), strips query strings (`?itok=…`), and resolves stream wrappers (`public://`),
  `/system/files/…` → `private://`, docroot-absolute paths, and public-path substrings via
  `file_system->realpath()`. `resolveStylesheet()` reads a config/override CSS file or
  `assets/default.css`.
- Title page / TOC HTML is built with `htmlspecialchars(..., ENT_XML1 | ENT_QUOTES)`; the
  description block is run through the sanitizer.

## `EpubMetadata` (`src/EpubMetadata.php`)

`final readonly` value object. Constructor (named args): `title` (required), `language='en'`,
`identifier` (auto `urn:uuid:` v4 when NULL), `authors=[]`, `publisher=''`, `description=''`,
`rights=''`, `date` (default now), `coverImagePath=NULL`, `subjects=[]`, `isbn=''`, `subtitle=''`,
`edition=''`, `layout='reflowable'`, `viewportWidth`/`viewportHeight=NULL`, `spread='auto'`,
`orientation='auto'`.

## `EpubChapter` (`src/EpubChapter.php`)

`final` immutable. Constructor: `id` (sanitized), `title`, `htmlContent` (HTML fragment, no
`<html>`/`<body>`), `sortWeight=0`, `level=0`, `layout=NULL`, `viewportWidth`/`viewportHeight=NULL`.
`static sanitizeId(string, $fallback='chapter')` transliterates to `[a-z0-9-]`; `getFilename()` =
`"$id.xhtml"`.

## `HtmlToXhtmlSanitizer` (service `epub_generator.html_sanitizer`)

`src/HtmlToXhtmlSanitizer.php`. `sanitize(string $html, array $imageSrcMap = [], array $stripSelectors = []): string`
loads the fragment into `DOMDocument` and, in one pass: rewrites image `src`; strips comments;
removes `DISALLOWED_ELEMENTS` (`script`, `noscript`, `iframe`, `frame`, `frameset`, `embed`,
`applet`, `form`, `input`, `button`, `select`, `textarea`, `canvas`, `map`, `area`); removes Drupal
chrome (contextual links, tabs, shortcut/feed/toolbar markup, and `a` links to
`node/add|node/*/edit|delete|book/export|admin/`); removes site/book strip selectors; strips
`on*`, `data-*`, `loading`, and `style` (except inside `<svg>`/`<math>`). Returns the `<body>`
inner XHTML via `saveXML()`. `extractImageSources()` returns the `img` `src` set for the service to
resolve. **SVG and MathML are deliberately preserved.**

## `CssSelectorToXpath` (`src/CssSelectorToXpath.php`)

Static translator used by the strip-selectors feature and the settings-form validator. Supports
type/class/id/attribute selectors and descendant/child (`>`) combinators; rejects pseudo-classes and
sibling combinators (returns NULL → settings forms flag them). `splitList()` splits a textarea on
newlines/commas; `validateList()` returns untranslatable entries. An expression beginning with `/`,
`(` or `./` is passed through as raw XPath.
