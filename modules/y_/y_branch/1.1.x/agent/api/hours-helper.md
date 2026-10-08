<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Branch hours helper service — y_branch

Service id `y_branch.hours_helper` → `Drupal\y_branch\BranchHoursHelper`
(`src/BranchHoursHelper.php`), constructed with `@config.factory` and `@datetime.time`. It is a pure
read/format helper: it takes a Branch `NodeInterface` and returns render arrays / JS-settings arrays.
Nothing in y_branch calls it — it is a public API for other Open Y modules and preprocess/templates
(e.g. the branch hours block). Load it with
`\Drupal::service('y_branch.hours_helper')` or inject `y_branch.hours_helper`.

## Methods

- `getBranchHours(NodeInterface $node): array` — reads `field_branch_hours` (a custom multi-value
  field whose keys are `hours_mon`…`hours_sun` plus `hours_label`). Collapses consecutive days that
  share the same value into ranges (e.g. "Mon - Fri"), marks the current weekday's row with class
  `current-day` (using `system.date` timezone + request time), and returns
  `['label' => <hours_label>, 'table' => <#theme table render array>, 'js_settings' => [<Day> => "<name><br />value">]]`.
  Empty day values render as the translated "Closed".
- `getLazyBranchHours(NodeInterface $node): array` — the lazy-builder variant: returns a flat
  `[<Day> => "<weekday name><br /><value>"]` map for `field_branch_hours`, skipping keys that are not
  weekday names.
- `getBranchHolidayHours(NodeInterface $node): array` — reads `field_branch_holiday_hours` (multi-value
  with `date` timestamp, `holiday` title, `hours`). Returns `['label' => 'Holiday Hours',
  'table' => <#theme table, cache tag `ymca_cron`>, 'js_settings' => [<Y-m-d> => "<title><br /><hours>"]]`.
  Holiday titles are passed through `Html::escape()`. Rows are date-windowed (see below) unless the
  node's `field_show_all_holidays` boolean is TRUE, in which case every holiday is shown.
- `getLazyBranchHolidayHours(NodeInterface $node): array` — lazy-builder variant of the above; returns
  only the `js_settings` map `[<Y-m-d> => "<title><br /><hours>"]`.
- `getWeekdayNames(): array` — `['Mon' => t('Monday'), … 'Sun' => t('Sunday')]`.
- `getTimezone(): string` — the site default timezone from `system.date`.

## Holiday visibility window

Two offsets decide whether an upcoming/past holiday row is shown, unless `field_show_all_holidays`
overrides:

- show-before: `openy_field_holiday_hours.settings:show_before_offset`, default constant
  `SHOW_BEFORE_OFFSET = 1209600` (14 days), plus the current timezone offset.
- show-after: `openy_field_holiday_hours.settings:show_after_offset`, default constant
  `SHOW_AFTER_OFFSET = 86400` (1 day).

A holiday at timestamp `H` is included when
`request_time < H + show_after_offset` **and** `H - request_time <= show_before_offset`.

## Config & fields it touches (read-only)

- Config: `openy_field_holiday_hours.settings` (`show_before_offset`, `show_after_offset`),
  `system.date` (`timezone.default`).
- Node fields: `field_branch_hours`, `field_branch_holiday_hours`, `field_show_all_holidays`. These
  are provided by other Open Y modules (`openy_loc_branch`, `openy_field_*`), not by y_branch.
