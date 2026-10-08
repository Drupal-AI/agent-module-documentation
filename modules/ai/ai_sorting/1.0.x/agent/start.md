<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Sorting (ai_sorting) — agent index

One **Views sort plugin** that reorders a view's items by **learned engagement** (Thompson
Sampling A/B testing) supplied by the contributed **RL** module. Adds no order of its own — it
asks RL for per-item scores and rewrites the query `ORDER BY`. A JS library reports impressions and
clicks back to RL's endpoint. Package `Custom`, core `^10.3 || ^11`, license GPL-2.0-or-later,
version 1.0.0-rc1. **On drupal.org superseded by `rl_sorting` (unsupported/obsolete).**

- Dependencies: core `views`, `rl` (RL / Reinforcement Learning). No composer.json.
- **The sort plugin, its options, the experiment/tracking wiring, and the decorator** →
  [views/sort.md](views/sort.md)

## What it provides (from source)

- **Sort plugin** `AISorting` (`@ViewsSort("ai_sorting")`,
  `src/Plugin/views/sort/AISorting.php`). `query()` derives an experiment id
  `ai_sorting-<view>-<display>`, collects arm IDs from a clone of the view's own (already
  access-filtered) query, calls `rl.experiment_manager::getThompsonScores()`, and adds a CASE
  `addOrderBy(...)`. Options: `favor_recent`, `time_window_seconds` (month…year), `cache_max_age`.
- **Services** (`ai_sorting.services.yml`):
  - `ai_sorting.experiment_registration` → `Service\ExperimentRegistrationService` (wraps
    `rl.experiment_registry::register()`).
  - `ai_sorting.experiment_decorator` → `Decorator\AiSortingExperimentDecorator` (tagged
    `rl_experiment_decorator`); `decorateArm()` loads the entity and returns its label for RL
    reports.
- **Hooks** (`ai_sorting.module`):
  - `hook_views_pre_render` — attaches the `ai_sorting/ai_sorting_tracking` library +
    `drupalSettings.aiSorting` (experiment id, entity IDs, entity→URL map, RL endpoint), registers
    the experiment, adds the `rl-experiment` class.
  - `hook_views_data_alter` — exposes the `ai_sorting` sort on every entity data/base table.
  - `hook_contextual_links_view_alter` — adds a "View experiment" link to `rl.reports.experiment_detail`.
  - `hook_help`.
- **JS library** `ai_sorting/ai_sorting_tracking` (`js/ai-sorting-tracking.js`) — IntersectionObserver
  turns + click rewards via `navigator.sendBeacon` to RL's `rl.php` endpoint (dedup via
  sessionStorage).

No permissions, no routes of its own, no config schema, no Drush, no submodules. Sort options are
stored in the view's own config.

## Mechanics / notes

- **No access bypass**: `query()` clones `$this->query` (the view's query with all filters/access
  tags already applied) only to read the candidate IDs, then reorders the same result set; it never
  runs an `accessCheck(FALSE)` query.
- **Fail-hard**: on any error (no base_field, no scores from RL) `query()` logs and re-throws — the
  view render fails rather than silently falling back.
- **Cache coupling**: `submitOptionsForm()` rewrites the display's cache plugin to `time` (or `none`)
  to match `cache_max_age`; `query()` also calls `rl.cache_manager::overridePageCacheIfShorter()`.
- Scores are only sorted, never rendered; entity labels are rendered in the **RL reports** UI via the
  decorator.
