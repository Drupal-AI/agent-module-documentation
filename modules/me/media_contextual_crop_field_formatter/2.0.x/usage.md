<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Contextual Crop Reference lets the same media item be cropped differently depending on where it is used, so one photo can be a wide banner on the homepage and a square thumbnail in a card without a duplicate media entity.

---

Drupal's crop handling attaches the crop to the *media item*, which is correct for a canonical crop and wrong for reuse: the moment an image appears in two contexts with different aspect ratios, a media-level crop forces a compromise or a copy. This module moves the crop decision to the *reference* — the field instance where the media is used. It is the "references" piece of the Media Contextual Cropping collection, and on its own does nothing visible: it needs `media_contextual_crop` (the crop storage and pipeline), `media_library_media_modify` (which provides the per-reference "media with contextual modifications" field and stores the override), and at least one crop **adapter** — `media_contextual_crop_fp_adapter` (Focal Point) or `media_contextual_crop_iwc_adapter` (ImageWidget Crop) — which supplies the actual crop widget. To set it up: enable the collection; on the referencing entity (e.g. a content type) add a *Reference / media with contextual modifications* field targeting an image media bundle instead of a plain media reference; in the media type's form display, swap the native image widget for the adapter's crop widget; and in the media type's view display, set the image field to an image style that has a crop effect. Editors then add a media item to the reference field, edit it, and set the crop in the modal — the crop travels with that placement. Note that in 2.0.x the module no longer provides its own field formatter; an update hook migrates any old `media_contextual_crop_image` formatter back to core `image`, and the module also cleans up stored crops automatically when the host content is edited or deleted. Composer requires the `cweagans/composer-patches` plugin (it patches `media_library_media_modify`), so allow that plugin or the install will fail. Core requirement is `^10 || ^11`.

---

- Crop one image differently in two places.
- Use a wide crop on a banner and a square in a card.
- Avoid duplicating a media item for a second crop.
- Keep the canonical asset while varying its presentation.
- Set the crop where the media is referenced.
- Give editors per-usage cropping control.
- Reduce media library clutter from near-duplicates.
- Apply a portrait crop in a sidebar.
- Support a design system with several aspect ratios.
- Fix awkward automatic cropping per context.
- Keep alt text and metadata on one item.
- Crop for a mobile-specific layout.
- Reuse stock imagery across page types.
- Let editors adjust focus per placement.
- Reduce storage from duplicated images.
- Support a magazine-style layout.
- Crop a person's face consistently in a listing.
- Change a crop without affecting other usages.
