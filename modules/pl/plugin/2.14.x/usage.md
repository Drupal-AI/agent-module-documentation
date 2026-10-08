Plugin is a developer toolkit that extends Drupal core's plugin system: it adds a **plugin type registry** (discoverable via `*.plugin_type.yml`), **typed plugin definitions**, a **Plugin selector** plugin type/form element, and a **`plugin` (plugin collection) field type** for referencing and configuring plugins as field data.

---

The module introduces the concept of a *plugin type* as a first-class, discoverable object. Any module lists its plugin manager services in a `$module.plugin_type.yml` file; the `plugin.plugin_type_manager` service then exposes each as a `PluginTypeInterface` (id, label, provider, plugin manager, whether it can back a field type, an operations provider, and a config schema id). Plugin ships definitions for dozens of core/contrib plugin types (blocks, field types/widgets/formatters, conditions, actions, migrate plugins, all the Views plugin types, filters, image effects, etc.) so they are introspectable out of the box. On top of that it provides: an admin UI at `/admin/structure/plugin` (route `plugin.plugin_type.list`, gated by the `plugin.overview.view` permission) that lists every registered plugin type and each type's plugins with detail pages; three ParamConverters (`plugin_type`, plugin definition, plugin instance) for routing; a `plugin` **field type** (derived per plugin type as `plugin:<plugin_type_id>`) with a `plugin_selector` widget and `plugin_label` / `plugin_block_built` formatters, letting an entity store a chosen plugin id plus its configuration; and a **Plugin selector** plugin type (`plugin_selector`, its own manager `plugin.manager.plugin.plugin_selector`) with reusable form-element implementations (`plugin_radios`, `plugin_select_list`) that any module can use to let users pick and configure a plugin. It also adds a typed **plugin definition** layer (decorators/interfaces under `src/PluginDefinition/`) so plugin definitions can carry structured metadata (label, description, category, hierarchy, context, config dependencies) instead of raw arrays, and an event-based default-plugin resolver. Drush integration registers a `plugin-types` cache-clear callback. This is an API/building-block module — you install it because another module depends on it, or to build UIs and fields that work generically across plugin types.

---

- Discover and list every plugin type registered on a site at `/admin/structure/plugin`.
- Register a module's own plugin manager as a discoverable plugin type via `$module.plugin_type.yml`.
- Programmatically enumerate plugin types with the `plugin.plugin_type_manager` service.
- Load a specific plugin type's manager generically (`getPluginType($id)->getPluginManager()`).
- Add a **plugin reference** field (type `plugin:<plugin_type_id>`, e.g. `plugin:block`, `plugin:condition`) to a content type.
- Let editors pick and configure a plugin (block, condition, action, ...) and store it as field data.
- Render a stored block plugin from a field with the `plugin_block_built` formatter.
- Show a stored plugin's human label with the `plugin_label` formatter.
- Use the `plugin_selector` widget to expose a plugin-choosing UI on any `plugin` field.
- Build a reusable "select a plugin" form element in a custom module using the Plugin selector plugin type.
- Choose between `plugin_radios` and `plugin_select_list` selector styles for a plugin picker.
- Alter available plugin selectors via `hook_plugin_selector_alter()`.
- Provide typed plugin definitions carrying label, description, category and hierarchy metadata.
- Decorate legacy array-based plugin definitions into typed objects (`ensureTypedPluginDefinition()`).
- Resolve a default plugin for a type via the event-based `plugin.default_plugin_resolver` service.
- Add a config schema for a configurable plugin type using the `plugin.plugin_configuration.[type].[id]` convention.
- Route to a plugin type / plugin definition / plugin instance using the shipped ParamConverters.
- Clear a single plugin type's cached definitions from Drush (`drush cc plugin-types <type>` style cache-clear hook).
- Expose a plugin picker in Views via the `plugin_id` Views filter.
- Provide a generic operations (links) provider for plugins and plugin types in admin listings.
- Build a decoupled UI that needs to introspect arbitrary plugin types without hard-coding managers.
- Gate access to the plugin overview admin pages with the `plugin.overview.view` permission.
- Store a selected image effect, condition, or queue worker plugin against an entity for later use.
- Let a contrib module ship a field type that is really a configurable plugin collection.
- Inspect a plugin type's provider and whether it can be used as a field type.
