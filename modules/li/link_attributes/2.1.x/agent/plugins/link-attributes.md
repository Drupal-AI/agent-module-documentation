# Define a link attribute (YAML plugin)

Attributes are **YAML plugins** discovered by the `plugin.manager.link_attributes` manager
(`LinkAttributesManager`, `DefaultPluginManager` + `YamlDiscovery`). No PHP class required —
just add a `MODULE.link_attributes.yml` file to any module.

Each key is the HTML attribute name; the value describes its form element:

```yaml
# my_module.link_attributes.yml
data-analytics:
  title: 'Analytics tag'
  # type defaults to 'textfield' if omitted
  description: 'Value added as a data-analytics attribute.'
target:
  title: Target
  type: select
  empty_value: ''
  options:
    _self: 'Same window (_self)'
    _blank: 'New window (_blank)'
rel:
  title: Rel
```

Definition keys: `title` (label, translatable), `type` (any Form API element type,
default `textfield`), `description`, `options` (for select, translated automatically),
`empty_value`, `default_value`. Defaults for every plugin: `title`, `type`, `description`
are set by the manager.

The manager's alter hook id is `link_attributes_plugin` — see
[hooks/hooks.md](../hooks/hooks.md). Cache tag/bin: `link_attributes`.
