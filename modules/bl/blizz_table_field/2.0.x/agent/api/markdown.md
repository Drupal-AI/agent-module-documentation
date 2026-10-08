<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cell Markdown pipeline & the `MarkdownExtension` plugin type

Every formatted cell (and header cell) passes through the `markdown_extension.markdown` service
unless the formatter's `skip_rendering_markdown` is on. This is how cells get emphasis, links,
alignment, and Media references — authors write **Markdown, not HTML**.

## The service — `MarkdownExtension` (`src/MarkdownExtension.php`)

Implements `MarkdownInterface::convertToHtml($commonMark)`. Wraps
`League\CommonMark\CommonMarkConverter` constructed with `['html_input' => 'strip',
'allow_unsafe_links' => FALSE]` — inline raw HTML is stripped and unsafe link schemes are dropped by
CommonMark. Around the conversion it dispatches two events on `@event_dispatcher`:

- `MarkdownEvents::PRE_TEXT_CHANGE` — before `->convert()`.
- `MarkdownEvents::POST_TEXT_CHANGE` — after `->convert()`.

The text flows through a mutable `TextToChangeEvent` (`src/Event/TextToChangeEvent.php`,
`addText()` / `getLatestText()`); `convertToHtml()` returns a plain HTML **string**, which the
formatter places in a render `#markup` key.

## Event subscribers (`blizz_table_field.services.yml`)

| Service | Event / priority | Effect |
|---|---|---|
| `ExtendedMarkdown` | PRE, 20 | Runs the `MarkdownExtension` plugins against `[text](ref)` / `![alt](ref)` matches (regex `MARKDOWN_REGEX`) to rewrite Media-ID refs into real URLs before CommonMark converts. |
| `AlignmentListener` | POST, 30 | If the cell starts (within the first 10 chars) with `^c `, `^r ` or `^l `, strips the marker and wraps output in `<div class="cell-align-center|right|left">`. |
| `FilterUrlListener` | POST, 20 | Runs core `_filter_url()` (via a `FilterUrl` plugin instance, url length 72) to linkify bare URLs. |
| `TargetBlankListener` | POST, 10 | `str_replace('href=', 'target="_blank" href=', ...)` so generated links open in a new tab. |

## The `MarkdownExtension` plugin type

- **Manager** `plugin.manager.markdown_extension` = `MarkdownExtensionManager`
  (`parent: default_plugin_manager`), discovering plugins in `Plugin/MarkdownExtension`, interface
  `MarkdownExtensionInterface`, annotation `@MarkdownExtension` (`src/Annotation/MarkdownExtension.php`),
  alter hook `markdown_extension_info`.
- **Interface** `MarkdownExtensionInterface`: `findMatch($markdown)` (bool — does this plugin apply)
  and `replaceFiles($commonMark, $matches)` (return rewritten text).

### Bundled plugins

- **`image_markdown_extension`** (`ImageMarkdownExtension`) — for `![alt](ID)` (matches on `!`).
  `imageUrl($mediaId, $imageStyle='thumbnail')`: loads a **Media** entity by numeric ID, reads its
  `field_image_file` target file, and builds an `ImageStyle::buildUrl()` URL (falls back to the
  `thumbnail` style). Syntax `![alt](ID, style_machine_name)`. Non-numeric IDs and load failures are
  ignored; malformed tags are logged.
- **`file_markdown_extension`** (`FileMarkdownExtension`) — for `[text](ID)` links (regex
  `/\[.*?\]\(([0-9]*?)\)/`). `fileLink($mediaId)`: loads the Media entity, and when it has a
  `field_file` (and no `field_image_file`), resolves the file to an absolute URL via
  `file_url_generator`. Returns the URL to substitute into the link target.

Both require the **Media** module and Media bundles with `field_image_file` / `field_file` fields to
resolve refs; otherwise the raw `[text](ID)` / `![alt](ID)` is left as-is.

## Adding your own extension

Create a plugin class in `src/Plugin/MarkdownExtension/` of your module implementing
`MarkdownExtensionInterface` with an `@MarkdownExtension(id=..., title=..., description=...)`
annotation. It is auto-discovered by the manager and invoked from `ExtendedMarkdown::onTextChangePre()`
for every cell whose text matches the link/image regex.

## Alignment / formatting reference (author-facing)

`^c ` centre, `^r ` right, `^l ` left (note the required trailing space); standard CommonMark for
bold/emphasis/lists/links; `![alt](ID, style)` for a Media image; `[text](ID)` for a Media file link.
The default `formatting_options` help text (config) documents this to editors.
