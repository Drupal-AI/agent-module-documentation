<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Define a `component_tag` plugin

sdc_tags defines the **`component_tag`** plugin type. Tags are declared in YAML, not PHP classes
(the default class handles behaviour), and discovered from any module or theme.

- Discovery: `YamlDiscovery` over `MODULE_OR_THEME.component_tags.yml` in module **and** theme
  directories.
- Manager: `Drupal\sdc_tags\ComponentTagPluginManager` (service
  `plugin.manager.sdc_tags.component_tag`).
- Alter hook: `hook_component_tag_info(array &$definitions)` (`$this->alterInfo('component_tag_info')`).
- Default class: `Drupal\sdc_tags\ComponentTagDefault` (implements `ComponentTagInterface`,
  `PluginFormInterface`, `ConfigurableInterface`; uses cl_editorial's `ComponentFiltersFormTrait`).
- Interface: `Drupal\sdc_tags\ComponentTagInterface` (just `label()`).

## Declare a tag

`mymodule.component_tags.yml`:

```yaml
hero:
  label: 'Hero components'
  description: 'Components suitable for the hero region.'
sidebar_card:
  label: 'Sidebar cards'
  description: 'Card-like components for the sidebar.'
```

Each top-level key is the tag id. `label` and `description` are translatable
(`label_context` / `description_context` supported). Provide a custom `class` key only if you need
behaviour beyond `ComponentTagDefault`.

Rebuild plugin caches (`drush cr`) after adding the file; the tag then appears on the tagging admin
page at `/admin/config/user-interface/sdc/component-tagging`.

## Plugin configuration

`ComponentTagDefault` is configurable — its stored configuration is
`{tag_id, statuses[], allowed[], forbidden[]}` (defaults: all four lifecycle statuses, empty
allow/forbid). `buildConfigurationForm()` delegates to `ComponentFiltersFormTrait::buildSettingsForm()`;
`submitConfigurationForm()` writes the statuses/forbidden/allowed arrays. The saved configuration is
persisted by `AutoTaggingForm` into `sdc_tags.settings` → `component_tags.<tag_id>` (see
[configure/tagging.md](../configure/tagging.md)).

## Use tags in your code

```php
// List available tags:
$tags = \Drupal::service('plugin.manager.sdc_tags.component_tag')->getDefinitions();

// Instantiate a tag with its stored rule and read its label:
$config = \Drupal::config('sdc_tags.settings')->get('component_tags.hero') ?? [];
$tag = \Drupal::service('plugin.manager.sdc_tags.component_tag')->createInstance('hero', $config);
$label = $tag->label();

// Or just resolve the tag to components (see configure doc):
$filters = sdc_tags_get_tag_filters('hero');
```
