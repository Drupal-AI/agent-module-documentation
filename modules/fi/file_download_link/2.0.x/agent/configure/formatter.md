# Configure the File Download Link formatter

Formatter plugin `file_download_link` (label "File Download Link"), field types `file` and
`image`. There is no settings page — set it on a field's **Manage display**
(`/admin/structure/types/manage/<bundle>/display`) or in the entity view display config.

## Settings (`field.formatter.settings.file_download_link`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `link_text` | label | `"Download"` | Link text; empty → the filename is used. |
| `link_title` | label | `null` | `title` attribute (tooltip). |
| `aria_label` | label | `null` | `aria-label` attribute. |
| `new_tab` | boolean | `true` | Adds `target="_blank"`. |
| `rel_attribute` | string | `""` | `rel` attribute (e.g. `noopener noreferrer`). |
| `force_download` | boolean | `true` | Adds the HTML5 `download` attribute. |
| `force_download_filename` | string | `""` | Value for the `download` attribute (a forced filename). |
| `custom_classes` | string | `""` | Space-separated extra CSS classes (cleaned, appended). |

Every link also gets automatic classes: `file-download`, `file-download-<mime-group>` (e.g.
`file-download-image`), and `file-download-<extension>` (from the file MIME type).

## Set it in config / programmatically

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_attachment', [
  'type' => 'file_download_link',
  'label' => 'hidden',
  'settings' => [
    'link_text' => 'Download the report',
    'new_tab' => true,
    'force_download' => true,
    'force_download_filename' => '',
    'custom_classes' => 'button button--primary',
  ],
])->save();
```

```bash
drush cget core.entity_view_display.node.article.default content.field_attachment
```

## Token support (optional, module `token`)

When Token is enabled, `link_text`, `link_title`, `aria_label`, `force_download_filename`, and
`custom_classes` are passed through `Token::replace()` with the **file** entity and the **host**
entity as data. The field's delta is auto-inserted into field tokens, so multi-value fields work.
Example link text: `[node:field_attachment:description] ([file:size])`. Without Token the settings
form shows a hint recommending it (plain strings still work).

## Notes

- The link points at the file URL from `file_url_generator`; stored values/formatters are
  untouched — this only changes display.
- For **Media reference** fields, use the submodule `file_download_link_media` (formatter
  `file_download_link_media`), which delegates to this formatter on the media's source field.
