<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Placing a View as an EBT block

1. **Prerequisites:** install and enable `ebt_core` and `viewsreference` (both hard dependencies), plus the Media Image type EBT uses for backgrounds.
2. **Enable** `ebt_views` (`drush en ebt_views`). It installs the `ebt_views` block-content type with:
   - `field_ebt_views_views` — a Views Reference field (pick view + display, optionally arguments/pager).
   - `body` — optional text.
   - `field_ebt_settings` — shared EBT design/styling options.
3. **Create a block:** Content → Blocks → Add content block → *EBT Views*. Select the view and display, set EBT styling.
4. **Place it:** add the block in Layout Builder or at Structure → Block layout.
5. **Style:** background, spacing and classes come from `field_ebt_settings`; markup is themable via `templates/block--block-content--ebt-views.html.twig` and `block--inline-block--ebt-views.html.twig`.

The embedded view runs with its own access and cache metadata; this module adds no access layer of its own.
