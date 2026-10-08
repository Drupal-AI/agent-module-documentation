# Plugin — agent index

Developer toolkit extending core's plugin system. Four capabilities. Depends on core only.
Configure route `plugin.plugin_type.list` → `/admin/structure/plugin` (perm `plugin.overview.view`).

- **Plugin type registry: `*.plugin_type.yml`, `plugin.plugin_type_manager`, admin UI, ParamConverters** →
  [api/plugin-types.md](api/plugin-types.md)
- **Register your module's plugin manager as a discoverable plugin type** →
  [configure/register-plugin-type.md](configure/register-plugin-type.md)
- **Plugin selector plugin type (`plugin_selector`) + form-element selectors (`plugin_radios`, `plugin_select_list`)** →
  [plugins/plugin-selector.md](plugins/plugin-selector.md)
- **The `plugin` (plugin collection) field type, `plugin_selector` widget, `plugin_label`/`plugin_block_built` formatters** →
  [fields/plugin-field.md](fields/plugin-field.md)
- **Hook `hook_plugin_selector_alter()`** → [hooks/hooks.md](hooks/hooks.md)
- **Drush `plugin-types` cache-clear callback** → [drush/drush.md](drush/drush.md)

Key facts: the module DEFINES one plugin type of its own — `plugin_selector`
(manager `plugin.manager.plugin.plugin_selector`). It also *registers* dozens of core/contrib
plugin types into its registry. Field type id is `plugin`, derived per plugin type as
`plugin:<plugin_type_id>` (all registered types except `field_type`). Permission:
`plugin.overview.view`. Config schema base: `plugin.plugin_configuration.[plugin_type_id].[plugin_id]`.
