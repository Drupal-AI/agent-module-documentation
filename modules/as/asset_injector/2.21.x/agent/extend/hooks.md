# Asset Injector hooks

Declared in `asset_injector.api.php`.

| Hook | Purpose |
|---|---|
| `hook_asset_injector_library_info_build_alter(array &$library)` | Alter the dynamic library that Asset Injector builds from the enabled CSS/JS assets before it is returned to Drupal (e.g. add dependencies, change attributes, tweak file lists). |

Implement in `my_module.module`. This is the main programmatic extension point; the assets
themselves are managed as config entities (see [configure/assets.md](../configure/assets.md)).
