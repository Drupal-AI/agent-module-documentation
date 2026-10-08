# Configure — exclude by field value

No settings route (`configure` null). Enable the processor on the Search API index and give it
per-field match values.

## The processor

- ID: `search_api_exclude_entity_by_field_processor`
- Label: "Search API Exclude Entity By Field"
- Stage: `alter_items`, weight `-50`
- Class: `SearchApiExcludeEntityByField extends ProcessorPluginBase implements PluginFormInterface`

## Settings form

On the index → **Processors** tab, enable the processor. Its settings form iterates
`$this->index->getFields()` and renders one **textfield per index field** (title = field
label). Enter the value that should cause exclusion for that field; leave blank to ignore it.
Empty values are stripped on submit. Config shape (schema
`plugin.plugin_configuration.search_api_processor.search_api_exclude_entity_by_field_processor`):

```yaml
fields:
  <field_identifier>: <match_value>
```

## Match logic (`alterIndexedItems`)

For each item it reads the original entity's fields; for every configured `<field> => <value>`
present on the item it compares `entity field value[0]['value']` (defaulting to `0`) against
`sanitizeFilterString(value)`:

- `"true"` → boolean `TRUE`
- `"false"` → boolean `FALSE`
- anything else → the literal string

On a match the item is `unset()` and thus excluded from the index. Failures reading an item
object are caught and reported via the messenger as an error.
