<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Galleries: the media_gallery entity, fields, and shipped config

## The entity

`media_gallery` is a **content entity** (not a config entity), id `media_gallery`, single bundle
`media_gallery`, base table `media_gallery`, data table `media_gallery_field_data`, translatable,
publishable. `admin_permission = "access media gallery overview"`.
`field_ui_base_route = entity.media_gallery.settings`, so Field UI (Manage fields / form display /
display) attaches to it.

Routes (via `AdminHtmlRouteProvider`):

| Link | Path |
|---|---|
| collection | `/admin/content/media-gallery` |
| add-form | `/admin/content/media-gallery/add` |
| canonical | `/media_gallery/{media_gallery}` |
| edit-form | `/admin/content/media-gallery/{media_gallery}/edit` |
| delete-form | `/admin/content/media-gallery/{media_gallery}/delete` |
| settings | `/admin/structure/media-gallery` (route `entity.media_gallery.settings`) |

The settings form (`MediaGallerySettingsForm`) is a placeholder — it only exists to host the Field
UI tabs; it has **no configurable settings** of its own.

## Base fields (from `MediaGallery::baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `title` | string (255) | required; the entity label |
| `description` | text_long | rich text |
| `images` | entity_reference → `media`, unlimited | Media Library widget; **PhotoSwipe** field formatter on view; targets all media bundles |
| `use_pager` | boolean | default `1`; paginate the gallery on display |
| `items_per_page` | integer | default `12`, min `1`; used when `use_pager` is on |
| `reverse` | boolean | default `0`; show photos in reverse order |
| `uid` | entity_reference → `user` | author (defaults to current user on create) |
| `created` / `changed` | created / changed | timestamps |
| `status` | boolean | published flag, default `1` |

`use_pager`, `items_per_page` and `reverse` drive `media_gallery_preprocess_media_gallery()` (see
[theming/theming.md](../theming/theming.md)).

## Create a gallery programmatically

```php
$gallery = \Drupal::entityTypeManager()->getStorage('media_gallery')->create([
  'title' => 'Summer 2025',
  'status' => 1,
  'use_pager' => 1,
  'items_per_page' => 12,
  'images' => [['target_id' => 42], ['target_id' => 43]], // media ids
]);
$gallery->save();
```

## Add your own field to galleries

Because of `field_ui_base_route`, go to **Manage fields** under
`/admin/structure/media-gallery/fields` (README step 3), or via config:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create(['field_name' => 'field_caption', 'entity_type' => 'media_gallery', 'type' => 'string'])->save();
FieldConfig::create(['field_name' => 'field_caption', 'entity_type' => 'media_gallery', 'bundle' => 'media_gallery', 'label' => 'Caption'])->save();
```

## Config shipped in `config/install`

| Config | What it is |
|---|---|
| `image.style.media_gallery_image` | Image style **"Media Gallery Image (300x180)"**, one `image_scale_and_crop` effect (300x180, center). Default gallery thumbnail style. |
| `core.entity_view_mode.media_gallery.full_gallery` | View mode `media_gallery.full_gallery` ("Full gallery"). |
| `core.entity_view_display.media_gallery.media_gallery.default` | Default display: `title` (string), `description` (text_default), `images` (photoswipe_field_formatter with `photoswipe_thumbnail_style: media_gallery_image`). |
| `views.view.media_galleries` | View **"All Galleries"**, page display at **`/galleries`**, base table `media_gallery_field_data`, full pager (9 per page). |

Default PhotoSwipe styles come from `MediaGalleryConstants`:
`DEFAULT_PHOTOSWIPE_IMAGE_STYLE = ''` (original), `DEFAULT_PHOTOSWIPE_THUMBNAIL_STYLE = 'media_gallery_image'`.

## Swap PhotoSwipe for Colorbox (from README)

Add a new media view mode, set its formatter to Colorbox, then set that view mode as the display
for galleries at `/admin/structure/media-gallery/display`.
