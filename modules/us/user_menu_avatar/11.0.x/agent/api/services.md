<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the `umas` service

Service id **`umas`** → `Drupal\user_menu_avatar\Services\UserMenuAvatarServices`
(`user_menu_avatar.services.yml`).

Constructor arguments: `@entity_type.manager`, `@file_url_generator`, `@current_user`,
`@entity.repository`.

```php
$umas = \Drupal::service('umas');
```

## Methods

### `getCurrentUser(): array`
Returns info about the **current session user** (always the current user — it loads the user
entity by `\Drupal::currentUser()->id()`; it cannot be pointed at another account):

| Key | Type |
|-----|------|
| `currentUser` | `AccountProxyInterface` |
| `currentUserEntity` | loaded `user` entity (or `null` for uid 0 in some setups) |
| `displayName` | string (`getDisplayName()`) |
| `isAnonymous` | bool |
| `isAuthenticated` | bool |

### `getFieldImage($field = NULL, $imageStyle = NULL): ?string`
Given an **image** field item list and an image style machine name, returns a root-relative URL
(`FileUrlGenerator::transformRelative()`), or `NULL`.

- If the field references a file, that file's URI is used; the image style is applied unless the
  MIME type is `image/svg+xml` (SVGs are returned unstyled).
- If the field is empty, it falls back to the field's configured **default image**
  (`FieldConfig::loadByName('user','user', <field>)->getSetting('default_image')['uuid']`).

### `getMediaFieldImage($field = NULL, $imageStyle = NULL): ?string`
Given an **entity_reference** field item list that points at a **media** entity, reads the media's
`field_media_image`, then behaves like `getFieldImage` (style applied unless SVG; relative URL).

- Falls back to the field's default media value
  (`->get('default_value')[0]['target_uuid']` loaded via `entity.repository`) and that media's
  `field_media_image`.
- Assumes the media bundle exposes `field_media_image` (core Image media type default).

## Notes for reuse

- These methods return a **URL string**, not a render array — the caller decides how to output it
  (the module drops it into a CSS `background-image`).
- `getFieldImage` / `getMediaFieldImage` take a field **item list** (e.g.
  `$user->get('user_picture')`), not a raw value.
