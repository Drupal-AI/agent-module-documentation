<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Image ships a ready-made **Image media type** — its image, categories and tags fields, two form displays (with a focal-point widget), twelve view displays, three extra view modes, and eighteen image styles — as installable configuration, one component of the Acquia CMS (Acquia Drupal Starter Kit) content model. A little glue code grants image-media permissions to the distribution's editorial roles and installs the Acquia CMS logo as a media item and site logo.

---

Acquia CMS is Acquia's Drupal distribution, assembled from small single-purpose modules like this one. Rather than a site builder hand-building an image asset type — the source field, the focal-point widget, the taxonomy fields, the view modes and image styles — this module ships that configuration as a unit, so the Image media type exists and is editor-ready the moment the module and its dependencies are enabled. Its opinions are encoded in config: the `image` bundle uses a required image field limited to png/gif/jpg/jpeg, a Focal Point widget, a "Taxonomy" field group referencing the shared `categories`/`tags` vocabularies from `acquia_cms_common`, and a family of `coh_*` image styles wired into per-mode view displays with lazy loading. Content translation is turned on for the bundle.

Beyond config, three small pieces of PHP matter: an alter hook that grants the core per-bundle image-media permissions to the `content_author` and `content_editor` roles during Acquia CMS's role build; an install hook that rewrites the CKEditor config and creates the branded logo media; and a config-import subscriber plus an internal `SiteLogo` service that create the logo media (fixed UUID) and set it as the global theme logo unless one is already chosen. The value and the limitation are the same fact: it is distribution configuration, not a generic feature. On an Acquia CMS site it is exactly right; on an unrelated site it is a strong set of assumptions — it depends on `acquia_cms_common`, `media`, `media_library`, `image`, `imce`, `field_group` and `focal_point`, and it expects its siblings to be present.

---
- Add a pre-built Image media type to a site.
- Author an image asset with a focal-point crop.
- Get a required image field restricted to png/gif/jpg/jpeg.
- Reuse Acquia CMS's Image content model.
- Standardise image assets across a site.
- Get twelve view displays for image out of the box.
- Get two form displays (default and Media Library) configured.
- Use a Focal Point widget for image cropping.
- Get eighteen `coh_*` image styles ready to use.
- Get the `teaser`, `x_small_square` and `large_super_landscape` view modes.
- Tag and categorise images via the shared taxonomy vocabularies.
- Enable content translation for image media.
- Grant image-media permissions to editorial roles automatically.
- Install the Acquia CMS logo as media and site logo.
- Embed images in CKEditor after the editor config rewrite.
- Skip building the image media type by hand.
- Base a custom image type on this configuration.
- Match the Acquia CMS content model for images.
- Export the image config with the rest of the site.
- Extend the image media type with extra fields.
- Use image media with the rest of the Acquia CMS family.
- Provide editors a consistent image editing experience.
- Migrate older `image_scale_and_crop` styles to focal-point crops via update hooks.
- Keep image styles usable with Site Studio (Cohesion) content templates.
