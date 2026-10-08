<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboards webform — agent index

Submodule of [Dashboards](../../../../2.1.x/agent/start.md). Adds one **Dashboard widget**:
`webform_submissions` ("Submission statistic.", category "Webform"), a time-series chart of webform
submission counts. Requires `webform` + `dashboards`. No config entity, settings form, permissions, or Drush.

- Placed as block **`dashboards_block:dashboard:webform_submissions`** in a dashboard's Layout Builder
  (see the parent's [plugins doc](../../../../2.1.x/agent/plugins/dashboard-plugins.md)).
- Settings: `webform` (limit to one webform, optional), `period` (`hour`|`day`|`week`|`month`),
  `date` (today | yesterday | this_week | this_month | last_three_months | last_six_months | year),
  `chart_type` (bar/line/…).
- Data: SQL over the `webform_submission` table grouped by date bucket + webform id, cached in `dashboards` bin.
