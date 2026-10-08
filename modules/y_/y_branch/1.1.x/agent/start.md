<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y Branch (y_branch) — agent index

Turns the **Branch** content type of the YMCA Website Services (Open Y) distribution into a
Layout Builder-composed page. It has no routes, forms, permissions or config of its own; everything
happens through three mechanisms. (1) `hook_install()` scaffolds the Branch bundle: it creates three
node fields (`field_use_layout_builder`, `field_branch_menu_links`, `field_more_hours_link`),
rearranges the Branch form into field groups, wires the widgets/formatters, and stamps a full,
pre-built Layout Builder layout (WS header, branch header, branch menu, social links, body,
amenities, WS footer) plus layout/block restrictions onto the Branch `full` view display. (2)
`hook_entity_type_alter()` swaps the `entity_view_display` entity class for
`YBranchLayoutBuilderEntityViewDisplay`, which suppresses the Layout Builder sections whenever a
node's `field_use_layout_builder` boolean is off — that field is the per-node LB on/off switch. (3)
It ships a public service `y_branch.hours_helper` (`BranchHoursHelper`) that reads the Branch's
`field_branch_hours` / `field_branch_holiday_hours` and returns render-ready tables and JS settings
for regular and holiday hours — this service is consumed by other Open Y modules/templates, not by
y_branch itself.

- Depends on (info.yml, all Open Y/YMCA modules): `y_lb`, `openy_loc_branch`,
  `lb_branch_social_links_blocks`, `lb_branch_amenities_blocks`, `y_branch_menu`. That dependency list
  is effectively the branch page's block vocabulary.
- Core: `^10 || ^11`. Package: `YMCA Website Services`. Version `1.1.1`. License GPL-2.0-or-later.
- No settings page / `configure` route. No permissions. No drush. No plugin types. No config schema.
- One service, three hooks, one entity-class override, two theme hooks, one CSS library.
- **Not enable-testable in this project.** Composer resolves the unconstrained `y_lb` requirement to
  the only Packagist release `ycloudyusa/y_lb` 0.1 (2022, `core_version_requirement: ^8 || ^9`), so
  Drupal refuses to enable the chain ("dependency module 'y_lb' is incompatible with this version of
  Drupal core"). The real `y_lb` (3.x–5.x) lives in the YMCA composer repository. Everything below is
  read from source.

## What you'd do → where

- **Understand/toggle Layout Builder per branch, or the entity-display class swap and the theme
  hooks** → [hooks/hooks.md](hooks/hooks.md)
- **Know which node fields, field groups, widgets and the default LB layout the install creates on
  the Branch bundle** → [fields/fields.md](fields/fields.md)
- **Call the branch-hours / holiday-hours helper service from a module or preprocess** →
  [api/hours-helper.md](api/hours-helper.md)

## Key facts (real machine names)

- Service: `y_branch.hours_helper` → `Drupal\y_branch\BranchHoursHelper`
  (args `@config.factory`, `@datetime.time`). Methods: `getBranchHours()`, `getLazyBranchHours()`,
  `getBranchHolidayHours()`, `getLazyBranchHolidayHours()`, `getWeekdayNames()`, `getTimezone()`.
- Hooks: `y_branch_entity_type_alter`, `y_branch_theme`,
  `y_branch_form_node_branch_layout_builder_form_alter`.
- Entity class override: `Drupal\y_branch\Entity\YBranchLayoutBuilderEntityViewDisplay`
  (extends `LayoutBuilderEntityViewDisplay`; `buildSections()` returns `[]` when
  `field_use_layout_builder` is false).
- Theme hooks: `node__branch__lb` (template `node--branch--lb.html.twig`, base hook `node`),
  `page__node__branch` (template `page--node--branch-lb.html.twig`, base hook `page`).
- Library: `y_branch/y_branch` (CSS `assets/css/y_branch.css`), attached to the branch node theme and
  to the `node_branch_layout_builder_form` form.
- Node fields created (node/branch bundle): `field_use_layout_builder` (boolean),
  `field_branch_menu_links` (link, cardinality -1), `field_more_hours_link` (link),
  `field_show_all_holidays` (boolean, added by `y_branch_update_91004`).
- Field groups: creates `group_branch_menu`; adds `field_more_hours_link` (and, in 91004,
  `field_show_all_holidays`) to existing `group_branch_hours`; renames `group_header_area`,
  `group_content_area`, `group_bottom_area` as "(deprecated, not displayed in Layout Builder)".
- Config keys read by the service: `openy_field_holiday_hours.settings:show_before_offset` /
  `:show_after_offset`, `system.date:timezone.default`. Node fields read by the service:
  `field_branch_hours`, `field_branch_holiday_hours`, `field_show_all_holidays`.
- Update hooks present: `y_branch_update_9001`–`9011`, `91001`, `91004`, `91005` (all reshape the
  Branch bundle's LB sections, restrictions, field groups and fields — see fields/fields.md).
