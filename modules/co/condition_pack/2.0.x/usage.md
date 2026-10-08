<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Condition Pack is a set of small submodules that add extra Condition plugins usable anywhere Drupal's Condition/visibility system is (block visibility, and other condition-aware UIs).
---
The project ships three independent submodules, each enabling its own Condition plugins: `condition_pack_ab` (A/B-test style conditions to show a block to a random slice of requests), `condition_pack_date` (Date, Date-before, and Day-of-week conditions), and `condition_pack_time` (Time-of-day and Timezone conditions). Each plugin extends `ConditionPluginBase` and implements `CacheableDependencyInterface`, so it exposes a configuration form and declares its own cache contexts/tags.

There is no central module file, routes, permissions, or admin settings — you enable whichever submodule you need and then configure the condition from the host UI (for example the block placement "Visibility" tab). All three submodules depend on core `options`. Note the cacheability: time/date/AB conditions vary output per request, so blocks using them must not be aggressively cached; the plugins set appropriate cache metadata but you should verify cache behaviour on high-traffic pages.
---
- Show or hide a block on specific days of the week (Day condition).
- Show a block only on/after/before a given date (Date, Date-before).
- Show a block only during a time-of-day window (Time condition).
- Restrict a block to a specific timezone (Timezone condition).
- Serve a block to a random percentage of visitors for A/B testing.
- Enable only `condition_pack_date` if you only need date logic.
- Enable only `condition_pack_time` for time/timezone logic.
- Enable only `condition_pack_ab` for A/B experiment conditions.
- Combine multiple conditions on one block placement.
- Negate any condition (the standard Condition "negate" option).
- Reuse the plugins in custom code via the condition plugin manager.
- Build scheduled banners that appear only in a date range.
- Rotate promotional blocks by day of week.
- Time-gate calls-to-action to business hours.
- Verify cache contexts so conditioned blocks refresh correctly.