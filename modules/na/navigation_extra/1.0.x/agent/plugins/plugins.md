<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation Extra plugin type & blocks

## The `NavigationExtraPlugin` plugin type

- Manager: `navigation_extra.manager` (`NavigationExtraPluginManager`), discovery namespace
  `Plugin/Navigation/Extra`, annotation `Drupal\navigation_extra\Annotation\NavigationExtraPlugin`
  (`id`, `name`, `description`, `weight`, `dependencies`).
- Interface: `NavigationExtraPluginInterface`; base class `NavigationExtraPluginBase`
  (`PluginBase` + `ContainerFactoryPluginInterface`, injects language manager, current user, entity
  type manager, route provider, menu link manager, config, module handler).

### Interface responsibilities

| Method | Purpose |
|---|---|
| `isEnabled()` | Whether this plugin is on (from `plugins.<id>.enabled`). |
| `buildConfigForm(&$form, $form_state)` | The plugin's settings tab (called by `SettingsForm`). |
| `preAlterDiscoveredMenuLinks(&$links)` | Alter links before the normal menu alter. |
| `alterDiscoveredMenuLinks(&$links)` | Main link injection/alteration. |
| `postAlterDiscoveredMenuLinks(&$links)` | Alter after the normal menu alter. |
| `needsMenuLinkRebuild($entity)` | Whether saving `$entity` should trigger a menu rebuild. |

The link key convention (from `navigation_extra.api.php`): a plugin's links are keyed
`<plugin>.<collection>.<item>` with an `.add` suffix for "create" links, matching the collections tree.

### Built-in plugins (`Plugin/Navigation/Extra/`)

`CommonPlugin`, `BlocksPlugin`, `ContentPlugin`, `FilesPlugin`, `MediaPlugin`, `TaxonomiesPlugin`,
`UsersPlugin`, `FormsPlugin`, `LocalTasksPlugin`, `ToolsPlugin`, `VersionPlugin`.

### Add your own

Create `src/Plugin/Navigation/Extra/MyPlugin.php` extending `NavigationExtraPluginBase`, annotate with
`@NavigationExtraPlugin(id="my_plugin", name=@Translation("My plugin"), weight=10)`, implement
`buildConfigForm()` and the alter methods. Rebuild caches so the manager (`cache.discovery`) picks it
up; it will appear as its own tab in the settings form and can inject its links.

## Blocks (`Plugin/Block/`)

| Block | Role |
|---|---|
| `NavigationExtraLocalTasksBlock` | Renders entity local tasks (tabs) inside the navigation sidebar. |
| `NavigationExtraVersionBlock` | Renders the configured version/environment indicator. |
| `NavigationMenuBlockOverride` | Overrides/augments core's navigation menu block. |

## Layout Builder block filtering

`navigation_extra_plugin_filter_block__layout_builder_alter()` (`.module`) takes over core
`navigation`'s implementation to decide which blocks are "navigation-safe"; the module also uses
`hook_module_implements_alter()` to ensure its implementation runs last.
