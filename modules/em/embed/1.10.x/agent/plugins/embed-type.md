# Define an EmbedType plugin

Embed's plugin type. Manager `Drupal\embed\EmbedType\EmbedTypeManager`
(service `plugin.manager.embed.type`); annotation `Drupal\embed\Annotation\EmbedType`;
plugins live in `src/Plugin/EmbedType/`.

Annotation fields (`@EmbedType`):
- `id` — plugin id (referenced by a button's `type_id`).
- `label` — human name shown when creating a button.
- `embed_form_class` — form class supplying the button's per-button settings form.

Implement `EmbedTypeInterface` (usually by extending `EmbedType/EmbedTypeBase`), which is
`ConfigurableInterface` + `PluginFormInterface` + `DependentPluginInterface`. Key methods:
- `getConfigurationValue($name, $default)` / `setConfigurationValue($name, $value)`
- `getDefaultIconUrl()` — fallback toolbar icon
- `buildConfigurationForm()/validate/submit` (from `PluginFormInterface`) — the settings form
- `defaultConfiguration()` and `calculateDependencies()`

```php
#[\Drupal\embed\Annotation\EmbedType(
  id: "my_widget",
  label: new TranslatableMarkup("My widget"),
)]
class MyWidgetEmbedType extends EmbedTypeBase {
  public function getDefaultIconUrl() {
    return \Drupal::service('extension.list.module')->getPath('my_module') . '/icon.svg';
  }
  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $form['some_setting'] = ['#type' => 'textfield', '#default_value' => $this->getConfigurationValue('some_setting')];
    return $form;
  }
}
```

To also surface it in CKEditor, ship a CKEditor plugin extending
`EmbedCKEditorPluginBase` (CKEditor 4) or `Plugin/CKEditor5Plugin/EmbedCKEditor5PluginBase`
(CKEditor 5). Alter existing definitions with
[hook_embed_type_plugins_alter()](../hooks/hooks.md).
