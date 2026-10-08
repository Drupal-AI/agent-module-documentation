<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive Slideshow — configuration

## Settings form: `responsive_slideshow.settings`

Route `/admin/config/user-interface/responsive_slideshow`
(`responsive_slideshow.routing.yml`), permission **`administer responsive slideshow`**, menu link
under `system.admin_config_ui`. Class
`Drupal\responsive_slideshow\Form\ResponsiveslideshowForm` (extends `ConfigFormBase`), form id
`responsive_slideshow_settings`, editable config `responsive_slideshow.settings`.

| Config key | Default | Field | Meaning |
|---|---|---|---|
| `responsive_slideshow_no_of_slides` | `5` | textfield, required | How many slides the carousel shows. Becomes the query `range(0, N)`. Validated numeric and `> 0`. |
| `responsive_slideshow_description_length` | `180` | textfield, required | Max characters of the slide description. `0` = show the full description. Validated numeric. |
| `responsive_slideshow_interval` | `5000` | textfield, required | Auto-advance interval in **milliseconds**, emitted as `data-bs-interval`. Validated numeric and `> 0`. |

`submitForm()` saves the three keys and then calls `drupal_flush_all_caches()` (heavy, but the block
is uncached anyway). There is **no config schema** shipped (`config/schema/` does not exist), so these
keys are untyped for config inspection/translation.

## Install / uninstall behavior

`responsive_slideshow_install()`:
- Adds `responsive_slideshow` to `node.type.locked` state, so the content type cannot be deleted
  through the UI while the module is enabled.
- Writes the three default settings above.

`responsive_slideshow_uninstall()`:
- **Deletes every `responsive_slideshow` node** (`accessCheck(FALSE)`), then deletes the five field
  storages, runs `field_purge_batch(1000)`, deletes the `responsive_slideshow_style` image style,
  clears the settings, unlocks the node type, and flushes all caches. Uninstalling is destructive to
  authored slide content — export/migrate first if the slides matter.

`responsive_slideshow_update_9003()` back-fills `field_slide_link` and `field_hide_external_link`
(and their form/view display components) on sites installed before those fields existed.

## Bundled content type `responsive_slideshow` (config/install)

Locked node type "Responsive Slideshow" (preview mode 1, `menu_ui` third-party settings for the
`main` menu). Fields:

| Field | Type | Notes |
|---|---|---|
| `field_slideshow_image` | image | **Required.** `png gif jpg jpeg`, alt & title fields enabled. Description recommends 1320x347. This is the only field the block query requires (INNER JOIN). |
| `field_slide_teaser` | text (plain) | Preferred description source; hidden on the default view display. |
| `field_body_desc` | text (long) | Fallback description; rendered through the `restricted_html` format then `strip_tags`. |
| `field_slide_link` | link | Optional per-slide link (see blocks/index.md for resolution). |
| `field_hide_external_link` | boolean | "Hide Detail Page". When set, the slide links to the Link field value instead of the node; when the Link field is empty and this is set, the slide has no link. |

## Image style `responsive_slideshow_style`

`image_scale_and_crop`, width **1320**, height **347**, `upscale: TRUE`. All slide images are built
through this style (`ImageStyle::load('responsive_slideshow_style')->buildUrl($uri)`). Change slide
dimensions by editing this style at
`/admin/config/media/image-styles/manage/responsive_slideshow_style`.
