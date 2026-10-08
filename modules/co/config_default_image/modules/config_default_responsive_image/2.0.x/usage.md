Adds a **responsive** image field formatter with a config-deployable default image: same idea as Config Default Image but built on core's Responsive Image formatter (srcset/picture output).

---

A thin submodule of [Config Default Image](https://www.drupal.org/project/config_default_image). It
defines one formatter, `config_default_responsive_image` ("Responsive image or default responsive
image"), which extends core's `ResponsiveImageFormatter` and mixes in the parent project's
`ConfigDefaultImageFormatterTrait`. All the default-image logic — a VCS-tracked `path` plus
`alt`/`title`/`width`/`height`/`use_image_style` stored in the Manage Display formatter settings and
deployed via config management — is inherited unchanged; only the base formatter differs, so the
fallback renders through a responsive image style (`<picture>`/`srcset`) instead of a single `<img>`.
Requires the `config_default_image` and core `responsive_image` modules. No settings page,
permissions, or Drush of its own.

---

- Provide a deployable default image for a field displayed with a responsive image style.
- Show a fallback `<picture>`/`srcset` graphic when an author leaves a responsive image field empty.
- Keep a branded placeholder consistent across breakpoints and environments via config.
- Replace core's non-deployable default image on responsive image displays.
- Ship a git-tracked default hero image that adapts to device width.
- Use different responsive default images per view mode through Manage Display.
- Ensure teaser/card views always render a responsive placeholder image.
- Deploy the default responsive image with `drush cim` alongside the responsive image style config.
- Serve appropriately sized fallback images to reduce bandwidth on mobile.
- Standardize responsive placeholder imagery across a multisite deployment.
- Give designers repo-based control of the responsive fallback asset.
- Combine with the SVG submodule stack where responsive + SVG defaults are both needed.
- Roll back a responsive default image change through config history.
- Provide accessible alt text on the responsive fallback image.
- Avoid managed-file/orphan issues by storing the default as a path, not an upload.
