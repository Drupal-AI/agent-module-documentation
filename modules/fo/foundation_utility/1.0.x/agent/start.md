<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Foundation Utility (foundation_utility) — agent index

**Text-format filter that adds Foundation table classes (`.scroll/.hover/.unstriped/.stack`) and strips width/height/style attributes.**

- **Version:** 1.0.x
- **Core:** ^9.5 || ^10 || ^11
- **Depends on:** ckeditor5, editor
- **Filter:** `foundation_utility_table_filter` → `\Drupal\foundation_utility\Plugin\Filter\TableFilter` (`TYPE_TRANSFORM_IRREVERSIBLE`); uses Symfony DomCrawler.
- **Settings:** `table_add_scroll`, `table_remove_width_height`, `table_remove_style`, `table_add_hover`, `table_add_unstriped`, `table_add_stack`.
- **Config:** enable per text format at `/admin/config/content/formats`.
- **Security:** no routes/permissions of its own; filter only removes attributes and appends CSS classes (no new user-controlled markup introduced).