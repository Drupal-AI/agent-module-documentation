# The file delete operation

There is no settings form (`configure: null`). Everything is wired in code; the only thing
you "configure" is who gets the `delete any file` permission (see permissions doc).

## How it is wired (`file_delete_ui_entity_type_alter()`)

The module alters the core `file` entity type definition:

- `->setListBuilderClass(EntityListBuilder::class)` — so an `operations` field becomes
  available to Views' `EntityViewsData`.
- `->setLinkTemplate('delete-form', '/file/{file}/delete')` — gives file entities a
  `delete-form` link (used by the operations dropdown and `$file->toUrl('delete-form')`).
- `->setFormClass('delete', 'Drupal\file_delete_ui\Form\FileEntityDeleteForm')` — a thin
  `ContentEntityDeleteForm` subclass providing the confirm form.
- `->setAccessClass(FileAccessControlHandler::class)` — overrides file access so `delete` is
  actually grantable (see permissions doc).

## Route

`file_delete_ui.routing.yml`:

```yaml
entity.file.delete_form:
  path: /file/{file}/delete
  defaults:
    _entity_form: 'file.delete'
    _title: 'Delete file'
  requirements:
    _entity_access: 'file.delete'
  options:
    _admin_route: TRUE
```

So the delete confirm page is `/file/{FID}/delete`. `FileEntityDeleteForm::getCancelUrl()`
falls back to `file/{fid}` if the entity has no canonical URL.

## The Delete link in the admin Files view

`file_delete_ui_install()` edits the core `views.view.files` config in place, adding an
`operations` field (id `operations`, table `file_managed`) to the default display. That is
what makes the **Delete** operation appear at `/admin/content/files`. (Uninstalling the
module does not automatically remove that view field.)

## Delete a file programmatically

The module doesn't add an API; you use the standard entity API, which now has a delete route
and permissive access:

```php
$file = \Drupal\file\Entity\File::load($fid);
$file->delete();            // removes the file_managed record and the physical file
```

Or drive the confirm form by visiting `/file/{fid}/delete` as a user with access. Deletion
proceeds even if `file_usage` is non-zero — core strips the references from referencing
entities.

## Get a file's delete URL

```php
$url = $file->toUrl('delete-form')->toString();   // /file/{fid}/delete
```
