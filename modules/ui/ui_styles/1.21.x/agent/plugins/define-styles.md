<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Define a UI Styles style plugin

Styles are **not** config entities. They are plugin definitions discovered from a YAML file
named `<provider>.ui_styles.yml` placed at the root of any **enabled module or theme**
(`Drupal\Core\Plugin\Discovery\YamlDiscovery` on the `ui_styles` key). After adding or
editing the file run `drush cr` (discovery is cached with cache tag `ui_styles`).

## File format

```yaml
# my_theme.ui_styles.yml
text_color:                      # the plugin id (machine name)
  enabled: true                  # optional, default true; false hides the plugin
  label: 'Text color'            # required-ish; shown as the widget title
  description: 'Set the text color.'
  category: 'Colors'             # groups plugins into a details element; default 'Other'
  weight: 0                      # sort order within a category
  previewed_as: inside           # 'inside' | 'outside' — how the library preview wraps
  previewed_with:                # extra classes added only to the preview element
    - p-3
  icon: ''                       # optional icon class shown next to options
  empty_option: '- None -'       # label for the "no style" choice
  links:                         # optional external documentation links
    - 'https://getbootstrap.com/docs/5.3/utilities/colors/'
    - url: 'https://example.com'
      title: 'Example'
  options:                       # THE IMPORTANT PART
    text-primary: 'Primary'      # key = CSS class actually added; value = option label
    text-danger: 'Danger'
    text-muted: 'Muted'
```

An option value may also be a map to add per-option metadata:

```yaml
  options:
    text-primary:
      label: 'Primary'
      description: 'Brand primary colour.'
      previewed_with: ['bg-light']
      icon: 'fa fa-circle'
```

## Rules and behaviour

- **`options` keys are the CSS classes.** The manager never invents classes; whatever key
  you write is what gets added to the element (and what the stylesheet generator looks for).
- `id` is the top-level YAML key; it is required. A plugin with `enabled: false` is dropped
  by `StylePluginManager::alterDefinitions()`.
- **Provider scoping:** a style provided by a *module* is available for every theme; a style
  provided by a *theme* is only offered when that theme (or a subtheme of it) is the one
  being configured — see `getDefinitionsForTheme()` and
  [../api/apply-styles.md](../api/apply-styles.md).
- `category`, `label`, `description`, `empty_option` are translatable (contexts
  `*_context`).
- Definitions are represented at runtime by `Drupal\ui_styles\Definition\StyleDefinition`;
  unknown keys are kept under `additional`.

## Alter hook

Other modules can add/modify/remove discovered definitions with
`hook_ui_styles_styles_alter(array &$definitions)` (alter id `ui_styles_styles`, set via
`$this->alterInfo('ui_styles_styles')`). See [../api/apply-styles.md](../api/apply-styles.md).

## Verify discovery

```bash
drush ev '$m=\Drupal::service("plugin.manager.ui_styles"); var_dump($m->hasDefinition("text_color")); print_r(array_keys($m->getDefinition("text_color")->getOptions()));'
```
