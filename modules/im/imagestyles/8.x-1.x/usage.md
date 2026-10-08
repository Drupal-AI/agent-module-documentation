Image Style Preview renders every image style derivative on an image media entity's page so you can see, not read, what each style produces.

---

Drupal's image style administration lists styles by name and describes their effects in prose; it never shows the result. Image Style Preview closes that gap. It hooks into the media view (`imagestyles_preprocess_media`) and, on the canonical page of an image media entity, replaces the normal image-field output with a stack of collapsible `details` elements — one for every configured image style, plus the original image — each showing the styled derivative and a summary of the style's effects, with an anchor-link index at the top. A tiny admin form at `admin/config/media/image-styles/imagestyles` lets you pick which styles start expanded. The module targets image media entities only, needs core's Image and Media modules, and expects Standalone media URLs to be enabled so the media page is reachable. Because it renders each style on demand, the first view of a media page generates all missing derivatives (slow once, cached afterwards). Its only route is the settings form, gated by `access administration pages`.

---

- See what each image style actually produces, rendered on one page.
- Compare all image styles for a given image side by side.
- Identify which style matches a particular display size.
- Untangle a site that has accumulated many similarly named styles.
- Decide which image styles are safe to delete.
- Review an effect chain visually instead of reading its summary.
- Verify a newly created style before wiring it into a display.
- Audit a project's image styles as part of a cleanup.
- Explain to a designer how a style crops or scales.
- Check the original image's dimensions alongside its derivatives.
- Choose which styles show expanded by default via the settings form.
- Confirm a responsive image mapping renders as intended.
- Spot styles that produce identical or near-identical output.
- Review styles after changing a theme or breakpoint set.
- Pre-generate derivatives for a sample image by loading its media page.
- Document, per project, which styles are in active use.
- Give content editors a quick reference for available crops.
- Sanity-check a style's upscale/quality settings on a real photo.
- Inspect how an effect summary maps to visual output.
- Plan an image style consolidation with visual evidence.
