<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stacks - Content Feed — agent index

Submodule of **Stacks** (read `../../../../3.1.x/agent/start.md` first). Adds the
`content_feed` `stacks_widget_type` plugin and a `contentfeed` widget bundle: a Views-like
dynamic node listing with filters and AJAX pagination, rendered through theme templates.

- **Plugin, contentfeed bundle fields, query backends, AJAX route, templates, hooks** →
  [api/content-feed.md](api/content-feed.md)

Key facts:
- WidgetType plugin `content_feed` (`src/Plugin/WidgetType/ContentFeed.php`), used by the
  installed `widget_entity_type` bundle `contentfeed` (`plugin: content_feed`).
- Query backends: `StacksDatabaseQuery` (default SQL) and `StacksSolrQuery` (Search API/Solr),
  both extend `StacksQueryBase::getNodeResults()`.
- AJAX route `stacks_content_feed.content_feed_ajax` → `/ajax/grid`
  (`GridController::gridAjax`, permission `access content`).
- Query alter hook: `hook_widget_node_results_alter(&$query, $group, &$context)`.
- No own permissions, no config schema, no Drush, no new plugin types.
- Templates authored in theme: `stacks/contentfeed/templates/*` (wrapper/filters),
  `stacks/contentfeed/ajax/*` (results + pagination), plus `templates/pager/*`.
