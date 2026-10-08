# Enable & use the Decorative option

No global settings page (`configure` null). Everything is per **image field**.

## Enable on a field (two settings)

Go to the image field's **Edit field** form (`field_config_edit_form`,
`admin/structure/types/manage/<bundle>/fields/<field>`). `DecorativeConfigFormAlter::alterForm()` adds,
just after *Alt required*:

| Setting (third-party, provider `decorative_images`) | Effect |
|---|---|
| `decorative_enabled` — "Enable the *Decorative* field" | Adds the per-image decorative checkbox to the widget. |
| `decorative_or_alternative_required` — "Require *Alt* or *Decorative*" | Requires either Alt text or the decorative flag. Meaningful only when `decorative_enabled` is on **and** core *Alt required* is off. |

Both are saved onto the `FieldConfig` via an `#entity_builders` callback
(`getThirdPartySetting('decorative_images', ...)`). Set them programmatically:

```php
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_image');
$field->setThirdPartySetting('decorative_images', 'decorative_enabled', 1)
      ->setThirdPartySetting('decorative_images', 'decorative_or_alternative_required', 1)
      ->save();
```

## Editor experience

When `decorative_enabled` is set, `DecorativeWidgetFormAlter::alterForm()` adds an `is_decorative`
checkbox to each image widget delta (label "Descriptive image (not decorative)"). If
`decorative_or_alternative_required` is set, an `#element_validate` callback errors with
*"Alternative text or the decorative option is required."* when a file is uploaded but both Alt and the
decorative flag are empty. The validator skips upload/remove button submits and reads
`$form_state` user input during AJAX so it works mid-upload.

## Where the flag is stored (important)

The decorative boolean is **not** stored on the image field item. On save,
`decorative_images_entity_presave()` iterates every `image`-type field on `node`/`media` entities and
writes the value into the **key-value collection** `decorative_images`, keyed by the image's file
`target_id`:

```php
\Drupal::service('keyvalue')->get('decorative_images')->set($target_id, $is_decorative);
```

Consequences:
- The state is keyed by **file id**, so the same file reused elsewhere shares the flag.
- It is not part of field config/content exports; it lives in the site's key-value store.

## How it renders

1. `decorative_images_preprocess_field()` — for each `image` item whose file id is flagged in key-value,
   sets `$item['content']['#item_attributes']['role'] = 'presentation'`.
2. `decorative_images_preprocess_image()` — for any image whose `role` is `presentation`, unsets the
   `role` attribute and sets `alt = ''`.

Net output: decorative images get empty alt and are treated as presentational, so assistive tech skips
them. For custom/responsive image pipelines, replicate the same `role`/`alt` handling in your
`template_preprocess_image` overrides.
