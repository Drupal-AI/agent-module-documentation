<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cron Timing lets an administrator add custom automatic-cron run intervals (specified in seconds) that then appear as extra choices in Drupal core's Cron settings interval dropdown.
---
The module provides one admin form at `/admin/config/system/cron_timing` (route `cron_timing.cron_timing`, gated by the `access administration pages` permission) with a single text field accepting a comma-separated list of second values, e.g. `60,120,360,900`. Submission is validated with a strict regex (`^[0-9]+(,[0-9]+)*$`) and stored in `cron_timing.crontiming` config. A `hook_form_alter` then intercepts the core `system_cron_settings` form, converts each stored second value into a human-readable interval via the date formatter, and merges those options into the `cron[interval]` select.

Operationally this is a small configuration convenience: enable the module, enter your intervals, save, then go to `/admin/config/system/cron` and pick one of the new options. There are no mutating endpoints, callbacks, or web-service routes. The config-only nature and admin-permission gating keep the attack surface minimal.
---
- Add a 1-minute automatic cron interval option.
- Add sub-hour intervals like 2, 5, 10 minutes.
- Define several custom intervals at once (comma-separated seconds).
- Make more frequent cron available for time-sensitive queues.
- Provide non-standard intervals not in core's default list.
- Edit the interval list later and re-save.
- Constrain input to numeric seconds via built-in validation.
- Pick the new interval on the core Cron settings page.
- Support high-frequency scheduled publishing workflows.
- Keep cron config in exported configuration.
- Remove an interval by editing the comma list.
- Pair with core automated cron for finer scheduling granularity.
- Set default intervals `300,900` shipped by the module.
- Restrict access via the `access administration pages` permission.
- Export the interval configuration between environments.
- Trim cron frequency back to defaults by clearing custom values.