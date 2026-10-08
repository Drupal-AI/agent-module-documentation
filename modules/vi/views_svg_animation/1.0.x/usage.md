<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views SVG Animation provides a Views style plugin (`svg_animation`) that extends Drupal core's Table style and layers interactive animation of one or more SVG files onto the rendered rows.

---

The problem it solves is presenting tabular view data together with animated vector graphics driven by that data: the style plugin (`src/Plugin/views/style/SvgAnimation.php`) reuses core table preprocessing (`template_preprocess_views_view_table`) and then augments it — `getRowsAttributes()` adds per-row attributes and `getDrupalSettings()` passes SVG/animation configuration to a JavaScript library (`views_svg_animation/generic`) attached in `template_preprocess_views_view_svg_animation`. SVG assets are resolved through core Media and File storage plus the file URL generator, so the animated SVGs are managed media entities referenced by the view.

Operational/security notes: this is a display/theming layer configured by site builders with "administer views" — it exposes no routes, permissions, or mutating endpoints, and reads SVG files from managed media/file entities via the file URL generator rather than from request input. It depends on core `media` and `views` and requires PHP >= 8.1. Typical setup: enable the module, set a view's Format to "SVG Animation", map the SVG media/file field and the row attributes that drive the animation, then configure the animation options exposed to the front-end library.
---
- Render a Views table whose rows drive SVG animations.
- Attach one or more managed-media SVG files to a view.
- Animate an SVG based on per-row data attributes.
- Reuse core table columns, sorting, and styling under the animation layer.
- Pass animation settings to the front-end via drupalSettings.
- Map a Media (SVG) field into the animated style.
- Build interactive infographics from a content listing.
- Add per-row attributes that the JS animation reads.
- Serve SVG assets through the core file URL generator.
- Combine tabular data with vector visualizations in one display.
- Present status/progress rows with animated SVG indicators.
- Drive an animated map or diagram from taxonomy/content rows.
- Keep table accessibility while adding SVG motion.
- Configure animation behavior per view display.
- Use managed media so SVGs respect file access and revisions.
