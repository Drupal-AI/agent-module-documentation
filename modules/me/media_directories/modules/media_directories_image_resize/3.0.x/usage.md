<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Directories Image Resize is a single text filter that finds `<img>` tags carrying explicit `width` and `height` attributes, generates a physically resized derivative of the source file and rewrites the `src` to point at it.

---

The whole module is one filter plugin, `Drupal\media_directories_image_resize\Plugin\Filter\ImageResize` (id `media_directories_image_resize`, title "Resize images", `TYPE_TRANSFORM_REVERSIBLE`, weight 20). `process()` early-returns unless the text contains `<img `, then XPath-selects `//img[@width and @height and @src]`. For each match it resolves the `src` back to a `public://` stream URI (parsing the path, matching the public files directory, and requiring the file to exist), skips anything ending in `.svg` because vector images cannot be bitmap-resized, and computes a derivative URI of the form `public://resize/{width}x{height}/{original relative path}`. If that derivative does not already exist it creates the target directory, loads the source through `image.factory`, bails out when the image is invalid **or already exactly the requested size**, calls `$image->resize($width, $height)` and saves. On success the `src` attribute is replaced with `file_url_generator->generateString($derivative_uri)`; the `width`/`height` attributes are left in place. External URLs, private-scheme files and images without both dimensions pass through untouched. There is no settings form, no config object, no permissions, no schema and no services — the only thing to configure is enabling the filter on a text format and placing it *after* any filter that inserts images. Note it depends only on core `filter` and `image`, not on `media_directories` itself, so it can be used stand-alone.

---

- Physically shrink an inline image an editor resized in CKEditor rather than scaling it in CSS.
- Stop shipping a 4000px original to render a 300px inline image.
- Generate resized derivatives on demand, cached on disk under `public://resize/{w}x{h}/`.
- Apply resizing to any `<img width height>` in rich text, regardless of which module produced it.
- Combine with `media_directories_browser`'s image-options plugin, which emits `data-width`/`data-height`.
- Use it after `media_directories_compat` so converted legacy embeds get real derivatives.
- Keep the `width`/`height` attributes in the markup so the browser reserves layout space (no CLS).
- Avoid building an image style per size an editor might pick.
- Skip SVG logos automatically so they are never rasterised.
- Leave external/CDN images alone because only `public://` sources are resolved.
- Avoid pointless work: images already at the requested size are not re-encoded.
- Serve mixed sizes of the same source image in one article.
- Purge all generated derivatives by deleting the `public://resize` directory.
- Add the filter to a Full HTML format used by editorial staff.
- Place it after the "Embed media" filter so media-generated `<img>` tags are also processed.
- Keep it away from formats where users can inject arbitrary `<img>` tags for untrusted sources.
- Resize images stored in nested public subdirectories (the relative path is preserved in the derivative path).
- Use it stand-alone without the rest of Media Directories (it only depends on core `filter` and `image`).
- Debug a resize by checking whether `public://resize/{w}x{h}/…` was written.
- Understand why nothing happened: missing `width` or `height`, a non-public `src`, or an SVG.
- Pair it with a CDN so derivatives are cached at the edge after first generation.
- Regenerate derivatives after replacing a source file by clearing the matching `resize` folder.
- Cap effective bandwidth for image-heavy landing pages built in the WYSIWYG.
- Give editors "drag to resize" behaviour that produces real, smaller files.
