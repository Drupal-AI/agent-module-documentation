# hook_preprocess_responsive_image()

`avif.module` implements `template_preprocess_responsive_image()` (`avif_preprocess_responsive_image`).
This is what makes browsers actually request the AVIF variants; without it the AVIF controller is never
hit for responsive images.

For each existing `<source>` in `$variables['sources']`:

1. It finds the srcset attribute — `data-srcset` (used by the Blazy module) if present, else `srcset`;
   sources with neither are skipped.
2. It clones the source, rewrites its srcset with `Avif::getAvifSrcset()` (each `.png/.jpg/.jpeg` URL
   gains a `.avif` suffix), and sets `type` to `image/avif`.
3. All the new AVIF sources are prepended (`array_merge($avif_sources, $variables['sources'])`) so the
   browser evaluates `image/avif` first and falls back to the originals.

It also sets `$variables['output_image_tag'] = FALSE` so the template always renders a `<picture>` with
the multiple `<source>` elements rather than a single `<img>`.

Result markup (one AVIF source ahead of the original per breakpoint):

```html
<picture>
  <source srcset="…/derivative.jpg.avif?itok=… 360w, …" type="image/avif" sizes="…">
  <source srcset="…/derivative.jpg?itok=… 360w, …"      type="image/jpeg" sizes="…">
</picture>
```

Practical consequence: AVIF is delivered through Drupal's **responsive image** styles. Use a
Responsive image formatter (core `responsive_image`) on the fields where you want AVIF; a plain Image
formatter emits a single `<img>` and gets no AVIF source. The `<source>.avif` URLs resolve to the
`image.style_public` route, which the module's controller serves (see
[../api/avif_service.md](../api/avif_service.md)).

The module also implements `hook_help()` for its own help page (informational only).
