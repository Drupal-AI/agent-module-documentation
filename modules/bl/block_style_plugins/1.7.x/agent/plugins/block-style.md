# Defining a BlockStyle plugin

Plugin type `block_style`. Manager `plugin.manager.block_style.processor` (`BlockStyleManager` extends
`DefaultPluginManager`, adds a `YamlDiscoveryDecorator` for `*.blockstyle.yml` and scans both module and
theme directories). Two ways to define a style.

## 1. YAML (easiest; works in modules and themes)

Create `MYTHEME.blockstyle.yml` (or `MYMODULE.blockstyle.yml`):

```yaml
sample_block_style:
  label: 'Sample Block Style'
  form:
    field_name:
      '#type': textfield
      '#title': 'Add a custom css class'
      '#default_value': 'my-class'
  template: block__my_custom_template   # optional theme suggestion
  include:                              # optional; see below
    - basic
```

- Each top-level key is the plugin id. `form:` fields must be flat (no nesting).
- The value saved for each field is added to the block's `class` attribute at render (unless it is an int,
  e.g. an unchecked checkbox, which is skipped).
- `template:` sets a block theme suggestion.

To point a theme's YAML plugin at a PHP class instead of inline `form`:

```yaml
sample_block_style:
  label: 'Sample Block Style'
  class: '\Drupal\mytheme\Plugin\BlockStyle\SampleBlockStyle'
```

## 2. PHP class

In a module, put a class in `Plugin/BlockStyle/` with the annotation:

```php
/**
 * @BlockStyle(
 *   id = "simple_class",
 *   label = @Translation("Simple Class"),
 *   include = {},
 *   exclude = {},
 * )
 */
class SimpleClass extends BlockStyleBase {
  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $styles = $this->getConfiguration();
    $form['sample_class'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Add a custom class to this block'),
      '#default_value' => $styles['sample_class'] ?? '',
    ];
    return $form;
  }
}
```

Override `buildConfigurationForm()` (current API), and optionally `validateConfigurationForm()`,
`submitConfigurationForm()`, `themeSuggestion()`, `build()`. `BlockStyleBase::create()` injects
`entity.repository` and `entity_type.manager`. (Themes cannot use annotations — use the YAML `class:` form.)

## include / exclude (block targeting)

Set on the annotation or YAML. Choose one, not both. Matching (`BlockStyleBase::exclude()` /
`includeOnly()`) tests the value against three things:

- the block **plugin id** (e.g. `system_branding_block`),
- a **derivative base id wildcard** `base_id:*` (e.g. `block_content:*`, matched by `baseIdMatch()` via regex),
- the block **content bundle** machine name (for `block_content` blocks, resolved via `loadEntityByUuid`).

Empty `include` = applies to all blocks. A non-empty `include` limits to matches; `exclude` removes matches.

Find a block plugin id by printing `$variables['base_plugin_id']` in a `hook_preprocess_block`; find a block
content type machine name at `/admin/structure/block/block-content/types`.

## Lifecycle & storage

- Form injection: `block_style_plugins_form_block_form_alter` → each plugin's `prepareForm()` builds a shared
  "Block Styles" fieldset and nests each plugin's fields under
  `third_party_settings.block_style_plugins.<plugin_id>` (a `SubformState`). It adds submit/validate handlers.
- Persistence: values saved as block third-party settings, key `block_style_plugins`, sub-key = plugin id.
- Render: `block_style_plugins_preprocess_block` → each plugin's `build()` reads the block's third-party
  setting via `getStylesFromVariables()` and appends non-int values to `attributes.class`.
- Suggestions: `block_style_plugins_theme_suggestions_block_alter` → each plugin's `themeSuggestion()`.

## Alter hook

`hook_block_style_plugins_info(&$definitions)` (alter id `block_style_plugins_info`) lets other code modify
discovered plugin definitions. Plugin cache tag `block_style_plugins`; cleared on theme uninstall when a
plugin's provider theme is removed.

> Note: many `BlockStyleBase` methods (`formElements()`, `formAlter()`, `validateForm()`, `submitForm()`,
> `defaultStyles()`, `getStyles()`, `setStyles()`, `styles` property) are deprecated for 8.x-2.x — use
> `buildConfigurationForm()` / `defaultConfiguration()` / `getConfiguration()` / `setConfiguration()`.
