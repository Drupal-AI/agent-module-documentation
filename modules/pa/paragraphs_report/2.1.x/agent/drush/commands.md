<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command

Defined in `drush.services.yml` → `Drupal\paragraphs_report\Drush\Commands\ParagraphsReportCommands`
(Drush 12+ attribute style, autowired with the `paragraphs_report.report` service).

## `paragraphs_report:update` (alias `pru`)

Rebuilds the report data by scanning every node of the selected `content_types` and recording paragraph
usage into the key-value store.

```bash
drush paragraphs_report:update
drush pru
```

Behaviour: loads the node ids for the configured content types (`ParagraphsReport::getNodes()`), builds a
batch (`batchPrep()`), and runs it (`drush_backend_batch_process()`). If **no content types are selected**
(so no nodes to process) it prints:

> `No nodes found to process. Please update the report settings.`

So set `paragraphs_report.settings.content_types` first (see
[configure/settings.md](../configure/settings.md)). There is no argument or option; it always uses the
current settings. This is the CLI/cron equivalent of the report page's "Update Report Data" button
(route `paragraphs_report.data`).
