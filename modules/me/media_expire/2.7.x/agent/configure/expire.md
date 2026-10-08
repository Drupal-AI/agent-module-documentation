# Configure media expiry

No admin settings page. Expiry is turned on **per media type** from its edit form
`admin/structure/media/manage/{media_type}` — `media_expire_form_media_type_edit_form_alter()` injects an
"Expire configuration" fieldset.

## Fields on the media-type form

| Field | Stored as third-party setting | Notes |
|---|---|---|
| Activate media expire | `enable_expiring` (bool) | Master switch for the bundle. |
| Expire field | `expire_field` (field name) | Select of non-base `datetime` fields on the bundle; only shown if such a field exists. |
| Fallback \<type\> | `fallback_media` (media **UUID**) | Optional media of the same bundle rendered in place of expired items. |

If the bundle has no datetime field, the form shows a message telling you to add one first. The
`media_expire_media_type_form_builder` entity builder writes these onto the `media_type` config entity
(the fallback autocomplete resolves the selected media id to its UUID before saving).

### Set it with Drush / PHP

```php
$type = \Drupal::entityTypeManager()->getStorage('media_type')->load('image');
$type->setThirdPartySetting('media_expire', 'enable_expiring', TRUE);
$type->setThirdPartySetting('media_expire', 'expire_field', 'field_expire_date');
// Optional fallback (store the media UUID):
$fallback = \Drupal::entityTypeManager()->getStorage('media')->load(42);
$type->setThirdPartySetting('media_expire', 'fallback_media', $fallback->uuid());
$type->save();
```

## What happens at runtime

- **Expiry sweep** (`hook_cron` → `MediaExpireService::unpublishExpiredMedia()`): for each bundle with
  `enable_expiring`, it loads published media where `expire_field < now`, calls `setUnpublished()`,
  removes the expire field value, and saves. Trigger on demand with `drush media:expire-check`.
- **Fallback rendering** (`media_expire_media_build_defaults_alter`): when an **unpublished** media of an
  expiring bundle is built, its render array is replaced with the fallback media's render (or emptied if
  no fallback is set).
- **Access + routing**: `MediaExpireAccessControlHandler` (set via `hook_entity_type_alter`) grants
  `view` access to such unpublished media for users with *view media* when a fallback is configured; a
  `RouteSubscriber` repoints `entity.media.canonical` to `MediaViewController::view`.

## Config schema

`config/schema/media_expire.schema.yml` declares the third-party-settings schema for `media.type.*`
(`enable_expiring`, `expire_field`, `fallback_media`). No standalone config object.
