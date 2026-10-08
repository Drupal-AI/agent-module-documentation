# Search API Best Bets — agent index

Per-entity editorial best bets (elevate/exclude) for Search API, applied at query time. Ships a Solr query
handler and a pluggable handler system. Depends on core `field` + `search_api`. Two permissions, config schema,
no Drush. `configure` is null (setup lives on the field + the Search API index processor).

- **Add the field + widget, enable & configure the processor, permissions, theming/elevated flag** →
  [configure/setup.md](configure/setup.md)
- **Implement a query handler plugin for another backend (attribute, interface, manager)** →
  [plugins/query-handler.md](plugins/query-handler.md)

Key facts:
- Field type `search_api_best_bets` (columns `query_text` varchar 360, `exclude` tinyint); widget
  `search_api_best_bets_widget`; formatter `search_api_best_bets_formatter`.
- Search API processor `search_api_best_bets_processor` (stages preprocess_query 99, postprocess_query 10).
- Plugin type `search_api_best_bets_query_handler`: dir `Plugin/search_api_best_bets/query_handler`, attribute
  `Drupal\search_api_best_bets\Attribute\SearchApiBestBetsQueryHandler`, manager service
  `plugin.manager.search_api_best_bets.query_handler`, base `QueryHandlerPluginBase`. Bundled plugin `solr`.
- Permissions `view search_api_best_bets keywords` / `edit search_api_best_bets keywords` (field access via
  `hook_entity_field_access`; NOT `restrict access: true`, but they only gate this field's view/edit).
- Elevated rows get class `search-api-elevated` + `elevated` var (Search API Pages results, Views rows).
