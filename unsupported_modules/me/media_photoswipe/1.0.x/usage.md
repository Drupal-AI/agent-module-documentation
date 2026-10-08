<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Displays media images (and remote video) in a clickable PhotoSwipe lightbox/zoom gallery via a field formatter.
---
This module provides a field formatter (`\Drupal\media_photoswipe\Plugin\Field\FieldFormatter\MediaImagePhotoSwipeFormatter`) that renders media reference fields so thumbnails open in the PhotoSwipe JS lightbox, with grouped galleries and zoom. It relies on the `levmyshkin/photo-swipe` library and core `image`. Supporting services include `media_photoswipe.activation_check` (`ActivationCheck`), `media_photoswipe.attachment` (`MediaPhotoSwipeAttachment`, which conditionally attaches the JS/CSS library), and `media_photoswipe.gallery_id_generator` (`GalleryIdHelper`, using the token service to build gallery ids).

Configuration lives at `/admin/config/media/media-photoswipe` (`MediaPhotoSwipeSettingsForm`), gated by the core `administer site configuration` permission. The `ActivationCheck::isActive()` helper lets a request suppress the behaviour when the `media_photoswipe` query parameter equals `no` (e.g. for print/debug). Setup: install the PhotoSwipe library via Composer, enable the module, set the formatter on an image/media field's display, and tune gallery settings. This is a display-only integration.
---
- Show media images in a PhotoSwipe lightbox on click.
- Build zoomable image galleries from a media reference field.
- Group multiple images into a single swipeable gallery.
- Configure gallery behaviour at the settings page.
- Set the formatter on an entity view display.
- Generate gallery ids from tokens (per node/entity).
- Attach PhotoSwipe assets only where needed.
- Suppress PhotoSwipe for a request via `?media_photoswipe=no`.
- Display remote video media alongside images.
- Provide responsive, touch-friendly image viewing.
- Use a custom image style for thumbnails vs full view.
- Theme the formatter via the shipped Twig template.
- Add captions from media fields to lightbox slides.
- Integrate PhotoSwipe without writing JS.
- Keep galleries consistent across content types.
- Offer full-screen zoom for gallery images.
- Restrict configuration to site admins.
- Extend behaviour via the module's API hooks (`media_photoswipe.api.php`).