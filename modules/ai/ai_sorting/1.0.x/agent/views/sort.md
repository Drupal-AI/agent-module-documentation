<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "AI Sorting" Views sort plugin

## Install & enable

```bash
# requires the RL module: https://www.drupal.org/project/rl
drush en rl ai_sorting -y
```

Then edit any Views display, add **AI Sorting** as a sort criterion (typically the only sort), set
the options, and save. `hook_views_data_alter()` exposes the `ai_sorting` sort on every entity
data/base table, so it is available on nodes, users, taxonomy terms, media, and custom entities.
(Note: on drupal.org the project is superseded by `rl_sorting`.)

## The sort plugin — `AISorting`

`src/Plugin/views/sort/AISorting.php`, `@ViewsSort("ai_sorting")`, extends `SortPluginBase`.
Injects `rl.experiment_manager`, `request_stack`, `logger.factory`, `rl.cache_manager`.

### Options (`defineOptions`)

| Option | Default | Meaning |
|---|---|---|
| `favor_recent` | `FALSE` | Only count interactions within a time window. |
| `time_window_seconds` | `7776000` (3 months) | Window used when `favor_recent` is on (month / 3 / 6 months / year). |
| `cache_max_age` | `1` | Result refresh/cache duration in seconds (0 = no cache … 300). |
| `order` | `''` | Inherited from `SortPluginBase`; the ASC/DESC control is removed from the form. |

`buildOptionsForm()` renders these under an "AI Sorting Settings" details element (with an Advanced
sub-group for `cache_max_age`). `adminSummary()` prints the time-window and cache choices.

### `query()` — how the order is built

1. Derive `experiment_id = 'ai_sorting-' . view->id() . '-' . current_display`, then
   `preg_replace('/[^a-zA-Z0-9_-]/', '_', …)`.
2. Read `base_field` from the view storage; throw if empty (fail-hard).
3. **Clone the view's current query** (`$id_query = clone $this->query`), strip its fields/group/order
   and select only the base field, remove range, and execute — yielding all candidate arm IDs
   **within the view's already-applied filters and access tags** (no access bypass).
4. `getThompsonScores($experiment_id, $time_window_seconds, $arm_ids)` from the RL experiment
   manager; throw if it returns nothing (fail-hard — "no silent fallbacks").
5. Build `CASE <table>.<base_field> WHEN <id> THEN <score> … ELSE 0 END` and
   `addOrderBy(NULL, $case, 'DESC', 'ai_sorting_score')`. Numeric IDs are cast `(int)`; non-numeric
   IDs are `addslashes()`-escaped and single-quoted; scores are cast `(float)`.
6. `cacheManager->overridePageCacheIfShorter($cache_max_age)`.

### `submitOptionsForm()` — cache coupling

Persists the options, then forces the display's cache plugin: `type: time` with
`output_lifespan`/`results_lifespan` = `cache_max_age` when > 0 (status message shown), or
`type: none` when 0 (warning shown). Finally clears the views sort plugin definitions cache.

## Experiment registration, tracking, and reports

- **Registration + JS attach** — `hook_views_pre_render()` (`ai_sorting.module`): for a view using
  the `ai_sorting` sort it collects entity IDs and canonical URLs from `$view->result` (the
  access-filtered rows), registers the experiment via `ai_sorting.experiment_registration`
  (`ExperimentRegistrationService::registerExperiment()` → `rl.experiment_registry::register()`),
  attaches the `ai_sorting/ai_sorting_tracking` library, and sets
  `drupalSettings.aiSorting.views['<view>.<display>']` = `experimentId`, `entityIds`,
  `entityUrlMap`, `rlEndpointUrl` (`<base>/<rl module path>/rl.php`), `displayId`.
- **Client tracking** — `js/ai-sorting-tracking.js` (`Drupal.behaviors.aiSortingTracking`): matches
  each `<a>` in the view to an entity via `entityUrlMap`, observes visibility with
  `IntersectionObserver` (threshold 0.1) and batches "turns" (impressions) to the RL endpoint via
  `navigator.sendBeacon`; on click it sends a "reward" once per experiment per page load (guarded by
  a `sessionStorage` key). The RL endpoint (`rl.php`) belongs to the RL module.
- **Report decoration** — `AiSortingExperimentDecorator` (tagged `rl_experiment_decorator`) turns an
  `ai_sorting-*` experiment's arm IDs into entity labels for RL's reports UI; `getViewBaseEntityType()`
  resolves the view's base entity type (cached), then `decorateArm()` loads the entity and returns
  its label + id.
- **Contextual link** — `hook_contextual_links_view_alter()` adds a "View experiment" link to
  `rl.reports.experiment_detail` for views using the sort.

## Operating notes

- AI Sorting only **reorders** the view's existing (filtered, access-checked) result set — it does
  not fetch or expose extra content.
- Setting `cache_max_age` to 0 disables the view's cache and short values disable/limit page cache —
  on high-traffic anonymous views this trades performance for faster learning; size it deliberately.
- The plugin is fail-hard: RL misconfiguration or DB issues make the view error rather than render
  unsorted. Ensure RL is installed and its schema present before adding the sort.
- Engagement signals are unauthenticated client beacons to RL's endpoint; treat the resulting scores
  as best-effort popularity, not a trust boundary.
