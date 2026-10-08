Responsive Background Images Formatter renders an image field as a CSS `background-image` that swaps by breakpoint, using a Drupal responsive image style to emit one media-query rule per source.

---

This submodule of Background Images Formatter adds the `responsive_bg_image_formatter` formatter ("Responsive Background Image") for `image` fields, subclassing `BgImageFormatter`. Instead of a single background rule, it takes a **responsive image style** (from core `responsive_image`) and, in `viewElements()`, runs `template_preprocess_responsive_image()` to expand that style into per-breakpoint sources. For each `<source>` and each `srcset` candidate it generates a separate CSS rule scoped to that source's media query, so the browser loads the right-sized image at each viewport. Retina candidates (`2x`) get an extra `-webkit-min-device-pixel-ratio: 2` / `min-resolution: 192dpi` media query, and it patches a core bug that produced an invalid `screen (max-width...)` media rule. It reuses the parent's `getBackgroundImageCss()` and head-attachment logic (including the AJAX `AddCssCommand` path), so the same selector, color, position, size, gradient and `!important` settings apply — but the plain **image style** selector is replaced with a **responsive image style** selector, and the manual **media query** field is removed (media queries now come from the responsive style's breakpoints). Configuration is on the entity's **Manage display** screen; there is no separate admin page. It requires both `bg_image_formatter` and core `responsive_image`, and does nothing unless a responsive image style is selected.

---

- Serve a different background image per breakpoint from one image field.
- Load smaller background images on mobile and larger ones on desktop.
- Drive responsive backgrounds from a core responsive image style's breakpoints.
- Provide retina (2x / high-DPI) background variants automatically.
- Set a full-page responsive background on `body`.
- Give a hero region breakpoint-specific background art.
- Reuse an existing responsive image style for element backgrounds.
- Apply `background-size: cover` for responsive hero images across viewports.
- Target a custom selector with responsive background CSS.
- Use tokens (entity/user and Views `{{ }}`) in the selector, as with the parent.
- Theme multivalue image fields with round-robin selectors, responsively.
- Add a gradient overlay on a responsive background image.
- Keep responsive background CSS out of the theme, managed via Manage display.
- Avoid mixed-content warnings with relative image URLs on HTTPS.
- Override theme backgrounds with `!important` on responsive rules.
- Export the responsive formatter settings as display config between environments.
- Replace srcset-based `<img>` responsiveness with background-image responsiveness.
- Deliver art-directed backgrounds using the responsive style's per-source media rules.
