<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Editor Advanced Image CKEditor 5 plugin

Class: `Drupal\editor_advanced_image\Plugin\CKEditor5Plugin\EditorAdvancedImage`
(`src/Plugin/CKEditor5Plugin/EditorAdvancedImage.php`), declared in
`editor_advanced_image.ckeditor5.yml` as plugin id **`editor_advanced_image_image`** →
CKEditor5 JS plugin **`editorAdvancedImage.EditorAdvancedImage`**.

It implements `CKEditor5PluginConfigurableInterface` (settings form) and
`CKEditor5PluginElementsSubsetInterface` (dynamic allowed-HTML), extending
`CKEditor5PluginDefault`. This is a CKEditor 5 integration plugin — you do **not** normally
subclass it; you configure it (see [../configure/text-format.md](../configure/text-format.md)).

## Supported attributes

```php
const SUPPORTED_ATTRIBUTES = ['title' => TRUE, 'class' => TRUE, 'id' => TRUE];
```

`validChoices()` returns `['title','class','id']` and backs the `Choice` schema constraint on
`enabled_attributes`. `getAllowedStringForSupportedAttribute($attr)` returns the bare attribute
name; `getAllowedHtmlForSupportedAttribute($attr)` returns `<img $attr>`.

## What the PHP feeds to the browser

`getDynamicPluginConfig(array $static_plugin_config, EditorInterface $editor)` returns, filtered
by the saved config:

```php
[
  'image' => ['toolbar' => ['|', 'editorAdvancedImageButton']],
  'editorAdvancedImageOptions' => [
    'disable_balloon' => (bool) $this->configuration['disable_balloon'],
    'defaults' => ['class' => $this->configuration['default_class']],
    'allowedAttributes' => [ /* the enabled attribute names */ ],
  ],
]
```

The static YAML (`editor_advanced_image.ckeditor5.yml`) lists all options and appends
`editorAdvancedImageButton` to the core `image.toolbar`; `getDynamicPluginConfig()` narrows
`allowedAttributes` to the ones the admin allowlisted. Elements the plugin registers:
`<img title class id>`, conditioned on the `ckeditor5_image` plugin.

## Form lifecycle

- `defaultConfiguration()` → `DEFAULT_CONFIGURATION` (`disable_balloon:false`,
  `default_class:''`, `enabled_attributes:['class']`).
- `buildConfigurationForm()` renders the *Disable Balloon* checkbox, an *Enabled attributes*
  fieldset (one checkbox per supported attribute), and a *Default image class(es)* textfield.
- `validateConfigurationForm()` collapses the checkbox set to a numeric array of enabled
  attribute names.
- `submitConfigurationForm()` writes `default_class`, `enabled_attributes`, `disable_balloon`
  into `$this->configuration`.
- `getElementsSubset()` returns `<img class>` / `<img title>` / `<img id>` per enabled
  attribute, extending the format's allowed HTML.

## JS side (reference only)

The behavior lives in `js/build/editorAdvancedImage.js` (sources under
`js/ckeditor5_plugins/editorAdvancedImage/src/`: `EditorAdvancedImageEditing.js`,
`EditorAdvancedImageUI.js`, `EditorAdvancedImageCommand.js`, `ui/EditorAdvancedImageFormView.js`).
It registers the `editorAdvancedImageButton`, the balloon form view, and the model↔view
converters that map the `title`/`class`/`id` attributes onto the `<img>` element.
