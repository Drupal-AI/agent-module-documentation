# Views integration for external entities

Enabling `xntt_views` makes each external entity type available as a Views base table. Build a view
at Structure → Views → Add view and pick your external entity type in the **Show** dropdown. Filtering
and sorting are pushed to the remote source through the parent's storage client
(`query()` / `transliterateDrupalFilters()`); anything the source cannot handle is (optionally)
filtered Drupal-side per the storage client's configuration.

## Plugins provided

| Kind | Plugin id / class | Purpose |
|---|---|---|
| Query | `xntt_query` — `Plugin/views/query/ExternalEntityViewsQuery` | Runs the view's conditions/sorts/paging against the external source instead of SQL |
| Views data | `Plugin/views/data/ExternalEntityViewsData` | Declares the base table, fields, filters, sorts for each type |
| Field | `external_entity_field` — `Plugin/views/field/ExternalEntityField` | Renders a mapped external-entity field with a field formatter |
| Field | `rendered_external_entity` — `Plugin/views/field/RenderedExternalEntity` | Renders the whole entity in a view mode |
| Field | `Plugin/views/field/ExternalEntityFieldLanguage` | The entity language |
| Field | `ExternalEntityLink`, `ExternalEntityLinkEdit`, `ExternalEntityLinkDelete`, `ExternalEntityOperations` | View/Edit/Delete links and the operations dropdown |

Config schema keys are in `xntt_views.views.schema.yml` (e.g. `views.field.external_entity_field`,
`views.field.rendered_external_entity`). An event subscriber
(`xntt_views.event_subscriber` → `EventSubscriber\ExternalEntitiesSubscriber`) hooks the parent's
transliteration events so Views conditions map to source filters.

## Notes / limitations

- Query efficiency depends on the storage client: file/SQL sources filter well; REST sources may fall
  back to fetching many records, so for large remote APIs a local index (Search API) can be preferable.
- The parent's update `external_entities_update_93024` renames the legacy `xnttfield` Views field
  plugin to `external_entity_field`; existing views are migrated automatically.
