Color lets site administrators change the color scheme (links, backgrounds, text and other elements) of compatible themes through a live-preview color picker on the theme settings page.

---

Color is the former Drupal core module, now maintained as a contrib project, that gives users with the *Administer site configuration* permission a point-and-click way to recolor compatible themes without editing CSS. On a theme that opts in (by shipping a `color/color.inc` file describing its palette, stylesheets and any images), the theme settings form gains a **Color scheme** section with a farbtastic color picker, predefined color sets, per-element hex fields and an HTML preview. On save it validates the hex values, then writes a recolored copy of the theme's stylesheets — and, when the theme provides a base image, GD-rendered images and logo — into the public files directory, storing the palette and generated file paths in a `color.theme.<theme>` config object. `hook_library_info_alter()` swaps the theme's declared stylesheets for the recolored ones at render time, and a config event subscriber invalidates the `library_info` cache tag whenever the palette changes so the new files take effect. It requires the PHP GD library (with PNG support) to render themed images. It only affects themes that declare color support, so incompatible themes simply show no color picker.

---

- Let a site admin recolor a compatible theme from the Appearance UI without touching CSS.
- Pick a predefined color set (scheme) shipped by the theme.
- Enter custom hex values for individual theme elements (base, text, link, etc.).
- Preview color changes live before saving via the built-in HTML preview.
- Use the farbtastic color-wheel picker to choose colors visually.
- Generate recolored copies of a theme's stylesheets automatically on save.
- Recolor a theme's logo and header images through GD rendering.
- Apply a recolored logo to the system branding block automatically.
- Store per-theme palettes as `color.theme.<theme>` configuration for export/deploy.
- Roll a theme back to its default palette by re-selecting the default scheme.
- Give each compatible theme its own independent color scheme.
- Make a custom or contrib theme color-compatible by adding a `color/color.inc` file.
- Define named color schemes and per-field labels for a theme you maintain.
- Provide gradient and image-slice definitions so a theme's imagery recolors with the palette.
- Blend arbitrary stylesheet colors from a base color using the module's color-shift algorithm.
- Preserve specific colors from recoloring with a "Color Module: Don't touch" stylesheet section.
- Keep generated color assets in sync automatically via cache-tag invalidation on config save.
- Enforce valid hexadecimal color input and guard the JS preview against XSS/CSRF.
- Warn admins when PHP lacks GD/PNG support needed to render themed images.
- Migrate Drupal 7 theme color settings into Drupal 9/10/11 via the bundled migrations.
- Provide theme-specific preview markup by pointing `color.inc` at a custom preview HTML file.
- Re-save color settings to regenerate stylesheets after editing a theme's source CSS.
- Maintain distinct brand color schemes across a multi-theme or multisite install.
- Let non-developers experiment with branding colors safely in the admin UI.
- Keep color config out of theme settings so it can be deployed independently.
