<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Filter — agent index

Define text-format filters (regex search/replace, optional PHP replacement code) from the
admin UI instead of writing a filter module. Each filter is a `customfilter` config entity
made of ordered **rules**; it appears as a selectable filter on every text format. Depends on
core `filter`. `configure` route: `entity.customfilter.list` (`/admin/config/content/customfilter`).

- **Filters, rules, subrules, the pattern/replacement/code model, config storage, Drush** →
  [configure/filters.md](configure/filters.md)
- **The single `administer customfilter` permission, and the eval/XSS trust responsibility it
  carries** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity type `customfilter` (`config_prefix: filters` → `customfilter.filters.<id>`);
  rules live in the entity's `rules` array (schema `customfilter.rules`).
- Filter plugin is registered dynamically in `customfilter_filter_info_alter()`
  (`hook_filter_info_alter`), class `Drupal\customfilter\Plugin\Filter\CustomFilterBaseFilter`.
- Rule with `code = 0` → `preg_replace($pattern, $replacement)`; `code = 1` → replacement is
  PHP run via `@eval()` (must set `$result`, may use shared `$vars` stdClass).
- No Drush commands, no new plugin types. Provides a D6/D7 migrate source
  (`Plugin/migrate/source/CustomFilterMigrationSource`).
