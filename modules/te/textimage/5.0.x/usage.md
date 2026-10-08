<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Textimage renders text onto images on the fly by pairing Image Effects' "Text overlay" effect with field values, and adds Text/Image field formatters, a fluent PHP API, tokens, and optional direct-URL generation to build those images.

---

Textimage is a Media-package add-on for the core Image module and the contrib Image Effects module. Its core idea is that an image style containing one or more "Text overlay" effects becomes a template: the effect's "Default text" is replaced at render time by text coming from a field value, the Textimage API, or a URL path. The module ships two field formatters — `textimage_text_field_formatter` (for `text`, `text_long`, `text_with_summary`) and `textimage_image_field_formatter` (for `image`) — that feed field content into such a style and output an `<img>`. A `textimage.factory` service exposes a fluent builder (`->setStyle()->process()->buildImage()`) so images can be produced programmatically, with a caching layer keyed on style+text and a `textimage_formatter` theme hook for rendering. Two tokens, `[node:textimage-url:field]` and `[node:textimage-uri:field]`, return the location of a generated image. A settings form at `/admin/config/media/textimage` controls the default output extension, a default font, URL-based generation (gated by the `generate textimage url derivatives` permission and a configurable text separator), and debug logging. Image styles gain a "Textimage options" third-party setting choosing the destination stream wrapper (e.g. public vs private) for Textimage derivatives. Generated files live under a `textimage`/`textimage_store` directory tree served by custom path processors and controllers; temporary/preview images are cleaned up on cron. It requires the GD2 and FreeType PHP libraries plus at least one available font file.

---

- Generate crisp heading images where field text is drawn over a styled background via a "Text overlay" image effect.
- Turn a plain-text field (e.g. a title or tagline) into a rendered image using the Textimage text formatter.
- Overlay a caption or watermark text onto an uploaded image field with the Textimage image formatter.
- Build banner/hero images on the fly whose text comes from node fields instead of hand-made graphics.
- Use tokens like `[node:title]` inside a "Text overlay" effect so each node produces its own image.
- Produce multiple images from a multi-value text field, one image per value, or one image consuming all values sequentially.
- Link a generated Textimage to its node (`content`) or to the image file, per formatter settings.
- Set custom `alt` and `title` attributes (with token support) on the generated image for accessibility/SEO.
- Create images programmatically from an image style with `\Drupal::service('textimage.factory')->get()->setStyle(...)->process([$text])->buildImage()`.
- Build images from a dynamic set of effects (not a stored style) via the API's `setEffects()`.
- Retrieve a generated image's URL or URI in Twig/render arrays through the `[node:textimage-url:field]` / `[node:textimage-uri:field]` tokens.
- Defer image building to a later request by processing metadata now (`process`) and generating on demand (`load` + `buildImage`).
- Store Textimage derivatives in the private file system by setting the image style's "Image destination" Textimage option.
- Expose a public URL endpoint that generates images from path text, restricted to users with `generate textimage url derivatives`.
- Configure a text separator (default `---`) so URL-based generation can push several strings to separate "Text overlay" effects.
- Set a site-wide default output format (png/gif/jpg) for Textimage-generated images.
- Register a default font file so text effects always have a font to render with.
- Generate one-off preview/temporary images that are not cached and are removed on cron via `setTemporary()`.
- Overlay text on a background image supplied at runtime with `setSourceImageFile()`.
- Resolve `user`, `node`, and `file` context tokens in overlaid text through the built-in formatters.
- Flush all Textimage-generated files and metadata from the settings page "Cleanup Textimage" action.
- Set the GIF transparency color for generated images with `setGifTransparentColor()`.
- Apply lazy-loading (`loading` attribute) to Textimage image-field output.
- Produce social-share / Open Graph style images whose text is driven by content fields.
- Combine "Text overlay" with other Image Effects (resize, background, convert) to fully control the derivative.
- Cache generated images keyed on style + resolved text so identical requests reuse the same file.
- Serve private Textimage derivatives with access control via the module's `hook_file_download` implementation.
- Build a custom field formatter on top of the API to pass your own node/file context for token resolution.
