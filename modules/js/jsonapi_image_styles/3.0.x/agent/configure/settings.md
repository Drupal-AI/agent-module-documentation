<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure which image styles are exposed

## Settings form / route

- Route: `jsonapi_image_styles.settings` → path `/admin/config/services/jsonapi/image_styles`.
- Menu: *Configuration → Web Services → JSON:API Image Styles*.
- Access: core permission **`Administer image styles`** (the module defines no permission of its own).
- Form class: `Drupal\jsonapi_image_styles\Form\JsonApiImageStylesAdminForm` (a `ConfigFormBase`).

The form renders one checkbox per image style (`image_style` entities) under **Image styles**.

## Config object

`jsonapi_image_styles.settings`:

```yaml
image_styles:
  thumbnail: thumbnail   # checked  → exposed
  large: large           # checked  → exposed
  medium: '0'            # unchecked → not exposed
```

Semantics (`ImageStyleNormalizedFieldItemList::computeValue()`):

- The value is a checkboxes map: a **selected** style has value equal to its id (truthy); an
  **unselected** style has value `0` (falsy).
- If `array_filter($image_styles)` is **empty** (no style selected, or the key is unset/`null`),
  the module falls back to exposing **all** defined image styles — this is the default.
- If any style is selected, **only** the selected styles are exposed.

Read it back:

```bash
drush cget jsonapi_image_styles.settings image_styles
```

Set it programmatically (expose only `thumbnail`):

```php
\Drupal::configFactory()->getEditable('jsonapi_image_styles.settings')
  ->set('image_styles', ['thumbnail' => 'thumbnail'])
  ->save();
```

To expose everything again, save an empty array (or all-falsy values):

```php
\Drupal::configFactory()->getEditable('jsonapi_image_styles.settings')
  ->set('image_styles', [])->save();
```

## Cache invalidation

`Drupal\jsonapi_image_styles\EventSubscriber\ConfigSubscriber` adds the cache tag
`config:jsonapi_image_styles.settings` to every JSON:API (`api_json`) response, so changing the
allow-list invalidates cached API output automatically. No manual `drush cr` is required for the
change to take effect on fresh requests, though a rebuild never hurts.

## Notes

- The module ships **no** `config/install` default and **no** config schema; the key simply does
  not exist until you save the form once (in which case the "expose all" fallback applies).
