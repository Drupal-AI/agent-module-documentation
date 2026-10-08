<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video style — agent index

**Video style config entities + provider API for derived video delivery URLs**. Version **1.1.3**. Core `^11.3 || ^12` (Drupal 11.3+ and 12).

Base for Responsive video style. Depends on core `file`, `media`. Provides a `VideoProvider` plugin type (bundled `local` provider), the `Video style` and `Video style poster` formatters, a shared asset registry and admin page at `/admin/config/media/video-styles/assets`, the `video_style.delivery_builder` service returning a cacheable `VideoDelivery`, a `drush video-style:retry-due-now` command, the public `video_style_delivery` aggregate cache tag (since 1.1.3), and nullable intrinsic source `width`/`height`/`duration` metadata (since 1.1.1). Optional `video_style_api` submodule exposes read-only Media delivery fields for REST and JSON:API. Configure at `entity.video_style.collection`.
