Provides image field **formatters** whose default (fallback) image is a VCS-tracked file path stored in configuration, so the default image deploys with `drush cim`/`cex` instead of relying on an untracked uploaded file.

---

Drupal core's built-in default-image feature references an uploaded *file entity by UUID*: config
management exports the field config but not the file content, so the default image does not deploy
between environments. Config Default Image solves this by adding a field formatter,
`config_default_image` ("Image or default image"), that extends core's `ImageFormatter` and stores
the default image as a **path string** (e.g. `themes/custom/my_theme/img/default.jpg`) plus `alt`,
`title`, `width`, `height`, and a `use_image_style` flag inside the *Manage Display* formatter
settings — all captured by config export. At render time, if the field has no value, the formatter
synthesizes a runtime `File` entity from that path and hands it to the parent image formatter so it
renders exactly like a normal image (including image-style support). Because Drupal image styles
need a stream-wrapper scheme, when `use_image_style` is on and the path has no scheme, the file is
copied once into `public://config_default_image/…` so a style derivative can be generated. The path
is meant to point at a git-managed image (in a custom module/theme) committed alongside the config.
Three submodules apply the same trait to other formatters: **config_default_responsive_image**
(core Responsive Image), **config_default_svg_image** (SVG Image), and, nested under the SVG one,
**config_default_responsive_svg_image**. No admin page, no permissions, no Drush.

---

- Ship a deployable default/fallback image for an image field that survives `drush cim` across environments.
- Replace core's UUID-based default image (which doesn't deploy) with a config-tracked file path.
- Set a placeholder avatar for a user picture field that is versioned in git.
- Provide a default hero/teaser image per content type view mode via Manage Display.
- Show a branded "no image" graphic when an author leaves an image field empty.
- Keep the default image identical on dev, staging, and prod by committing it with the config.
- Apply an image style to the fallback image so it matches uploaded images' dimensions.
- Use a theme-hosted logo/illustration as the default without uploading it through the media library.
- Define different default images for different display modes of the same field.
- Provide a responsive (srcset) default image using the config_default_responsive_image submodule.
- Use an SVG default image via the config_default_svg_image submodule.
- Combine responsive + SVG defaults with config_default_responsive_svg_image.
- Set default `alt`/`title` text for accessibility on the fallback image.
- Avoid orphaned/managed-file cleanup issues by not storing the default as a real uploaded file.
- Give designers control of default imagery through code review (image lives in the repo).
- Standardize placeholder imagery across a multisite by deploying one config + asset.
- Migrate legacy sites that relied on core default images into a config-deployable setup.
- Render a fallback product photo on catalog pages where some products lack images.
- Ensure a default image appears in RSS/JSON output the same way a real image would.
- Roll back a default image change through config version history like any other setting.
