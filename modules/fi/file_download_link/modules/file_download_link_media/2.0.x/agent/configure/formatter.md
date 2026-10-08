# Configure the File Download Link Media formatter

Formatter plugin `file_download_link_media` (label "File Download Link"), field type
`entity_reference`. Set it on a Media reference field's **Manage display**; there is no settings
page.

## Applicability

`isApplicable()` returns TRUE only when:

- the reference field's `target_type` is `media`, **and**
- every referenced media type's source (`getSource()`) allows only `file` and/or `image` source
  field types.

So in the Manage-display UI it appears only for media references to file/image-backed media. (When
setting it directly in config, applicability is not re-checked.)

## Settings (`field.formatter.settings.file_download_link_media`)

Identical keys to the parent formatter:

| Key | Default | Effect |
|---|---|---|
| `link_text` | `"Download"` | Link text; empty → filename. |
| `link_title` | `null` | `title` attribute. |
| `aria_label` | `null` | `aria-label` attribute. |
| `new_tab` | `true` | `target="_blank"`. |
| `rel_attribute` | `""` | `rel` attribute. |
| `force_download` | `true` | HTML5 `download` attribute. |
| `force_download_filename` | `""` | Forced download filename. |
| `custom_classes` | `""` | Extra CSS classes. |

## How it renders

For each referenced media entity it locates the media's **source field** and renders it through
the parent `file_download_link` formatter:

```php
$media->{$source_field}->view([
  'type' => 'file_download_link',
  'label' => 'hidden',
  'settings' => $this->getSettings(),
]);
```

So the link, `download` attribute, classes (`file-download`, `file-download-<type>`,
`file-download-<ext>`) and Token behaviour are exactly the parent's.

## Set it in config / programmatically

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_media_doc', [
  'type' => 'file_download_link_media',
  'label' => 'hidden',
  'settings' => ['link_text' => 'Download', 'force_download' => true],
])->save();
```

Requires `media` and `file_download_link` enabled. Token replacement (file + media token types)
works when the `token` module is enabled.
