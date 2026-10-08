<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — who can bulk-upload

The module provides **dynamic, per-media-type** permissions (via
`MediaLibraryBulkUploadPermissions::getPermissions`, a `permission_callbacks` in
`media_library_bulk_upload.permissions.yml`). One permission is generated per media type:

```
use media {media_type_id} bulk upload form
```

Examples on a stock install: `use media image bulk upload form`,
`use media document bulk upload form`, `use media video bulk upload form`,
`use media audio bulk upload form`, `use media remote_video bulk upload form`.
Create a new media type → a matching permission appears automatically.

## Access logic

- **`administer media`** (core) is a super-permission: `accessList()` grants the landing page outright to anyone with it, and it also gates the settings form.
- The **landing page** (`accessList`) is allowed if the user has `administer media` **or** the `use media {type} bulk upload form` permission for **any** media type (OR-ed across all types).
- A **specific type's form** (`accessForm`) requires the matching `use media {type} bulk upload form` permission — and additionally the type must not be excluded by the `media_types` restriction (see [../configure/settings.md](../configure/settings.md)); an excluded type is forbidden regardless of permission.
- Note: the internal Media Library **opener** (`MediaLibraryBulkUploadOpener::checkAccess`) currently returns `AccessResult::allowed()` (a `@todo` for real checks); route-level access is what actually protects the feature.

## Grant with drush

```bash
# Let the content_editor role bulk-upload Image media
drush role:perm:add content_editor 'use media image bulk upload form'

# Remove it
drush role:perm:remove content_editor 'use media image bulk upload form'
```

Give a role several `use media {type} bulk upload form` permissions to let it bulk-upload
multiple types; combine with the `media_types` setting to cap what is offered site-wide.
