<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Remote Image adds a media source and media type for images that live somewhere else — a URL is stored instead of a file, and the media entity references the remote asset.

---

Not every image should be uploaded into Drupal. A digital asset management system may be the authoritative home for an organisation's photography, a partner may supply imagery on their own CDN under their own licence, or a supplier's system may own the product photos — in each case you want the image to participate fully in Drupal's media system (searchable in the library, referenced from fields, usable in a WYSIWYG, subject to media access) while the bytes stay where they are. This module supplies that as a **Remote image** media source and a bundled media type, depending only on core `link` and `media`. The stored value is a Link-derived field (`remote_image_url`) holding the image URL plus alt text; a widget captures both and a formatter renders a standard `<img>` with configurable maximum width/height, native lazy or eager `loading`, and an optional link to the media entity or the image URL. External URLs and (when the field's link type allows) internal site paths are both supported. When media is saved, the module contacts the remote host to confirm the URL returns image content, and — only if you enable **Generate thumbnail previews** in its settings — it downloads the image and stores a local thumbnail via an image style for use on the media admin and Media Library screens. What you give up is worth naming: **image styles need the file**, so derivatives, responsive images and cropping do not apply to the displayed remote image; and **availability is someone else's**, so a broken remote URL is a broken image with no local fallback, and the failure is silent until someone looks. Version **8.x-1.2-beta2** (a beta) on a core range of `^8` through `^11`.

---

- Reference images from a DAM or asset library.
- Use a partner's hosted imagery under their licence.
- Reference a CDN-hosted image without copying it.
- Avoid duplicating a supplier's product photos.
- Keep image storage and bandwidth outside Drupal.
- Add remote images to the media library.
- Reference remote images from entity-reference fields.
- Embed a remote image in a CKEditor/WYSIWYG via media.
- Give remote images alt text for accessibility.
- Constrain rendered size with max width/height.
- Lazy- or eager-load rendered remote images.
- Link a displayed image to the media entity or its URL.
- Store multiple remote images on one media entity.
- Optionally generate local thumbnail previews for admin screens.
- Reference an internal site path as a "remote" image.
- Manage licensing/attribution metadata in Drupal while the image stays remote.
- Keep a single source of truth for photos.
- Reference stock or public-domain imagery by URL (Wikimedia, Flickr, Pexels).
- Add remote image media from Media Library's "Add via URL" form.
- Reduce site file-storage requirements.
- Support a federated or multi-site asset strategy.
- Reference images from an API or feed.
