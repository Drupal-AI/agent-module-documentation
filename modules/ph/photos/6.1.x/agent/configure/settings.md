<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Photos (global settings)

## Admin routes

| Route | Path | Purpose |
|---|---|---|
| `photos.admin` | `/admin/structure/photos` | Structure page; the `configure` link & field-UI base route (manage `photos_image` fields/displays). |
| `photos.admin.config` | `/admin/config/media/photos` | Main settings form (`PhotosAdminSettingsForm`). |
| `photos.admin.legacy.config` | `/admin/config/media/photos/legacy` | Legacy display settings. |
| `entity.photos_image.collection` | `/admin/content/photos` | List of all photos. |
| `photos.import.directory` | `/photos/import` | Import images from a server directory. |

Most admin routes require `administer nodes`.

## Config object: `photos.settings`

Key settings (defaults from `config/install/photos.settings.yml`, schema `photos.schema.yml`):

| Key | Default | Meaning |
|---|---|---|
| `multi_upload_default_field` | `field_image` | Field images upload into. |
| `photos_num` | `5` | Images per upload form. |
| `photos_additional_sizes` | `5` | Extra download sizes offered. |
| `photos_size` | `[{style,name}…]` | Named downloadable sizes (image style + label). |
| `photos_size_max` | `''` | Max image style applied on upload. |
| `photos_cover_imagesize` | `thumbnail` | Image style for album covers. |
| `photos_display_list_imagesize` | `large` | Style in list view. |
| `photos_display_full_imagesize` | `large` | Style in full view. |
| `photos_display_full_viewnum` | `10` | Images per full page. |
| `photos_display_teaser_imagesize` | `medium` | Style in teaser. |
| `photos_pager_imagesize` | `thumbnail` | Style for pager thumbs. |
| `photos_display_imageorder` | `weight\|asc` | Default sort `field\|direction`. |
| `photos_display_viewpager` | `10` | Pager size. |
| `photos_image_count` | `true` | Show image counts. |
| `photos_clean_title` | `true` | Clean up uploaded filenames into titles. |
| `photos_upzip` | `true` | Allow ZIP-archive upload/extract. |
| `photos_plupload_status` | `false` | Use Plupload multi-uploader (needs plupload module). |
| `photos_user_count_cron` | `true` | Recount user photos on cron. |
| `photos_pnum_authenticated` / `photos_pnum_administrator` | `20` | Per-role upload limits. |
| `photos_access_photos` | `false` | (Set by photos_access) enable album privacy for the `photos` type. |
| `upload_form_mode` | `0` | Which upload form/mode is used. |

Read/write via drush:

```bash
drush cget photos.settings photos_display_list_imagesize
drush cset photos.settings photos_num 8 -y
```

Or in PHP: `\Drupal::configFactory()->getEditable('photos.settings')->set('photos_cover_imagesize', 'medium')->save();`

## Fields & displays

Because `field_ui_base_route` is `photos.admin`, you manage the `photos_image` entity's fields,
form display and view displays (cover/full/list/teaser/pager/sort/search_result) under
`/admin/structure/photos`. The default image field is `field_image` on the `photos_image` bundle.
