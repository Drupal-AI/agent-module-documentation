<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ImageAPI Optimize WebP Responsive extends ImageAPI Optimize WebP to core Responsive Image fields, adding `<source type="image/webp">` entries so browsers that support WebP get the smaller WebP derivatives from a `<picture>` element.

---

This submodule of ImageAPI Optimize WebP hooks `template_preprocess_responsive_image()`. For the responsive image being rendered, it loads the `ResponsiveImageStyle` and each of its mapped image styles, and checks whether each image style's Image Optimize pipeline contains a processor with plugin id `imageapi_optimize_webp` (the WebP Deriver). For image styles that do, it builds a map from the styled derivative path to its `.webp` path and clones each `<source>` element, rewriting the `srcset` to the `.webp` URLs and setting `type` to `image/webp`. Those WebP sources are prepended to the existing sources (so a supporting browser picks WebP first) and it disables the plain `<img>` output fallback path (`output_image_tag = FALSE`) so the `<picture>` element is used. It requires the ImageAPI Optimize WebP module (and therefore ImageAPI Optimize) and has no configuration of its own — enable it, ensure your responsive image style's image styles use a pipeline containing the WebP Deriver, and WebP `<source>`s appear automatically. It only affects core responsive image rendering; non-responsive image formatters are handled by the parent module.

---

- Serve WebP `<source>` variants inside core Responsive Image (`<picture>`) fields.
- Give modern browsers smaller WebP images while older browsers keep the original format.
- Add WebP to an existing responsive image style without editing templates.
- Improve LCP/bandwidth for responsive hero and article images.
- Reuse one Image Optimize pipeline (with WebP Deriver) across all mapped image styles.
- Automatically emit `type="image/webp"` sources with rewritten `srcset`.
- Prepend WebP sources so supporting browsers prefer them in the `<picture>`.
- Keep the responsive breakpoints/art direction while adding a WebP layer.
- Deliver next-gen images on responsive image fields used by Media.
- Avoid manual `<picture>`/`<source>` markup for WebP.
- Combine responsive images with WebP derivatives generated on demand.
- Roll out WebP to responsive fields site-wide by enabling this submodule.
- Support both public and private responsive image derivatives as WebP.
- Reduce transfer for image-heavy responsive layouts and galleries.
- Ensure only image styles whose pipeline includes the WebP Deriver get WebP sources.
- Provide WebP fallbacks per breakpoint mapping in a responsive image style.
- Enhance Core Web Vitals on pages using responsive images.
- Let editors keep using responsive image formatters unchanged while gaining WebP.
- Complement the base module's non-responsive image handling for full WebP coverage.
- Serve WebP from a `<picture>` element that gracefully degrades on unsupported browsers.
