# Configure: allowed MIME types per category

Config object: `file_mime_validator.settings`
(schema `config/schema/file_mime_validator.schema.yml`, defaults
`config/install/file_mime_validator.settings.yml`). Editable via the settings form
(class `Drupal\file_mime_validator\Form\FileTypesMimeConfig`, route
`file_mime_validator.file_types_mime_config_form`, path
`/admin/config/system/file-mime-validator/file-types-mime-config`, menu link under
`system.admin_config_system`). The route requires the `administer` permission — core grants
this to no role by default — so setting the values with drush or PHP is the reliable path.

Each key holds a single string: a comma-separated list of MIME types (no spaces) that belong to
that category. The validator sorts every upload into one of these five categories and compares
the category implied by the filename against the category detected from the file's content
(see [../api/validator-service.md](../api/validator-service.md)).

| Config key | Category | Schema type | Form widget |
|---|---|---|---|
| `file_mime_validator_text` | text | string | textarea, required |
| `file_mime_validator_image` | image | string | textarea, required |
| `file_mime_validator_compression` | compression | string | textarea, required |
| `file_mime_validator_audio` | audio | string | textarea, required |
| `file_mime_validator_video` | video | string | textarea, required |

Each key ships with a large default list, e.g.
`file_mime_validator_image` includes `image/png,image/jpeg,image/gif,image/webp,image/bmp,...`;
`file_mime_validator_compression` includes `application/zip,application/x-rar,application/vnd.rar,...`;
`file_mime_validator_text` includes `text/plain,text/html,text/css,text/csv,application/pdf,...`.
A MIME type that appears in none of the five lists is classified as `no file type found`.

Set one category with drush:

```
drush cset file_mime_validator.settings file_mime_validator_image "image/png,image/jpeg,image/gif,image/webp" -y
```

Set with PHP:

```php
\Drupal::configFactory()
  ->getEditable('file_mime_validator.settings')
  ->set('file_mime_validator_image', 'image/png,image/jpeg,image/gif,image/webp')
  ->save();
```

The form's `submitForm()` writes all five keys and then calls `drupal_flush_all_caches()`, so a
UI save clears every cache. Read a value with `drush cget file_mime_validator.settings file_mime_validator_image`.
