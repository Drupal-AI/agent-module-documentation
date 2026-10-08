<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides responsive breakpoint mappings and a file formatter for Video styles.

---

Responsive video style adds a breakpoint-based responsive layer on top of the Video Style module — the video analogue of core Responsive Image. A `responsive_video_style` configuration entity maps a breakpoint group to one or more Video styles (plus fallbacks), and a dedicated **Responsive video style** field formatter renders a single-file media video source field as either one `<video>` with ordered `<source>` elements (the `source` strategy) or a set of per-breakpoint `<video>` variants switched client-side (the `variant` strategy). Rendering adapts to each selected Video style's provider strategy and render mode, with optional poster support for native output. Admin lives at `/admin/config/media/video-styles/responsive` under one `administer responsive video styles` permission. As of 1.1.3 it requires Video Style `^1.1.3`, exposes `structured_sources` and intrinsic width/height/duration, degrades gracefully when a constituent provider fails, and emits the provider-independent `video_style_delivery` cache tag on every config change via an event subscriber. An optional `responsive_video_style_api` submodule exposes selected styles over REST and JSON:API. Depends on core `breakpoint` and `file` plus `video_style`; supports Drupal 11.3+ and 12.

---

- Deliver different video renditions per breakpoint (mobile/tablet/desktop).
- Map a breakpoint group to Video styles through reusable configuration.
- Render one `<video>` with multiple ordered `<source>` elements (source strategy).
- Render separate per-breakpoint `<video>` variants switched by media query (variant strategy).
- Replace ad hoc template conditions and per-field responsive-video hard-coding.
- Add a Responsive video style formatter to a single-file media video source field.
- Configure shared `<video>` tag attributes (controls, autoplay, loop, muted, playsinline, preload, width, height).
- Set custom fallback text for browsers that cannot play the video.
- Attach a shared poster image resolved from fallback then mapped styles.
- Append the original uploaded file as a final fallback `<source>`.
- Use the bundled `Responsive Video` breakpoint group (Mobile/Tablet/Desktop) out of the box.
- Order multiple Video styles per breakpoint by weight (source strategy).
- Enforce one Video style per breakpoint and one fallback (variant strategy).
- Keep provider-specific delivery logic inside each Video style, not in templates.
- Pair a local-file provider (variant) or an alternate-URL provider like ImageKit (source).
- Expose selected responsive styles over REST/JSON:API via the API submodule.
- Consume `structured_sources` (url, mime_type, codecs, media_query, width, height, duration) without parsing HTML.
- Build portable native delivery without preparing assets via `buildDelivery()`.
- Resolve Media/source/File access through Video Style's resolver via `buildForMedia()`.
- Invalidate cached delivery sitewide on config change through the `video_style_delivery` cache tag.
- Degrade gracefully when a constituent provider is missing or fails to initialize.
- Preserve intrinsic width/height/duration metadata supplied by Video Style.
- Schedule queue-backed derivative/poster work without side effects in read paths.
- Serve responsive video for performance-sensitive, device-aware content delivery.
