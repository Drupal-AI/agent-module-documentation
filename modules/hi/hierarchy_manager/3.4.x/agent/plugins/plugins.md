# Hierarchy Manager plugin types

Two annotation-based plugin types, each with a manager service (both extend
`default_plugin_manager`, defined in `hierarchy_manager.services.yml`):

| Plugin type | Manager service | Annotation | Base class | Shipped |
|---|---|---|---|---|
| `hm_setup_plugin` | `plugin.manager.hm.hmsetup` | `@HmSetupPlugin` | `HmSetupPluginBase` | `hm_setup_taxonomy`, `hm_setup_menu` |
| `hm_display_plugin` | `plugin.manager.hm.display_plugin` | `@HmDisplayPlugin` | `HmDisplayPluginBase` | `hm_display_jstree` |

Discovery dirs: `src/Plugin/HmSetupPlugin/` and `src/Plugin/HmDisplayPlugin/`.

## Setup plugin (`hm_setup_plugin`)

Decides which entity forms get replaced by a tree and supplies the bundle options shown on the
config form. Implement `HmSetupPluginInterface` (extends `PluginInspectionInterface`):

- `getBundleOptions()` — return `[bundle_id => label]` used to populate the "bundle" checkboxes
  on `hierarchy_manager.hm_config_form`.

Use `hm_setup_taxonomy` (`src/Plugin/HmSetupPlugin/HmTaxonomy.php`) and `hm_setup_menu` as
templates to add hierarchy management for another entity type. The bound `display_profile` and
enabled bundles are read from `hierarchy_manager.hmconfig` (see configure/config.md).

```php
#[HmSetupPlugin(id: 'hm_setup_myentity', label: new TranslatableMarkup('My entity'))]
class MyEntitySetup extends HmSetupPluginBase {
  public function getBundleOptions() { /* return [id => label] */ }
}
```

You will also add JSON source/update endpoints (mirror `HmTaxonomyController`) that enforce
access + CSRF and feed `PluginTypeManager::buildHierarchyItem()` results to the display plugin.

## Display plugin (`hm_display_plugin`)

Renders the tree with a front-end library. Implement `HmDisplayPluginInterface`:

- `getForm(string $url_source, string $url_update, array &$form, ?FormStateInterface &$form_state, $options, $confirm)`
  — build the render array/form that loads tree data from `$url_source` and posts changes to
  `$url_update`. `$options` is the profile's `config` JSON; `$confirm` is the profile flag.
- `treeData(array $data)` — transform `buildHierarchyItem()` rows into the structure your
  library expects (jsTree implementation in `HmDisplayJstree::treeData()`).

Reference: `src/Plugin/HmDisplayPlugin/HmDisplayJstree.php`. Register your library in a
`*.libraries.yml` and depend on it from the plugin. This is how you swap jsTree for another
library without touching the setup/endpoint layer.
