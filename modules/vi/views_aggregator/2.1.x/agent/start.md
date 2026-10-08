# Views Aggregator Plus (views_aggregator)

Post-query aggregation for Views tables. Ships one Views style plugin,
`views_aggregator_plugin_style_table` ("Table with aggregation options"), that extends
the core Table style and aggregates rendered results. No permissions, no global config,
no Drush commands — everything is per-view style options.

- **Configure a view to aggregate** → [configure/table-style.md](configure/table-style.md)
- **The aggregation functions & how to add your own (hooks)** → [hooks/aggregation-functions.md](hooks/aggregation-functions.md)
- **Programmatic API: function signatures, helper, plugin cell methods** → [api/functions.md](api/functions.md)

Submodule: `views_aggregator_more_functions` adds three extra functions —
see [../../modules/views_aggregator_more_functions/2.1.x/agent/start.md](../../modules/views_aggregator_more_functions/2.1.x/agent/start.md).
