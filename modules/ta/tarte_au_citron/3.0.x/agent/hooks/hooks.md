# Tarte au citron hooks

Declared in `tarte_au_citron.api.php`. All are `alter`-style hooks invoked from
`tarte_au_citron_page_attachments_alter()` / `LibraryJsDiscover`.

## `hook_tarte_au_citron_SERVICE_ID_alter(array &$attachments, ServicePluginInterface $service)`

Invoked once **per enabled service** during page attach (`\Drupal::moduleHandler()->alter(
'tarte_au_citron_' . $service->getPluginId(), …)`). `SERVICE_ID` is the service plugin id. Use it to
attach an extra library or push `drupalSettings` (e.g. `tarteaucitron.user.<fn>` values) needed by that
service.

```php
function mymodule_tarte_au_citron_gtag_alter(array &$attachments, \Drupal\tarte_au_citron\ServicePluginInterface $service): void {
  $attachments['#attached']['library'][] = 'mymodule/gtag_extra';
  $attachments['#attached']['drupalSettings']['mymodule'] = ['key' => 'value'];
}
```

## `hook_tarte_au_citron_config_alter(array &$data)`

Invoked at the end of `LibraryJsDiscover::getJsConfig()` (result is cached). `$data` is the discovered
tacConfig definition map (`key => ['type' => 'label'|'boolean', 'default_value' => …, 'isUrl' => …]`).
Add or change config keys that appear on the JS settings form and in the schema.

```php
function mymodule_tarte_au_citron_config_alter(array &$data): void {
  $data['my_text_id'] = ['type' => 'label', 'default_value' => 'my_text_value'];
}
```

## `hook_tarte_au_citron_texts_config_alter(array &$data)`

Invoked at the end of `LibraryJsDiscover::getTextsConfig()` (cached) — note the module's
`moduleHandler->alter('tarte_au_citron_texts_config', $data)` call name. `$data` is the discovered text
definition map (`id => ['type' => 'text'|'mapping', 'default_value'|'children' => …]`). Add or change
overridable banner texts.

```php
function mymodule_tarte_au_citron_texts_config_alter(array &$data): void {
  $data['my_text_id'] = ['type' => 'label', 'default_value' => 'my_text_value'];
}
```

Also available (plugin manager alter, not in api.php): **`hook_tarte_au_citron_services_info`** to alter
service plugin definitions. After implementing any of these, clear caches — discovery results are cached
in the `services_js` bin and the plugin definition cache.
