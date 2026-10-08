<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a Localized Config plugin

Place a plugin under `src/Plugin/LocalizedConfig` implementing `LocalizedConfigPluginInterface` (or extending `LocalizedConfigPluginBase`).

Annotation metadata:
- `title` — human-readable label.
- `id` — machine name (used in the config file name `localized_config.<id>.yml`).
- `global_only` — 0/1; when 1 the plugin is only editable at the global level.
- `enabled` — 0/1 on/off.

Methods to implement:
- `add()` — builds the settings form elements.
- `validate()` — validates submitted input.
- `submit()` — persists values (module handles the actual storage across global + per-language files).

Reading values at runtime:
```php
$helper = \Drupal::service('localized_config.helper');
$value  = $helper->getVariable('my_plugin', 'some_var');        // current context
$global = $helper->getGlobalVariable('my_plugin', 'some_var');  // force global
$helper->addConfigCache('my_plugin', $build);                   // attach cache tags
```

Storage layout:
- `localized_config.<id>.yml` — global values.
- `languages/<LANGCODE>/localized_config.<id>.yml` — per-language values.

Scaffold quickly with DrupalConsole: `drupal generate:plugin:localized_config`. Enable the `localized_config_example` submodule for a working reference.
