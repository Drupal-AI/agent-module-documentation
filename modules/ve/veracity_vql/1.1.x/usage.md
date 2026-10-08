<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Connects Drupal to a Veracity xAPI Learning Record Store and renders charts from VQL (Veracity Query Language) queries.

---
An administrator configures the LRS endpoint and access-key credentials at `/admin/config/services/veracity`; the `veracity_vql.api` service (`VeracityApi` + `VeracityClient`) POSTs VQL queries to the store's `/analyze` endpoint over Guzzle using HTTP basic auth, with the connection tested on save. Queries pass through a pre-process / post-process plugin pipeline (managers `plugin.manager.vql_pre_process` / `plugin.manager.vql_post_process`) so plugins can inject filters — user timezone, date range, activity context — before execution and reshape results (axis ranges, export menu) afterwards. Two blocks, `VeracityChartBlock` and `VeracityEmbeddableChartBlock`, render the resulting charts using a remote renderer script derived from the endpoint host; chart viewing is gated by the `access veracity charts` permission.

Security notes to be aware of when operating it: the config route is gated by `access administration pages` (a lower bar than `administer site configuration`) even though it edits an external endpoint and credentials, and the access-key secret is stored in plain config and pre-filled into a plain textfield on the form (`VeracityConfigForm`). TLS uses Guzzle defaults (verification on); no `verify => false`. Setup is: obtain a Veracity access key with Advanced Queries enabled, enter the endpoint/credentials, then place a chart block and grant `access veracity charts`.
---
- Connect Drupal to a Veracity xAPI Learning Record Store.
- Configure the LRS endpoint and access-key credentials.
- Test the LRS connection when saving settings.
- Run VQL queries against the `/analyze` endpoint.
- Render a learning-analytics chart in a block.
- Embed a chart via the embeddable chart block.
- Filter queries by the viewing user's timezone.
- Filter queries by a date range.
- Filter queries by activity/context.
- Post-process results to set axis ranges.
- Add an export menu to a rendered chart.
- Restrict chart viewing with the `access veracity charts` permission.
- Extend the pipeline with custom pre-process plugins.
- Extend the pipeline with custom post-process plugins.
- Load the remote VQL renderer script for a chart.
- Dispatch pre/post execute events around a query.
- Log VQL execution errors to a dedicated channel.
- Surface xAPI statement data as site-embedded dashboards.
