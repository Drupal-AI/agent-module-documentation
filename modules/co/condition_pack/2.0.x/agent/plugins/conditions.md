<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition Pack plugins

Enable the submodule that provides the condition you need, then configure it from any Condition UI (e.g. Block layout → block → Visibility).

| Submodule | Plugin id(s) | Purpose |
|-----------|--------------|---------|
| condition_pack_ab | `ab_test` (A/B conditions) | Show to a random slice of requests for A/B testing |
| condition_pack_date | `date`, `date_before`, `day` | Date range / before-date / day-of-week |
| condition_pack_time | `time`, `timezone` | Time-of-day window / timezone match |

- All plugins implement `CacheableDependencyInterface`; they declare cache contexts so conditioned output varies appropriately. Time/AB-based conditions reduce cacheability — check performance on cached pages.
- Consume programmatically via `\Drupal::service('plugin.manager.condition')->createInstance($id)`.
