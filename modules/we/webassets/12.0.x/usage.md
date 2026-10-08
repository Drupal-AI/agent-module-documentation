Web Assets provisions a ready-to-use media library on a fresh Drupal site by applying a recipe that creates seven media types plus their fields, view modes, image styles, responsive image styles and breakpoints.

---

Web Assets is a **recipe / config-bundle module** (part of the Webship `web*` suite). It ships almost no PHP: enabling it runs `webassets_install()`, which applies `recipes/default`. That recipe grants media permissions to the content editor role and chains `recipes/foundation`, which turns on the media stack (Media, Media Library, Responsive Image, Image, File, Path, Crop, Focal Point, Media Remote Audio, Media Remote Image, Display Builder) and imports all the configuration those media types need. The result is **seven media types** (Image, Document, Audio, Video, Remote audio, Remote image, Remote video), local file fields with sensible allowed extensions, five media **view modes** (origenal, square, standard, traditional, ultrawide), **35 Focal-Point image styles** (five aspect-ratio families × seven sizes: tiny, small, medium, larg, xlarg, xxlarg, xxxlarg), five **responsive image styles** mapped onto **eight breakpoints** in the `webassets` group, and a Display Builder view display on the Image bundle's `standard` view mode — all without any clicking through the admin UI. Crop and Focal Point add art-directed cropping; the three remote bundles use core's oEmbed pipeline. Composer also pulls in Media Directories (`~2.2.0`), but the recipe does not enable it.

---

- Stand up a complete media library on a brand-new Drupal 11.4+ / 12 site with one `drush en webassets`.
- Give editors seven ready-made media types (Image, Document, Audio, Video, Remote audio, Remote image, Remote video) with no manual configuration.
- Provide a local Image media type whose file field accepts `png gif jpg jpeg`, with alt text required and Focal Point on the source field.
- Provide a Document media type accepting office/PDF/OpenDocument extensions (`txt rtf doc docx ppt pptx xls xlsx pdf odf odg odp ods odt fodt fods fodp fodg key numbers pages`).
- Provide Audio (`mp3 wav aac`) and Video (`mp4`) local media types backed by the Audio file / Video file field types.
- Embed remote video from YouTube and Vimeo through core's `oembed:video` source (Remote video bundle, `field_media_oembed_video`).
- Embed remote audio and remote image via the Media Remote Audio / Media Remote Image modules' oEmbed sources.
- Get 35 pre-built Focal-Point image styles across five aspect-ratio families (origenal, square, standard, traditional, ultrawide) at seven sizes each.
- Get five responsive image styles (origenal, square, standard, traditional, ultrawide) that map image derivatives onto the Web Assets breakpoints, with a fallback style.
- Register eight breakpoints under the `webassets` group (`sm`, `md`, `lg`, `xl`, `nav-md`, `nav`, `grid-md`, `grid-max`) for themes to reuse.
- Let a theme declare a `breakpoints` group named `webassets` to reuse the same media queries in its own responsive image styles.
- Serve art-directed, focal-point-aware crops per breakpoint so themes do not have to define their own image styles.
- Apply the whole media stack as a standalone Drupal recipe (`php core/scripts/drupal recipe .../recipes/default`) during site installation.
- Reuse just the media types/fields/styles without the Display Builder layer by applying `recipes/foundation` directly.
- Grant content editors `access media overview` plus per-bundle `create`/`edit own` media permissions automatically on install.
- Provide default form displays (default + media_library) for each local media type so the Add media dialog works out of the box.
- Provide a Display Builder-driven `standard` view display on the Image bundle rendering the image with the `standard` responsive image style.
- Give teams a consistent, opinionated media baseline shared across Webship sibling modules (Webpage, Webblog, Webseo).
- Bootstrap the Media Library UI for adding media of every type immediately after install.
- Serve responsive images with lazy loading enabled on the Image bundle's displays.
- Store uploaded media files in date-organised directories (`[date:custom:Y]-[date:custom:m]`).
