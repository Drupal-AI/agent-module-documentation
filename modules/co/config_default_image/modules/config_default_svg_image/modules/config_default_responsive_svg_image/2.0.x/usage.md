Combines responsive **and** SVG support in one config-deployable default-image formatter: Config Default Image's fallback logic on top of SVG Image's responsive formatter.

---

The most specialized submodule of
[Config Default Image](https://www.drupal.org/project/config_default_image), nested under Config
Default SVG Image. It defines one formatter, `config_default_responsive_svg_image`
("Responsive image or default responsive image (SVG compatible)"), extending
`svg_image_responsive`'s `SvgResponsiveImageFormatter` and mixing in the parent project's
`ConfigDefaultImageFormatterTrait`. It inherits the full config-deployable default mechanism — a
VCS-tracked `path` plus `alt`/`title`/`width`/`height`/`use_image_style` stored in Manage Display —
and renders it through a base formatter that is both responsive and SVG-aware. Depends on
`config_default_svg_image` (its parent submodule) and core `responsive_image` (and, transitively,
SVG Image's responsive submodule). No settings page, permissions, or Drush of its own.

---

- Provide a deployable default image that is both responsive and SVG-compatible.
- Show a scalable vector `<picture>`/`srcset` placeholder when a field is left empty.
- Serve a crisp vector default that also adapts to breakpoints.
- Replace core's non-deployable default image on responsive SVG-capable displays.
- Keep a vector brand placeholder consistent across breakpoints and environments via config.
- Deploy the responsive SVG default with `drush cim` alongside the display config.
- Use different responsive SVG defaults per view mode through Manage Display.
- Standardize adaptive vector placeholder imagery across a multisite.
- Give designers repo-based control of the responsive SVG fallback asset.
- Provide accessible alt/title text on the responsive SVG fallback.
- Roll back a responsive SVG default change through config history.
- Reduce image weight with a lightweight adaptive vector placeholder.
- Cover the responsive + SVG edge case that neither sibling submodule handles alone.
- Ensure teaser/card responsive displays always render a vector placeholder.
- Avoid managed-file/orphan issues by storing the default as a path, not an upload.
