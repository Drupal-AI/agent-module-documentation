<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video style config entities and a provider API for derived video delivery URLs.

---

Video style provides video style configuration entities and a pluggable provider API for generating derived video delivery URLs — the video analogue of image styles, letting site builders define named video styles and plug in providers (`VideoProvider` plugins) that produce the appropriate delivery URL/rendition for a source video. The base module owns the reusable styles, the `Video style` and `Video style poster` formatters, a shared asset registry, and a shared asset administration page at `/admin/config/media/video-styles/assets`; provider modules own delivery, sync and cleanup logic. A bundled `local` provider returns the original Drupal-managed file URL. In the 1.1 line the independent `video_style.delivery_builder` service returns a cacheable `VideoDelivery`, sources carry nullable intrinsic `width`/`height`/`duration` metadata (since 1.1.1), a `drush video-style:retry-due-now` command reschedules pending sync retries, and the public `video_style_delivery` aggregate cache tag (`VideoDeliveryCacheTags::DELIVERY`, since 1.1.3) signals changed delivery to decoupled consumers. An optional `video_style_api` submodule adds read-only Media delivery fields for REST and JSON:API. It is the base that modules like Responsive video style build on. Depends on core `file` and `media`; supports Drupal 11.3+ and 12.

---

- Define video style config entities.
- Provide a `VideoProvider` provider API.
- Generate derived delivery URLs.
- Mirror image styles for video.
- Plug in delivery providers.
- Underpin Responsive video style.
- Depend on core `file` and `media`.
- Support Drupal 11.3+ and 12.
- Configure at entity.video_style.collection.
- Administer assets at `/admin/config/media/video-styles/assets`.
- Reschedule retries via `drush video-style:retry-due-now`.
- Build delivery with `video_style.delivery_builder`.
- Expose delivery changes via the `video_style_delivery` cache tag.
- Carry intrinsic source width/height/duration metadata.
- Expose read-only delivery fields via the optional `video_style_api` submodule.
- Handle video styles.
- Produce renditions.
