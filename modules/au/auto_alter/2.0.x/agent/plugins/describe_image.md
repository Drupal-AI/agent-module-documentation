<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: AutoAlterDescribeImage

A pluggable "image description engine". Each plugin wraps one vision provider.

- Annotation: `Drupal\auto_alter\Annotation\AutoAlterDescribeImage` (`@AutoAlterDescribeImage`,
  properties `id`, `name`/`title`).
- Interface: `Drupal\auto_alter\DescribeImageServiceInterface`.
- Manager service: `plugin.manager.auto_alter_describe_image`
  (`Drupal\auto_alter\Plugin\AutoAlterDescribeImagePluginManager`).
- Discovery directory: `src/Plugin/AutoAlterDescribeImage/`.
- Alter hook: `auto_alter_describe_image_info` (alter the plugin definitions array).
- Cache key: `auto_alter_describe_image`.

The selected plugin id is stored in `auto_alter.settings:engine` and instantiated by the helper
`auto_alter_get_engine()` via `createInstance($engine)`.

## Built-in plugins

| id | class | endpoint / auth |
|----|-------|-----------------|
| `azure_cognitive_services` | `AzureVision` | admin-set `endpoint`; key header `Ocp-Apim-Subscription-Key`. Local files sent as `multipart` upload; remote files sent as a `json` `url`. |
| `alttext_ai` | `AlttextAi` | fixed `https://alttext.ai/api/v1/images`; key header `X-API-Key`. Local files sent base64 in `image.raw`; remote (or when env `ALTTEXT_AI_FORCE_IMAGE_UPLOAD` is set) as a `json` `url`. Supports multi-language via `getDescriptions()`. |

## Interface methods to implement

```php
public function checkSetup();                       // bool: credentials/endpoint present
public function getUri(File $file);                 // returns image uri (downscales >1MB via auto_alter_help style)
public function getDescription(string $uri_or_realpath);   // string: single alt text
public function getDescriptions(string $uri_or_realpath);  // array keyed by langcode
public function buildConfigurationForm();           // returns form array merged into the settings form
public function validateConfigurationForm($form_state);
public function submitConfigurationForm($form_state, $config); // persists into auto_alter.settings
```

The interface also extends `PluginInspectionInterface` and `ContainerFactoryPluginInterface`, so a
plugin needs `create()`, `getPluginId()`, `getPluginDefinition()`.

## Adding a provider

1. Create `src/Plugin/AutoAlterDescribeImage/MyProvider.php` in your module.
2. Annotate `@AutoAlterDescribeImage(id = "my_provider", title = @Translation("My Provider"))`.
3. Implement `DescribeImageServiceInterface`; inject `http_client`, `config.factory`,
   `file_system`, etc. via `create()`. Read credentials with
   `Drupal\auto_alter\AutoAlterCredentials` (`setCredentials($provider, $config->get('credentials'))`
   then `getApikey()`).
4. Return your form fragment from `buildConfigurationForm()` and persist your keys in
   `submitConfigurationForm()`. Rebuild caches; the engine appears in the settings `select`.
