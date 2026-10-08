Background Images Formatter adds an image-field formatter that renders the uploaded image as a CSS `background-image` on a selector you choose, instead of an inline `<img>` tag.

---

The module ships a single field formatter (`bg_image_formatter`, label "Background Image") for any `image` field, chosen on an entity's **Manage display** screen. Rather than emitting an `<img>`, it builds a CSS rule and injects it into the page `<head>` (or, for AJAX responses, attaches it as an `AddCssCommand`). In the formatter settings you provide a CSS **selector** (one per line; tokens are supported), an optional **image style**, and a set of background CSS properties: background color, horizontal/vertical position, attachment (scroll/fixed), repeat, background-size (with optional IE8 `AlphaImageLoader` fallback for `cover`), z-index, a linear-gradient overlay, a media query, and whether to append `!important`. An image-path-format option chooses absolute or relative URLs (relative helps avoid mixed-content warnings on HTTPS). For multivalue image fields the selectors and colors are applied round-robin, one per delta, so several images can theme several elements. The selector supports both entity tokens (via the token tree) and Views field tokens (`{{ ... }}`). The formatter extends core's `ImageFormatter`, so it reuses image-style loading and URL generation. A companion submodule, **responsive_bg_image_formatter**, swaps the plain image style for a responsive image style and emits one media-query rule per breakpoint. Typical use is hero banners, section backgrounds, and cards where the background image comes from editorial content rather than a static theme asset.

---

- Render an image field as a CSS background on `body` for a full-page background.
- Set a hero section's background from an editor-uploaded image field.
- Apply an image style (e.g. a cropped/scaled derivative) to the background image.
- Target a specific block or region with a custom CSS selector.
- Use `background-size: cover` so the image fills its container responsively.
- Position the background with horizontal/vertical alignment values.
- Make the background fixed (parallax-style) via the attachment setting.
- Control tiling with the repeat option (no-repeat, repeat, repeat-x, repeat-y).
- Add a background color behind or beside the image.
- Layer a `linear-gradient(...)` overlay on top of the background image.
- Restrict the background to a breakpoint using a CSS media query.
- Append `!important` to override a theme's existing background rules.
- Set a `z-index` for stacking the styled element.
- Theme several elements from one multivalue image field (round-robin selectors).
- Assign a different color per value of a multivalue field (round-robin colors).
- Inject an entity token (e.g. node ID) into the selector to scope styles per node.
- Use a Views field token (`{{ ... }}`) in the selector inside a View.
- Emit relative image URLs to avoid mixed-content errors on HTTPS sites.
- Add IE8 `cover` support via the AlphaImageLoader filter fallback.
- Give cards or teasers per-item background images pulled from their fields.
- Configure the formatter entirely from Manage display with no PHP.
- Export the formatter settings as display config between environments.
- Keep background CSS out of the theme so non-developers can manage it.
- Combine with responsive_bg_image_formatter for breakpoint-specific backgrounds.
