Adds an **SVG-compatible** image field formatter with a config-deployable default image: Config Default Image's fallback logic built on the [SVG Image](https://www.drupal.org/project/svg_image) formatter.

---

A thin submodule of [Config Default Image](https://www.drupal.org/project/config_default_image). It
defines one formatter, `config_default_svg_image` ("Image or default image (SVG compatible)"), which
extends the SVG Image module's `SvgImageFormatter` and mixes in the parent project's
`ConfigDefaultImageFormatterTrait`. It inherits the whole default-image mechanism — a VCS-tracked
`path` plus `alt`/`title`/`width`/`height`/`use_image_style` stored in Manage Display and deployed
via config — while rendering through the SVG-aware base formatter, so a `.svg` file (or raster) can
serve as the deployable fallback. Requires `config_default_image` and `svg_image`. It also ships a
nested submodule, **config_default_responsive_svg_image**, combining SVG + responsive. No settings
page, permissions, or Drush of its own.

---

- Use a git-tracked SVG as the deployable default image for an image field.
- Show a scalable vector placeholder/logo when an author leaves an image field empty.
- Replace core's non-deployable default image on displays that must support SVG.
- Keep a crisp vector "no image" graphic consistent across environments via config.
- Provide a default brand mark that renders sharply at any resolution.
- Deploy the SVG default with `drush cim` alongside the field display config.
- Use different SVG defaults per view mode through Manage Display.
- Serve lightweight vector placeholders to reduce image weight.
- Standardize vector placeholder imagery across a multisite.
- Give designers repo-based control of the SVG fallback asset.
- Combine with the responsive SVG submodule for adaptive vector defaults.
- Provide accessible alt/title text on the SVG fallback.
- Fall back to a vector icon for icon-like image fields left empty.
- Roll back an SVG default change through config version history.
- Avoid managed-file/orphan issues by storing the default as a path, not an upload.
