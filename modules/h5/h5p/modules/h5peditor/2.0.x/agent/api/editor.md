# The H5P editor widget & endpoints

## Enable authoring on a field

The base `h5p` module's default widget is `h5p_upload` (upload a `.h5p` package). To let editors
author interactively, switch the H5P field's widget to **`h5p_editor`** on the bundle's *Manage form
display* (`/admin/structure/types/manage/<bundle>/form-display`), or in config:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$component = $fd->getComponent('field_interactive');   // an 'h5p' field
$component['type'] = 'h5p_editor';                      // was 'h5p_upload'
$fd->setComponent('field_interactive', $component)->save();
```

Read back which widget a field uses:

```php
$fd->getComponent('field_interactive')['type'];   // 'h5p_editor' or 'h5p_upload'
```

## AJAX endpoints (`H5PEditorAJAXController`)

All under `/h5peditor/{token}/{content_id}/…`, permission `access h5p editor`:

| Route | Path suffix | Purpose |
|---|---|---|
| `h5peditor.libraries` | `/libraries` | List available libraries |
| `h5peditor.content_type_cache` | `/content-type-cache` | The Hub content-type cache |
| `h5peditor.library_install` | `/library-install/{machine_name}` | Install a library from the Hub |
| `h5peditor.library_upload` | `/library-upload` | Upload a `.h5p` library |
| `h5peditor.library` | `/libraries/{machine_name}/{major}/{minor}` | One library's editor info |
| `h5peditor.files` | `/files` | Upload files used inside content |
| `h5peditor.translations` | `/translations/{language}` | Editor UI translations |
| `h5peditor.filter` | `/filter` | Filter/validate content |

## Permissions

| Permission | Gates |
|---|---|
| `access h5p editor` | Use the `h5p_editor` widget and its AJAX endpoints. |
| `install recommended h5p libraries` | Install only Hub-recommended content types (restricted). |
