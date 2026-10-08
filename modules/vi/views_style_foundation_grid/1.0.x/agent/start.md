<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Foundation Grid Views Style — agent start

**What**: Views style plugin `views_style_foundation_grid` rendering rows on the ZURB
Foundation XY grid. Depends on `views` and the `foundation_sites` module (Foundation CSS).

## Set up
1. Ensure `foundation_sites` is installed, then `drush en views_style_foundation_grid -y`.
2. Edit a view → **Format → Foundation Grid** → open settings.
3. Set per-breakpoint cell columns (`cells_small`/`medium`/`large`, x of 12; `auto`/none),
   gutter type + direction, orientation, grouping title markup, and custom grid/cell classes.

## Key facts
- Class: `Drupal\views_style_foundation_grid\Plugin\views\style\FoundationGrid`
  (`usesRowPlugin=TRUE`).
- Preprocess: `template_preprocess_views_view_foundation_grid()` builds grid/row Attributes.
- Template: `views-view-foundation-grid.html.twig`.
- Custom cell classes support Views field tokens; `getCustomCellClass()` runs them through
  `strip_tags()` + `Html::cleanCssIdentifier()` (safe class output).
- Config schema present (`views.style.views_style_foundation_grid_foundation_grid`).
- No routes/permissions; all config is per view.
