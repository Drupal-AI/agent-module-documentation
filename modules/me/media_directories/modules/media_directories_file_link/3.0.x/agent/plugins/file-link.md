<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The file-link button and filter

## CKEditor 5 plugin — `media_directories_file_link_button`

`media_directories_file_link.ckeditor5.yml`:

```yaml
media_directories_file_link_button:
  ckeditor5:
    plugins: [mediaFileLinkButton.MediaFileLinkButton]
    config:
      mediaFileLinkButton:
        allowedBundles: []
  drupal:
    label: Media file link button
    library: media_directories_file_link/media_file_link_button
    admin_library: media_directories_file_link/media_file_link_button.admin
    class: Drupal\media_directories_file_link\Plugin\CKEditor5Plugin\MediaFileLinkButton
    toolbar_items:
      mediaFileLinkButton:
        label: Insert file link
    elements:
      - <drupal-media-file-link data-entity-uuid data-entity-type data-file-type>
    conditions:
      filter: media_directories_file_link
```

`MediaFileLinkButton::getDynamicPluginConfig()` sets:
- `mediaFileLinkButton.allowedBundles` = `MediaTypeService::getFileBasedBundles()` (only
  media types with a real file), and
- an `icon` flag mirrored from the paired filter's `icon` setting on the same format, so the
  editor widget matches the rendered output.

Config schema: `ckeditor5.plugin.media_directories_file_link_button` with `allowedBundles`
(`FullyValidatable`).

## Filter — `media_directories_file_link`

```
id: media_directories_file_link
title: "Media file link"
type: TYPE_TRANSFORM_REVERSIBLE
weight: 95
settings:
  template: '<a href="@file_url">@text</a>'
  icon: TRUE
```

Schema: `filter_settings.media_directories_file_link` → `template` (string), `icon` (bool).

`process()`:

1. Return unchanged unless the text contains `<drupal-media-file-link`.
2. XPath `//drupal-media-file-link[@data-entity-uuid]`; the nodes are collected into an array
   first (mutating a live `DOMNodeList` skips nodes).
3. Per node: `$uuid = data-entity-uuid`, `$linkText = trim($node->textContent)`; skip when
   the uuid is empty.
4. Load media by uuid (`loadByProperties(['uuid' => $uuid])`).
   - **Media missing** → replace the node with a text node containing `$linkText`.
   - **`$media->access('view')` false** → same plain-text fallback (no URL leak).
5. `addCacheableDependency($media)`; switch to `$media->getTranslation($langcode)` when it
   exists.
6. Resolve the file from the media source's `source_field`; when present,
   `$fileUrl = fileUrlGenerator->generateAbsoluteString($file->getFileUri())` and
   `addCacheableDependency($file)`.
7. Build the tokens and `strtr()` them into the template:

   | Token | Value |
   |---|---|
   | `@file_url` | absolute file URL, through `UrlHelper::stripDangerousProtocols()` |
   | `@text` | `Html::escape($linkText ?: $media->label())` |
   | `@name` | `Html::escape($media->label())` |
   | `@uuid` | escaped uuid |
   | `@mime` | escaped MIME type (`''` with no file) |
   | `@size` | escaped `ByteSizeMarkup::create($file->getSize())` |
   | `@file_type` | escaped category from `getFileTypeForMimeType()` |

8. Wrap the rendered fragment in `<span class="media-file-link">`; when `icon` is on, also set
   `data-file-type="{category}"` on that wrapper.
9. If any link rendered, attach the library
   `media_directories_file_link/media_file_link_frontend`.

`getFileTypeForMimeType(string $mime): string` — a public static that buckets MIME types:

| Category | Rule |
|---|---|
| `image` / `audio` / `video` | top-level MIME type |
| `spreadsheet` | `vnd.ms-excel`, `…spreadsheetml.sheet`, `…opendocument.spreadsheet`, `csv` |
| `archive` | `zip`, `gzip`, `x-gzip`, `x-tar`, `x-rar-compressed`, `x-7z-compressed`, `x-bzip2`, `vnd.rar` |
| `code` | `javascript`, `json`, `xml`, `x-httpd-php`, `x-sh`, `x-python`, `typescript`, `css`, `html`, `xhtml+xml` |
| `text` / `file` | remaining text types / everything else |

## Enabling on a text format

```bash
drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;

  $id = "full_html";
  $f = FilterFormat::load($id);
  $f->setFilterConfig("media_directories_file_link", [
    "status" => TRUE, "weight" => 90,
    "settings" => [
      "template" => "<a href=\"@file_url\" download>@text <span class=\"size\">(@size)</span></a>",
      "icon" => TRUE,
    ],
  ]);
  $f->save();

  $e = Editor::load($id);
  $s = $e->getSettings();
  if (!in_array("mediaFileLinkButton", $s["toolbar"]["items"], TRUE)) {
    $s["toolbar"]["items"][] = "mediaFileLinkButton";
  }
  $e->setSettings($s)->save();'
```

`filter_html`, if enabled, must allow
`<drupal-media-file-link data-entity-uuid data-entity-type data-file-type>` — enabling the
CKEditor plugin adds it automatically via the `elements:` declaration.

## Try it live

```bash
drush php:eval '
  $f = \Drupal\filter\Entity\FilterFormat::load("full_html");
  $p = $f->filters()->get("media_directories_file_link");
  $uuid = "…";  // a file-based media uuid
  print $p->process("<p><drupal-media-file-link data-entity-uuid=\"$uuid\">Report</drupal-media-file-link></p>", "en")
    ->getProcessedText() . "\n";'
```

Expected shape:
`<p><span class="media-file-link" data-file-type="image"><a href="http://…/file.png">Report</a></span></p>`.

## Not provided

No settings form, no config object, no permissions, no services, no hooks, no routes, no
Drush commands. Files: `*.info.yml`, `*.ckeditor5.yml`, `*.libraries.yml`, the schema, three
CSS files, one built JS bundle, the two plugin classes and two kernel tests.
