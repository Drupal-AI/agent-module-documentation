# Tooltip Taxonomy — agent index

Wraps taxonomy-term names found in rendered text fields with hover/focus tooltips showing the term description,
scoped by "filter condition" config entities. Depends on core `filter` + `field`. Config schema, no Drush,
no permissions.yml (uses admin permissions on routes/entity), no new plugin types.

- **The `filter_condition` config entity, its form/scoping fields, matching + escaping, the field formatter** →
  [configure/filter-condition.md](configure/filter-condition.md)
- **The theme hook / template, the CSS library, and the required text-format allowance** →
  [theming/tooltip.md](theming/tooltip.md)

Key facts:
- Config entity type `filter_condition` (prefix `tooltip_taxonomy.filter_condition.`); UI at
  `/admin/config/content/tooltip_taxonomy`; routes require `administer site configuration` OR
  `administer filters`; entity `admin_permission = administer site configuration`.
- Injection happens in `hook_entity_display_build_alter()` → service `tooltip_taxonomy.tooltip_manager`
  (`TooltipManager::addTooltip()`), on `body` and `field_*` text fields (`text`, `text_long`,
  `text_with_summary`, `string_long`).
- Term description is sanitized with `Xss::filter()` (allowed tags default `<b><i><strong><span><br><a>`);
  term name is autoescaped by the Twig template. No new-plugin-type or Drush surface.
- Field formatter `tooltip_taxonomy` renders an entity_reference→taxonomy_term field as a tooltip.
