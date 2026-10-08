# Field formatter — `file_download_all` ("Table of files with download all link")

`src/Plugin/Field/FieldFormatter/DownloadAllFormatter.php`, extends
`EntityReferenceFormatterBase`.

```php
@FieldFormatter(
  id = "file_download_all",
  label = @Translation("Table of files with download all link"),
  field_types = { "file", "image" }
)
```

Applies to core `file` and `image` fields. Set it on **Manage display** (`Structure → … → Manage
display`) for the field. There is no site-wide settings page — everything below is per field-display
component.

## Settings (`defaultSettings()` / `settingsForm()`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `link_title` | textfield (required) | `Download All` | Text of the "download all" link. |
| `use_description_as_link_text` | checkbox | `''` | Show each file's description instead of its filename when a description exists. |
| `details` | checkbox | `''` | Wrap the table in a `#type => details` disclosure. |
| `details_state` | checkbox | `''` | When `details` is on: unchecked = open, checked = closed. |
| `details_title` | textfield | `Download Files` | Title of the details wrapper. |
| `simple_theme` | checkbox | `''` | Minimal table: Name + a per-row icon download link (uses `file_url_generator` direct URLs), instead of the `file_link`/size table. |
| `link_position` | checkbox | `''` | Put the "download all" link in the table header row instead of above the table. |
| `link_icon` | checkbox | `''` | Render the link as the module's `downloadIcon.svg` image instead of text. |

`settingsSummary()` echoes the link text and any enabled options.

## Rendering (`viewElements`)

- Uses `getEntitiesToView($items, $langcode)` (entity-reference base) to resolve the referenced
  `file` entities, honouring display + access.
- Builds a `#theme => 'table__file_formatter_table'`; default rows are `['#theme' => 'file_link']`
  plus `ByteSizeMarkup::create($file->getSize())`; `simple_theme` rows use a direct
  `fileUrlGenerator->generate($uri)` link with a `download` attribute.
- The "download all" link points at
  `Url::fromRoute('download_all_files.download_path', ['entity_type' => $entity->getEntityTypeId(),
  'entity' => $entity->id(), 'field_name' => $items->getName()])` — see
  [../api/download.md](../api/download.md).
- Attaches library `download_all_files/theme`.

## Access (`checkAccess`)

Overrides the base to only enforce file view access when the file entity's access handler implements
`\Drupal\file\FileAccessFormatterControlHandlerInterface`; otherwise `AccessResult::allowed()`.
`needsEntityLoad()` additionally requires `$item->isDisplayed()`.
