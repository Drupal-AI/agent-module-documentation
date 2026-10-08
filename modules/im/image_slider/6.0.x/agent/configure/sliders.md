<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sliders: entity, block, rendering

## The `image_slider` entity

Content entity (`Drupal\image_slider\Entity\Slider`), base table `slider`, `admin_permission`
declared as `administer slider entity`. Base fields (`baseFieldDefinitions`):

| Field | Type | Notes |
|---|---|---|
| `name` | string | Required, the slider label. |
| `description` | text_long | Required; rendered via `full_html` in the block (see rendering). |
| `image` | image | Required, **unlimited cardinality**; stores alt text; rows in `image_slider__image`. |
| `slide_type` | list_string | Required; one of the 11 layout keys below. |
| `user_id` | entity_reference → user | Author. |
| `role` | list_string | `administrator` / `user` (informational field). |
| `langcode`, `created`, `changed` | language/created/changed | Standard metadata. |

### `slide_type` allowed values

`full-width-slider`, `image-slider`, `image-gallery`, `image-gallery-with-vertical-thumbnail`,
`scrolling-logo-thumbnail-slider`, `full-window-for-pc`, `different-size-photo-slider`,
`nearby-image-partial-visible-slider`, `carousel-slider`, `banner-slider`, `banner-rotator`.

## Admin routes & permissions

| Route | Path | Access |
|---|---|---|
| `entity.image_slider.collection` | `/admin/structure/image_slider/list` | `view slider entity` |
| `image_slider.slider_add` | `/admin/structure/image_slider/add` | entity create access |
| `entity.image_slider.edit_form` | `…/{image_slider}/edit` | entity update access |
| `entity.image_slider.delete_form` | `…/{image_slider}/delete` | entity delete access |
| `entity.image_slider.canonical` | `/image_slider/{image_slider}` | entity view access |

Permissions (`image_slider.permissions.yml`, none `restrict access: true`):
`view slider entity`, `add slider entity`, `edit slider entity`, `delete slider entity`.
(The entity annotation references `administer slider entity`, which is not actually declared in the
permissions file — so there is no catch-all admin permission bypass for these operations.)

## The derived block

`Plugin/Block/SliderBlock` (id `slider_block`) uses `Plugin/Derivative/SliderBlock`: it queries the
`slider` table and emits **one block derivative per saved slider** (admin_label = slider name). So
after saving a slider you place its matching block in Block Layout.

`build()`:
- Selects the slider row (by derivative id) and its images from `image_slider__image`.
- `description` → `check_markup($value, 'full_html')`; the Twig `{{ data.description }}` then
  autoescapes the returned string (so raw HTML in the description is displayed escaped, not executed).
- Loads each image file and generates its URL (`file_url_generator`).
- Renders `#theme => 'image_slider'` with the jssor library attached and
  `drupalSettings.image_slider.slider_tyle = <slide_type>`.
- `blockAccess()` = `access content` (so any user who can view content sees a placed slider block).

## Template

`templates/image_slider.html.twig` — a single template with an `{% if data.slide_type == … %}`
branch per layout. Dimensions (widths/heights) are **hardcoded** per branch; image URLs come from
`image.image_url`, captions from `image.image_alt`. Customize by overriding this template in your theme.

## Config / setup notes

- No config schema is shipped for the entity (it's a content entity, not config).
- Ships two image styles via `config/install`: `image_slider_gallery`,
  `image_slider_vertical_thumb_gallery`.
- Create a slider programmatically:

```php
\Drupal::entityTypeManager()->getStorage('image_slider')->create([
  'name' => 'Homepage hero',
  'slide_type' => 'full-width-slider',
  'description' => 'Welcome',
  // 'image' => [...file references with alt...]
])->save();
```
