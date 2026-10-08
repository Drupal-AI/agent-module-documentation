<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a delta formatter

No configure route (`configure: null`) and no admin settings page. You select one of the three
formatters on an entity bundle's **Manage display** page and enter the deltas. The choice is
stored in the `entity_view_display` config entity.

## The three formatters

| Formatter id | Label | field_types | Extends | Requires |
|---|---|---|---|---|
| `image_delta_formatter` | Image delta | `image` | core `ImageFormatter` | Image (dependency) |
| `responsive_image_delta_formatter` | Responsive image delta | `image` | `ResponsiveImageFormatter` | `responsive_image` enabled |
| `media_delta_formatter` | Media delta | `entity_reference` (media) | `MediaThumbnailFormatter` | `media` enabled |

`image_delta_formatter` is a normal plugin (has the `#[FieldFormatter]` attribute /
`@FieldFormatter` annotation). The other two have **no annotation** — they are registered at
runtime by `image_delta_formatter_field_formatter_info_alter()` only when their required core
module (`responsive_image` / `media`) is enabled, which is why they live in
`src/OptionalPlugin/`. All three mix in `ImageDeltaTrait`.

## Settings (added by `ImageDeltaTrait`)

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  field_gallery:
    type: image_delta_formatter
    label: hidden
    settings:
      deltas: [0, 2]          # required; the delta(s) to show (0-based)
      deltas_reversed: false  # count from the last value when true
      # ...plus all inherited image/media settings (image_style, image_link, etc.)
```

- `deltas` — **required**. In the UI it is a text field: enter one delta or a comma-separated
  list, e.g. `0` or `0, 1, 4`. It is validated/normalized to an integer array (each `>= 0`).
- `deltas_reversed` — checkbox; reverses the surviving items (so with `deltas: [0]` and
  reversed on, you get the *last* image). The settings summary notes "(reversed)".
- Inherited settings depend on the parent formatter: `image_delta_formatter` and
  `responsive_image_delta_formatter` inherit image style / responsive image style / image link;
  `media_delta_formatter` inherits the media thumbnail settings.

## How it filters (mechanism)

`ImageDeltaTrait::getEntitiesToView()` calls the parent to get all items, then unsets every
item whose array key (delta) is not in the configured `deltas`, and finally `array_reverse()`s
if `deltas_reversed` is TRUE. Everything else (rendering, linking, image styles) is the parent
formatter's behavior.

## Via the UI

1. Go to the bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. In the multi-value image/media field's **Format** column choose *Image delta* /
   *Responsive image delta* / *Media delta*.
3. Click the gear, enter the **Delta** (e.g. `0, 1, 4`), optionally tick **Reversed**, *Update*.
4. **Save** the display.

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_gallery', [
  'type' => 'image_delta_formatter',
  'label' => 'hidden',
  'settings' => ['deltas' => [0], 'deltas_reversed' => FALSE, 'image_style' => '', 'image_link' => ''],
])->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_gallery
# look for  type: image_delta_formatter  and  settings.deltas
```

## Config schema

Ships `field.formatter.settings.image_delta_formatter` and
`field.formatter.settings.media_delta_formatter` (in `config/schema/`), each defining `deltas`
(sequence of integers, `Range` min 0), `deltas_reversed` (boolean), plus `image_style`,
`image_link`, and `image_loading`.
