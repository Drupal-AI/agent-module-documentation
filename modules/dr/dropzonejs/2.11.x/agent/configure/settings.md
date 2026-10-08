# Settings & the `dropzonejs` form element

## Global settings — `dropzonejs.settings`

Config object (schema `config/schema/dropzonejs.schema.yml`). There is **no dedicated
admin form**; the one editable key is exposed on the core file-system settings form
(`/admin/config/media/file-system`). Read/write with drush.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `tmp_upload_scheme` | string | `temporary` | Stream wrapper incoming uploads are streamed into. |
| `filename_transliteration` | bool | `false` | Legacy, deprecated. Hardcoded ASCII transliteration of filenames (D<10.2). Prefer core's site-wide transliteration. |
| `upload_timeout_ms` | int | `0` | Per-file upload timeout passed to DropzoneJS (0 = library default). |

```
drush config:set dropzonejs.settings tmp_upload_scheme private -y
drush config:set dropzonejs.settings upload_timeout_ms 60000 -y
```

## Placing the form element (`#type => 'dropzonejs'`)

Add the element to any form. On submit its value is
`['uploaded_files' => [['path' => 'temporary://…', 'filename' => '…'], …]]` — temporary
files the caller must turn into permanent `file` entities (see
[../api/services.md](../api/services.md)).

```php
$form['upload'] = [
  '#type' => 'dropzonejs',
  '#title' => $this->t('Upload'),
  '#dropzone_description' => $this->t('Drop files here to upload'),
  '#max_filesize' => '8M',          // human size string
  '#extensions' => 'png jpg pdf',   // space-separated
  '#max_files' => 5,                // 0/empty = unlimited
  '#clientside_resize' => FALSE,    // TRUE needs the exif-js library
];
```

Client-side resize adds these optional keys: `#resize_width`, `#resize_height`,
`#resize_quality` (0–1), `#resize_method` / `#thumbnail_method` (`contain` | `crop`).
The element attaches `dropzonejs/integration` + `dropzonejs/widget` and requires the
`dropzone upload files` permission (hidden and warns otherwise).

## Library

The actual DropzoneJS JS/CSS must live in `libraries/dropzone/` (Composer package
`enyo/dropzone`, or manual). `hook_library_info_alter` auto-detects Dropzone 5 or 6 file
layouts; `hook_library_info_build` registers `dropzonejs/exif-js` if `libraries/exif-js`
is present (enables client-side resize).
