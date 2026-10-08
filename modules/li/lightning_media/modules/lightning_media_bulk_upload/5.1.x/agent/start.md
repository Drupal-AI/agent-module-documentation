<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Media Upload (`lightning_media_bulk_upload`) — agent index

One form, one route. **No permissions of its own, no services, no settings form
(`configure` = null), no config schema, no Drush, no plugin types.**
Dependencies: `dropzonejs:dropzonejs` and `lightning_media:lightning_media`.

## The route — and its two-permission gate

```yaml
lightning_media.bulk_upload:
  path: '/admin/content/media/bulk-upload'
  defaults:
    _title: 'Bulk upload'
    _form: '\Drupal\lightning_media_bulk_upload\Form\BulkUploadForm'
  requirements:
    _permission: 'dropzone upload files,create media'
```

A **comma** in `_permission` means **AND**. A role with only `create media` (or only
`dropzone upload files`) gets 403. Both permissions come from other modules —
`dropzone upload files` from `dropzonejs`, `create media` from core `media`.

Action links (`lightning_media_bulk_upload.links.action.yml`) put a **Bulk upload** button on:

- `entity.media.collection` (`/admin/content/media`)
- `view.media_library.page`

## The form

`Drupal\lightning_media_bulk_upload\Form\BulkUploadForm` renders a `dropzonejs` element
whose accepted extensions come from
`\Drupal::service('lightning.media_helper')->getFileExtensions(TRUE)` — the union of the
source-field extensions of every media type the current user may create. On submit each file
is passed through `MediaHelper::createFromInput()` (input matching picks the bundle) and
`MediaHelper::useFile()` (moves the file into the bundle's upload location), then the editor
completes the remaining fields.

Consequence: **a file type that no installed media component claims cannot be bulk
uploaded**, and an extension claimed by two types raises `IndeterminateBundleException`.

## Install / update hooks

- `hook_install()` → `user_role_grant_permissions('media_creator', ['dropzone upload files'])`
  (silently does nothing useful if `lightning_roles` never created that role).
- `lightning_media_bulk_upload_update_9001()` → downloads Dropzone 5.7.3 into
  `<docroot>/libraries/dropzone` when `library.libraries_directory_file_finder` cannot find it.

## Recipes

```bash
# who can actually use the form?
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("user_role")->loadMultiple() as $r) {
    $ok = $r->hasPermission("dropzone upload files") && $r->hasPermission("create media");
    if ($ok || $r->isAdmin()) { print $r->id() . "\n"; }
  }
'

# grant it to a role
drush role:perm:add my_editor 'dropzone upload files'
drush role:perm:add my_editor 'create media'

# check route access for a specific account
drush php:eval '
  $u = user_load_by_name("someuser");
  var_dump(\Drupal::service("access_manager")->checkNamedRoute("lightning_media.bulk_upload", [], $u));
'
```

Parent module API (`MediaHelper`, input matching):
[`../../../../5.1.x/agent/api/media-helper.md`](../../../../5.1.x/agent/api/media-helper.md).
