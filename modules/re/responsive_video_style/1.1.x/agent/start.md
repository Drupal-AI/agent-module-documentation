<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive video style — agent index

A breakpoint-based responsive layer on top of **Video Style**. A `responsive_video_style` config
entity maps a breakpoint group to one or more Video styles (plus fallbacks); the **Responsive video
style** field formatter renders a single-file media video source field responsively. Version
**1.1.3** (dir `1.1.x`). Core `^11.3 || ^12`. Requires `drupal/video_style:^1.1.3` and core
`breakpoint` + `file`. Config schema yes; one permission (`administer responsive video styles`,
restricted); no Drush; defines **no** plugin type (it consumes Video Style's `video_provider`
plugins). Optional `responsive_video_style_api` submodule (REST + JSON:API) — out of scope here.

- **Create a Responsive video style: breakpoint group, strategy, mappings, fallbacks, `<video>` tag
  settings, posters** → [configure/responsive-video-style.md](configure/responsive-video-style.md)
- **The `responsive_video_style` field formatter (applicability, settings, what it renders)** →
  [fields/formatter.md](fields/formatter.md)
- **The single `administer responsive video styles` permission and the admin routes it gates** →
  [permissions/permissions.md](permissions/permissions.md)
- **The `responsive_video_style` / `responsive_video_style_variants` theme hooks and templates** →
  [theming/templates.md](theming/templates.md)
- **The `responsive_video_style.builder` service, delivery value objects, and the delivery
  cache-tag event subscriber** → [api/builder.md](api/builder.md)

Key facts:
- Config entity `responsive_video_style` (prefix `responsive_video_style.responsive_video_style.*`).
  Exported: `id`, `label`, `breakpoint_group`, `responsive_strategy`, `video_tag_settings`,
  `fallback_video_styles`, `video_style_mappings`. Admin permission
  `administer responsive video styles`.
- Two **responsive strategies** (`VideoProviderInterface` constants): `source` = one `<video>` with
  ordered `<source>` elements; `variant` = separate per-breakpoint `<video>`s switched client-side.
  All selected Video styles must share the strategy **and** the render mode.
- Two **render modes**: `native` (bundled providers emit HTML5 video) and `provider_rendered`
  (provider owns the markup; currently requires the `variant` strategy).
- Bundled breakpoint group **Responsive Video** (`responsive_video_style.breakpoints.yml`): Mobile
  `(max-width: 767px)`, Tablet `(min-width:768px) and (max-width:1023px)`, Desktop
  `(min-width:1024px)`.
- Formatter `responsive_video_style` (field type `file`); `isApplicable()` delegates to
  `VideoFormatterApplicability::appliesToSingleValueMediaVideoSourceField()`. Single setting:
  `responsive_video_style` (the chosen style ID).
- Builder `responsive_video_style.builder` (`ResponsiveVideoBuilder`): `buildForMedia()` (access via
  Video Style's `MediaSourceResolver`), `buildDelivery()` (portable, no asset prep, assumes an
  authorized File), `buildRenderData()` (HTML path, prepares styles). Returns `VideoDelivery` value
  objects with a `deliveries` map and `structured_sources`.
- 1.1.x additions: requires Video Style `^1.1.3`; `structured_sources` + intrinsic width/height/
  duration; graceful degradation when a constituent provider fails (aggregate becomes uncacheable);
  `ResponsiveVideoDeliveryConfigSubscriber` emits `VideoDeliveryCacheTags::DELIVERY`
  (`video_style_delivery`) on every config save/delete/rename (incl. collection overrides & Drush).
- All output is Twig auto-escaped; all admin routes gated by the restricted permission.
