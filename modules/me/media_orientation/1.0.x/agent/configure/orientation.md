<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure orientation on a media type

There is **no module settings page and no `configure` route**. Orientation is enabled per media
type by pointing the module at a List (integer) field via a **third-party setting**.

## Prerequisites (per media type)
1. The media type's source plugin must be **`image`**. Non-image bundles are ignored entirely.
2. Add a field of type **List (integer)** (`list_integer`) to that media type, e.g. with allowed values:
   ```
   1|Landscape
   2|Portrait
   3|Square
   ```
   It must be a real (non-base) field. A plain Number (integer) or text field is **not** accepted —
   the presave handler only writes to `list_integer` fields.

## Enable via UI
On the media type edit form (`/admin/structure/media/manage/<bundle>`) the module injects an
**"Orientation"** details group (only for image bundles). Pick your List (integer) field in the
**Orientation** select, or leave `- Skip field -` to disable. If the bundle has no List (integer)
field yet, the group shows a message telling you to add one first.

Injected by `media_orientation_form_media_type_edit_form_alter()`; the choice is saved as a
third-party setting by the entity builder `media_orientation_media_type_form_builder()`.

## The third-party setting
- Provider: `media_orientation`
- Key: `orientation`
- Value: the machine name of the target `list_integer` field (or `_none` / empty = skip).
- Stored on the `media.type.<bundle>` config entity.

Set it with drush + PHP eval (replace `image` and `field_orientation`):
```php
$type = \Drupal::entityTypeManager()->getStorage('media_type')->load('image');
$type->setThirdPartySetting('media_orientation', 'orientation', 'field_orientation');
$type->save();
```
Read it back:
```php
$field = $type->getThirdPartySettings('media_orientation')['orientation'] ?? NULL;
```

> Note: the module ships **no `config/schema`** for this third-party setting. It works, but the
> key is unschema'd config.

## What happens at runtime
`hook_ENTITY_TYPE_presave()` (`media_orientation_media_presave`) runs on every media save and calls
`OrientationHelper::saveMediaEntityOrientation()`, which:
1. Loads the media type config entity; returns early unless the source plugin id is `image`.
2. Reads the `orientation` third-party setting; returns if empty.
3. Confirms the target field's type is `list_integer`; returns otherwise.
4. Reads the source image field's `target_id`, loads the `File`, resolves its real path.
5. Calls PHP `getimagesize()` and compares width/height: `width > height` → 1 (Landscape),
   `width == height` → 3 (Square), else → 2 (Portrait).
6. Sets that value on the target field. (Runs during presave, so it is persisted with the entity.)

Because detection happens on save, changing the setting or editing an image re-computes orientation
on the next save. To apply it to media that already exist, use the resave command in
[../drush/commands.md](../drush/commands.md).

Displaying the stored value: an exposed Views filter on a `list_integer` field is automatically a
select of the allowed values, and you can render the number as a word with the formatter/widget in
[../fields/display.md](../fields/display.md).
