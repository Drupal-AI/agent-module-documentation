# Hooks

Hook implementations live in the OOP class `src/Hook/ExternalMediaHooks.php`
(`#[Hook(...)]`, discovered on Drupal 11.1+). `external_media.module` provides
`#[LegacyHook]` procedural wrappers that delegate to the same class via the
`Drupal\external_media\Hook\ExternalMediaHooks` service for older cores.

## Implemented hooks

| Hook | What it does |
|---|---|
| `hook_theme` | Registers themes `external_media` (button: `label`, `class`, `attributes`), `external_media_element` (render element), `external_media_dropdown` (`default_button`, `buttons`). |
| `hook_library_info_build` | Dynamically registers one library per `ExternalMedia` plugin owned by `external_media` (id `external_media.<plugin_id>`) from the plugin's `getLibraries()`. |
| `hook_preprocess_external_media` | Flattens `attributes` into a `data_attributes` string (`data-<key>="<value>"`) for the button template. |
| `hook_preprocess_form_element` | Adds the `form-type-external-media` class when the element `#type` is `external_media`. |
| `hook_uninstall` (`.install`) | Deletes State keys `external_media.info` and legacy `external_media_widget.info`. |

## Alter hook you can implement

| Alter hook | Signature | Use |
|---|---|---|
| `external_media_plugin_info` | `hook_external_media_plugin_info_alter(array &$definitions)` | Alter/remove/adjust discovered `ExternalMedia` plugin definitions before they are used (set via `ExternalMediaManager::alterInfo('external_media_plugin_info')`). |

Example:

```php
function my_module_external_media_plugin_info_alter(array &$definitions) {
  unset($definitions['box_picker']); // Hide the Box provider site-wide.
}
```

The module registers no other hooks (no cron, no entity hooks, no form_alter).
