# Counter blocks

Three core Block plugins (in `src/Plugin/Block/`). All merge the `counter_data_refresh`
cache tag so they refresh when cron invalidates it (see [../hooks/hooks.md](../hooks/hooks.md)),
and attach the `counter/counter.custom` library.

| plugin id | class | admin label | what it renders |
|-----------|-------|-------------|-----------------|
| `counter_block` | `CounterBlock` | Counter | The full counter, driven entirely by the global `counter.settings` toggles. Theme hook `counter`. |
| `configurable_counter_block` | `ConfigurableCounterBlock` | Configurable Counter | Same values, but each is shown only when BOTH the per-block checkbox AND the matching `counter.settings` key are on. Theme hook `configure_counter`. |
| `counter_day_block` | `CounterDayBlock` | Counter Day | A small "today's views" badge linking to the dashboard. **Renders empty for non-`administrator` users.** |

## `counter_block` (`CounterBlock::build()`)

Reads every `counter_*` key from `counter.settings` and, for each enabled one, calls a
`CounterUtility` read method (see [../api/services.md](../api/services.md)) — e.g.
`getVisitorData()`, `getUniqueVisitorData()`, `getTotalUsers()`, `getTotalNodes()`,
`getTimeRangeData()` — plus `SERVER_ADDR` and the request's client IP. Values are passed to
the `counter` twig template as `#site_counter`, `#unique_visitor`, `#registered_user`,
`#server_ip`, `#ip`, `#counter_since`, `#statistic_today|week|month|year`, etc. Initial
offsets from `counter_initial_counter` / `counter_initial_unique_visitor` /
`counter_initial_since` are added here.

## `configurable_counter_block` (`ConfigurableCounterBlock`)

Adds a `blockForm()` with a checkbox per metric (17 checkboxes) stored in block config via
`blockSubmit()`; `defaultConfiguration()` enables only `counter_show_site_counter`. A metric
appears only when the block checkbox is on *and* the global `counter.settings` key is on.
`blockAccess()` returns `AccessResult::allowedIfHasPermission($account, 'access content')`.

## `counter_day_block` (`CounterDayBlock`)

`build()` calls `CounterUtility::getTimeRangeData(strtotime('today'))`, formats counts >999 as
`N.Nk`, and returns markup only if the current user has the `administrator` role (otherwise
`[]`). Links to `/admin/config/counter/dashboard`.

Place any of these from **Block layout** (`/admin/structure/block`).
