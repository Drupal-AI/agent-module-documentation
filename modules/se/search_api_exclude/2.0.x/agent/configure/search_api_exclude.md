# Configure Search API Exclude

The module has no admin settings page of its own (no `configure` route). It plugs into the
node-type form, the node form, and the Search API index processor list. Three steps make
exclusion work end to end.

## 1. Enable exclusion for a content type

On the content-type form (`/admin/structure/types/manage/{bundle}`) a **Search API Exclude**
group under *Additional settings* adds an **Enabled** checkbox ("Allow setting the
inclusivity of a node."). It stores a third-party setting on the `node.type.{bundle}` config:

```
node.type.{bundle}:
  third_party_settings:
    search_api_exclude:
      enabled: true
```

Config schema: `node.type.*.third_party.search_api_exclude` (`enabled`: boolean), in
`config/schema/search_api_exclude.schema.yml`. Set it as config instead of via UI:

```
drush cset node.type.article third_party_settings.search_api_exclude.enabled true
```

Changing this value prompts you to reindex; the module shows a "reindex all items" link
(route `search_api.overview`).

## 2. Per-node checkbox

When a bundle has exclusion enabled, the node add/edit form gains a **Search API Exclude**
details group (in the `advanced` sidebar) with a checkbox **"Prevent this node from being
indexed."**. It reads/writes the `sae_exclude` boolean **base field** defined on every node
(`hook_entity_base_field_info`). If the bundle is not enabled, the checkbox is not shown.

Set it in code with the entity API:

```php
$node->set('sae_exclude', TRUE);
$node->save();
```

## 3. Add the processor to the index

Exclusion is enforced by the `node_exclude` Search API processor (label "Node exclude",
stage `alter_items`, weight 0). Enable it on the index's **Processors** tab
(`/admin/config/search/search-api/index/{index}/processors`). The processor:

- only `supportsIndex()` when a datasource covers the `node` entity type,
- in `alterIndexedItems()` removes any node item whose bundle has `search_api_exclude.enabled`
  and whose `sae_exclude` flag is TRUE, so the item never reaches the backend.

Because filtering happens at index time, reindex after enabling the processor, toggling a
bundle's Enabled setting, or changing a node's checkbox for the change to reach the backend.
