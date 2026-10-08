<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition Pack (condition_pack) — agent index
**Adds block-visibility Condition plugins for A/B testing, dates/days, and times/timezones.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10
- **Submodules:** condition_pack_ab, condition_pack_date, condition_pack_time (each depends on `options`)
- **Plugins:** `@Condition` plugins — `ab_test`, `date`/`date_before`/`day`, `time`/`timezone` (all extend `ConditionPluginBase`, implement `CacheableDependencyInterface`).
- **Routes/permissions:** none.

**Security:** No routes, endpoints, permissions, or admin config. Pure plugin providers configured through the host (block visibility) UI. Verify cache metadata for conditioned blocks.

See [plugins/conditions.md](plugins/conditions.md)