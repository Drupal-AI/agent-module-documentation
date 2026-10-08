# Permissions & access

## Generated permissions (per media type)

`media_bulk_zip_upload.permissions.yml` contains **only** a `permission_callbacks` entry:

```yaml
permission_callbacks:
  - \Drupal\media_bulk_zip_upload\MediaBulkZipUploadPermissions::permissions
```

`MediaBulkZipUploadPermissions::permissions()` loops over every `MediaType` and emits one
permission each, so the literal strings never appear in YAML — read the class, not the file.

| Permission (machine name) | Title | Notes |
|---|---|---|
| `use media bulk zip upload for {media_type_id}` | `{Type label}: Use media bulk zip upload form` | One per media type (e.g. `use media bulk zip upload for image`). |
| `administer media` (core) | — | Gates the settings route `media_bulk_zip_upload.settings`. |

## Upload-form access model

Route `media_bulk_zip_upload.form` uses `_custom_access:
MediaBulkZipUploadForm::checkAccess`, which grants access only when **all** hold:

1. the requested media type id is present in `media_bulk_zip_upload.settings:media_types`
   (otherwise `AccessResult::forbidden(...)`), and
2. the account has `use media bulk zip upload for {media_type_id}`, **and**
3. core media create access for that bundle —
   `entityTypeManager->getAccessControlHandler('media')->createAccess($type, $account, [], TRUE)`.

```php
return AccessResult::allowedIfHasPermission($account, "use media bulk zip upload for {$type}")
  ->andIf($createAccess)
  ->addCacheableDependency($config);
```

So the per-type permission alone is not enough — the user must also be able to create that media
type through normal core access, and the type must be opted in. This is why access is a custom
callback rather than a flat permission requirement. None of these permissions are granted to
anonymous by default; grant the per-type permission (and create access) only to trusted
editorial roles.
