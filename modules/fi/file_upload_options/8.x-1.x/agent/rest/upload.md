<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST file:upload override

`hook_rest_resource_alter()` (`file_upload_options.module`) replaces core's `file:upload` REST
resource class with
`\Drupal\file_upload_options\Plugin\rest\resource\FileUploadOptionsResource`
(`src/Plugin/rest/resource/FileUploadOptionsResource.php`), a subclass of core
`Drupal\file\Plugin\rest\resource\FileUploadResource`.

```php
function file_upload_options_rest_resource_alter(&$definitions) {
  if (isset($definitions['file:upload'])) {
    $definitions['file:upload']['class'] = 'Drupal\file_upload_options\Plugin\rest\resource\FileUploadOptionsResource';
  }
}
```

## What the override changes

The subclass overrides only `post(Request $request, $entity_type_id, $bundle, $field_name)`. It is a
copy of core's `post()` with the file-exists handling made configurable:

1. Reads `upload_option.<entity_type>.<bundle>.<field_name>` from `file_upload_options.settings`.
2. Filename comes from the `Content-Disposition` header, sanitised via core
   `validateAndParseContentDispositionHeader()` + `prepareFilename($filename, $validators)`.
   Destination comes from the **field's own settings** (`getUploadLocation($field_definition->getSettings())`),
   not from the request.
3. Applies the configured replace value: if `$replace > -1`, calls
   `getDestinationFilename($file_uri, $replace)` and `fileSystem->move($temp, $file_uri, $replace)`;
   otherwise falls back to `EXISTS_RENAME` (core behaviour). `EXISTS_REPLACE = 1`,
   `EXISTS_ERROR = 2`, `EXISTS_RENAME = 0`, `-1` = current behaviour.
4. **On Replace** (`$replace == EXISTS_REPLACE`): if a file entity already exists with the same
   target URI (`loadByProperties(['uri' => $file_uri])`), it re-uses that entity and marks it
   permanent instead of creating a new `File` entity — so the same fid/URI is preserved and its
   bytes are overwritten. Otherwise a new `File` entity is created as in core.
5. Standard core validation (`validate($file, $validators)`) and write-locking are preserved.

## Access / requirements

Unchanged from core `file:upload`: the resource must be enabled, and the caller needs the field
edit access plus the REST resource permission core requires for `file:upload`. The module adds no
new REST permission and does not weaken core's field-level access or validator checks.

## Notes

- The replace *option* is chosen by an admin per field on the settings form; a REST caller cannot
  select it in the request. A caller can only trigger whatever the field is already configured to do.
- Validators (including extension validation) are the field's own via
  `getUploadValidators($field_definition)` — the override does not remove or broaden them.
