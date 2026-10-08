<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microwave — Drush commands & queues

Configure targets first at `/admin/config/system/microwave` (`microwave.settings`:
`selected_content_type`, `{bundle}_date_field`, `{bundle}_days`, `{bundle}_period_type`,
`selected_vocabularies`, `urls`).

Populate queues:
```bash
drush microwave:process_custom_urls   # alias mpcu  → queue microwave_custom_cron
drush microwave:process_nodes_urls    # alias mpnu  → queue microwave_node_cron
drush microwave:process_terms_urls    # alias mptu  → queue microwave_term_cron
drush microwave:process_commerce_product_urls  # alias mpcpu (microwave_commerce submodule)
```
Each command first clears its own queue if non-empty, then enqueues one `{url}` item per
target. Node URLs come from the path alias; term URLs from `entity.taxonomy_term.canonical`.
Node/term enqueueing runs in a Drush batch, 100 rows at a time; only published
(`status = 1`) entities are included.

Process the queues (warm the pages):
```bash
drush queue:run microwave_node_cron
drush queue:run microwave_term_cron
drush queue:run microwave_custom_cron
```
or let cron drain them. Each item is fetched by `microwave.warmer_requests`
(`WarmerRequests::warmUrlByGet`), which **refuses** any URL whose scheme is not http/https
or whose host differs from the current site host (logged as a warning). Non-200 responses
and transport errors are logged to the `microwave` channel.

Typical use: call the `process_*` commands from CI after a deploy, then run the queues.
