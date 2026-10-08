<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media PhotoSwipe (media_photoswipe) — agent index

**Field formatter that renders Image/Remote Video media in a PhotoSwipe lightbox gallery.**

- **Version:** 1.0.x (dev checkout, branch `1.0.x`)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** image; library `levmyshkin/photo-swipe` (^5.2).
- **Formatter:** `MediaImagePhotoSwipeFormatter`.
- **Services:** `media_photoswipe.activation_check` (ActivationCheck — `?media_photoswipe=no` disables), `media_photoswipe.attachment` (MediaPhotoSwipeAttachment), `media_photoswipe.gallery_id_generator` (GalleryIdHelper, uses token).
- **Config route:** `media_photoswipe.admin_settings` → `/admin/config/media/media-photoswipe`, permission **`administer site configuration`**.
- **Security:** display-only; single admin config route gated by `administer site configuration`; no anonymous or mutating endpoints.