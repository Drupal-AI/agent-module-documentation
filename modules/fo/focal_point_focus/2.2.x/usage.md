Focal Point Focus is an image field formatter that renders an image at its full size inside a fixed-height, `overflow:hidden` container and uses the stored Focal Point crop position to keep the chosen subject in view. A bundled jQuery plugin (jquery-focuspoint) shifts the oversized image so the focal point stays centred as the container width changes.

---

Focal Point Focus adds a **`focal_point_focus`** field formatter for `image` fields. It requires the `focal_point` and `crop` modules to store a per-image focal point, but unlike Focal Point's own image-style cropping it does **not** create a derivative — the original file is output as-is inside a `<figure><div class="focuspoint">` wrapper. You set a **display height** per view mode; the container is that height at 100% width, the image is absolutely positioned and scaled to fill (`min-width/height:100%`), and the jquery-focuspoint script computes `top`/`left` offsets from `data-focus-x`/`data-focus-y` so the focal point stays visible at any responsive width. Focal coordinates are normalised server-side to a `-1..1` range from the crop's pixel position. Formatter settings cover first-image-only (multivalue), muting the image `title` (otherwise emitted as `<figcaption>`), a `loading` attribute (none/lazy/eager), and — when core **Breakpoint** is enabled — a Breakpoint Group whose per-breakpoint heights are written into a scoped `<style>` block of `@media` rules and mirrored into `drupalSettings` for a JS `matchMedia` fallback. Output is a Twig template (`focal-point-focus.html.twig`) you can override. This is not an Imagecache/responsive-`srcset` module and it is not a Breakpoint provider — media queries come from whatever module/theme defines the chosen Breakpoint Group.

---

- Keep a subject (face, logo, product) in frame when an image fills a fixed-height banner or hero region of variable width.
- Render an image field at a chosen display height without generating a cropped image-style derivative for every aspect ratio.
- Apply an editor-set Focal Point to front-end display, not just to Focal Point's own image-style crops.
- Build a full-width hero band that re-centres on the focal point as the viewport resizes.
- Serve one original image across many container widths and let JavaScript reposition it live.
- Show a `<figcaption>` caption automatically from an image field's `title` value.
- Suppress the caption on decorative images by enabling "Mute Title".
- Display only the first image of a multivalue image field (e.g. a gallery teaser).
- Add browser-level lazy loading (`loading="lazy"`) or eager loading to formatter output.
- Set different display heights per view mode (teaser vs full) for the same image field.
- Vary the rendered height by responsive breakpoint using a core Breakpoint Group.
- Reuse a theme's existing Breakpoint Group so display heights track the theme's own media queries.
- Use different Breakpoint Groups (or different heights) on different fields of the same bundle.
- Mute a specific breakpoint's height (0/empty) so that clause drops out of the generated CSS.
- Fall back a breakpoint to the default height by entering `-1`.
- Override the shipped Twig template to change the `<figure>`/`<div>` markup wrapping the image.
- Theme card grids where each card image must stay centred on its subject at a uniform height.
- Present portrait and landscape uploads in a single uniform-height row without manual cropping.
- Avoid storing many per-aspect-ratio crops, reducing derivative image storage.
- Visually debug which breakpoint is active during theming via the State-flag dashed-outline test mode.
- Give editors control over image focus once and have it honoured across every display that uses this formatter.
- Render avatars or profile images at a fixed height while keeping the face in view.
- Build magazine-style layouts where hero images crop responsively around their subject.
- Combine with a lazy-loading strategy to defer large hero images below the fold.
