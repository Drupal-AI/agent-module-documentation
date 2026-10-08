<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Normalized Image Styles (normalized_image_styles) — agent index

**Generates aspect-ratio-based image style sets (normalized dimensions) via migrate_plus, for core Responsive Image.**

- **Version:** 2.1.x  •  core: `^10 || ^11`
- **Dependencies:** image, migrate, image_style_generate, migrate_plus, migrate_tools, focal_point, image_style_quality
- **Structure:** a parent module + ~40 config-only sub-modules (one migration per aspect ratio, plus a WebP twin of each) under a shared `normalized_image_styles` migration group.
- **No routes / permissions / services of its own.** Operated via the Extend page, the core Migrate UI, and Drush migrate commands. Import tag: `normalized`.
- **Security:** no custom routes, endpoints, permissions, or callbacks; enabling/importing is gated by core module-admin and migrate permissions. No anonymous or mutating surface. No security findings.

See [drush/migrations.md](drush/migrations.md) for the enable/import/rollback workflow.
