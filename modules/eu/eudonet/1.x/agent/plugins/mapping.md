<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field mapping (`eudonet_mapping` plugin type)

Eudonet CRM columns are addressed by numeric **DescIds**. The `eudonet_mapping` plugin type lets
code refer to columns by human names instead.

## Manager & discovery

- Manager `Drupal\eudonet\EudonetMappingPluginManager` (service
  `plugin.manager.eudonet_mapping`, args `@module_handler`, `@cache.discovery`), interface
  `EudonetMappingPluginManagerInterface`.
- **YAML discovery**: `YamlDiscovery('eudonet.mapping', ...)` — every module may ship a
  `MODULE.eudonet.mapping.yml` file. Definitions are cached under `eudonet_mapping`
  (cache tag `eudonet_mapping`); `label`/`label_context` are translatable; each definition must
  have a non-empty `id` (`processDefinition()` throws a `PluginException` otherwise).

## Shipped mapping

`eudonet.eudonet.mapping.yml` defines the `default` map:

```yaml
default:
  last_name: 201
  first_name: 202
  gender: 217
  birth_date: 208
  birth_place: 21
```

## How mappings are used

`EudonetMappingTrait` (used by query plugins, result plugins, `EudonetQueryCondition`, and
`EudonetSearchQueryResultItemWrapper`) holds `mappingId` (default `'default'`, set in
`EudonetQueryBase::__construct`) and resolves it via `ensureMapping()` →
`plugin.manager.eudonet_mapping->getDefinition($mappingId)`.

Resolution happens wherever a field name is accepted:

- `SearchQuery::addField()/addFields()` → `ListCols` DescIds.
- `condition()` / `EudonetQueryCondition::build()` → `Criteria.Field`.
- `orderBy()` → `OrderBy[].DescId`.
- `CUDQuery::setValue()/setImageValue()` → `Fields[].DescId`.
- `EudonetSearchQueryResultItemWrapper::__get($name)` → maps `$name` to a DescId before walking
  the response row.

In every case, if the name is not present in the mapping the raw value passed in is used as-is
(so numeric DescIds may be passed directly).

## Adding a custom mapping

Ship `mymodule.eudonet.mapping.yml`:

```yaml
contacts:
  id: contacts
  label: 'Contacts table'
  email: 305
  phone: 306
```

Then select it on a query/result via `setMapping('contacts')` (from `EudonetMappingTrait`) before
adding fields/conditions, or pass the mapping id through the plugin `configuration['mapping']` for
result wrappers.
