<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertisement content (ad_content) — agent index

The native **content provider** (bucket) submodule of the `ad` project. Defines the `ad_content`
entity you author in the admin UI and the `AdContentBucket` plugin that serves random published ads
to advertisement blocks. Package `Advertisement`. Core `^11`. Depends on **`ad`, `ad_track`,
`image`, `link`, `options`, `text`**. License GPL-2.0-or-later. Release 11.0.0-alpha12.

- **The entity, bundles, fields, permissions, access, routes, bucket & impression-render flow,
  formatters** → [entity/ad-content.md](entity/ad-content.md)

## What it provides (from source)

- **Content entity `ad_content`** (`src/Entity/AdContent.php`) — `EditorialContentEntityBase`,
  revisionable + translatable + owned. Bundles are `ad_content_type` config entities
  (`src/Entity/AdContentType.php`). Ships bundles **`image_ad`** and **`text_ad`**
  (`config/install/ad_content.ad_content_type.*`).
- **Bucket plugin `ad_content`** (`src/Plugin/Ad/Bucket/AdContentBucket.php`) implementing
  `BucketInterface` + `TrustedCallbackInterface` — random ad selection via an entity query tagged
  `order_random`, impression tracking, placeholder building.
- **Impression AJAX controller** `ImpressionController` (`src/Controller/ImpressionController.php`)
  at route `ad_content.render_ad` → `/ad/content/render` (permission `access content`).
- **Image field formatters** (`src/Plugin/Field/FieldFormatter/`): `ad_content_image` and
  `ad_content_image_click_track` (routes clicks through `ad_track.track`), base class
  `Field/AdContentImageFormatterBase`.
- **Permissions** (`ad_content.permissions.yml` + `AdContentPermissions`): `create/edit/delete ads`,
  revision perms, `administer ad types`, and per-bundle variants; access handler
  `AdContentAccessControlHandler`.
- **Hooks** (`ad_content.module`): `hook_query_alter` (`order_random` → `orderRandom()`), an
  "Advertisement indicator" pseudo-field (`hook_entity_extra_field_info` + `hook_ENTITY_TYPE_view`),
  `hook_theme` (`ad_content_advertisement_indicator`), menu-link derivation per bundle.
- **Config**: schema `config/schema/ad_content.schema.yml`; field storage/instances for
  `field_ad_image` (image_ad) and `field_ad_text` (text_ad); optional `ad_statistics` view, entity
  actions, and `mini_thumbnail` image style.
- **JS/library**: `js/ad-content.render.js` (behavior `ad`) + library
  `ad_content/ad_content.render_ads`.
- **Nested submodule `ad_content_js`** (experimental) — see `modules/ad_content_js/11.0.x/`.
