<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Direct Download field formatter

`DirectDownloadFormatter` (id `direct_download`, extends core `FileFormatterBase`) is the only
user-facing feature. It applies to **`file`** field types (not `image`). For each referenced file it
renders a link to `/download/file/{fid}` instead of the file's own URL, so clicking it triggers a
forced download (see [api/download-route.md](../api/download-route.md)).

## Enable it on a display

Manage Display for the entity/view mode, set the file field's format to **Direct Download**. Via
config/drush:

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_attachment.type direct_download -y
drush cr
```

It also appears in the Views field "Format" select for file fields.

## Settings

`defaultSettings()` adds two keys on top of `FileFormatterBase`:

| Key | Type | Meaning |
|---|---|---|
| `class` | textfield | CSS class(es) put on the wrapping `<span>`. |
| `styles` | textfield | Inline `style` attribute on the wrapping `<span>`. |

Both are run through `Xss::filterAdmin()` in `viewElements()` before rendering.

## Render output (per file)

`viewElements()` builds, for each file in `getEntitiesToView()`:

- `#theme => 'direct_download_file_link'`
- `#link_text` = the field item `description` if set, else `$file->getFilename()`
- `#url` = `Url::fromRoute('download_file.download_file_path', ['file' => $file->id()])`
- `#file_id` = the file id
- `#attributes` = `class`/`style` from settings (plus any `$item->_attributes`)
- `#cache['tags']` = `$file->getCacheTags()`

## Theming

Theme hook `direct_download_file_link` (template
`templates/direct-download-file-link.html.twig`) renders `<span{{ attributes }}>{{ link }} </span>`.
`template_preprocess_direct_download_file_link()` builds `link` with
`Link::fromTextAndUrl($link_text, $url)`. Override the template or preprocess to change the markup;
variables available: `attributes`, `link` (and the raw `file_id`, `link_text`, `url`).
