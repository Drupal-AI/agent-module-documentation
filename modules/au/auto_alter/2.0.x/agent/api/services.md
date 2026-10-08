<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & helper functions

## Procedural helpers (auto_alter.module)

| Function | Signature | Behaviour |
|----------|-----------|-----------|
| `auto_alter_get_engine()` | `(): DescribeImageServiceInterface` | Instantiates the plugin named by `auto_alter.settings:engine` via `plugin.manager.auto_alter_describe_image`. |
| `auto_alter_get_description($fid)` | `(int $fid): string` | Loads the `file` entity, resolves its uri via `$engine->getUri()`, then delegates to `auto_alter_get_description_by_uri()`. Returns `''` (and flashes a status message) if `$engine->checkSetup()` is FALSE. |
| `auto_alter_get_description_by_uri($uri)` | `(string $uri): string` | Realpaths the uri, calls `$engine->getDescription($path)`. If `auto_alter_translate` is installed, active, and engine is Azure, runs the result through `auto_alter_translate.get_translation`. Flashes status/warning when `status` is on. |
| `auto_alter_get_translated_alt($file, $target_language)` | `(File, string): ?string` | Uses `$engine->getDescriptions()` and returns the entry for `$target_language`, or NULL. |
| `getAlternativeText(&$form, $form_state)` | AJAX callback | Fills `attributes.alt` on the `editor_image_dialog` form from the uploaded/selected `fid`. |

These are plain functions — call them with `auto_alter_get_description($fid)` after
`\Drupal::moduleHandler()->loadInclude` is not needed (they live in the always-loaded `.module`).

## Registered services

| Service id | Class | Notes |
|------------|-------|-------|
| `plugin.manager.auto_alter_describe_image` | `AutoAlterDescribeImagePluginManager` | Manager for the `AutoAlterDescribeImage` plugin type (see plugins/describe_image.md). |
| `auto_alter_translate.get_translation` | `Drupal\auto_alter_translate\AzureTranslate` | Submodule. `gettranslation(string $inputStr, $region = FALSE, $endpoint = FALSE, $api_key = FALSE, $fromLanguage = "en", $toLanguage = FALSE)` → PSR-7 response (or FALSE). POSTs to the Azure Translator `endpoint` with `to=`/`from=` params and header `Ocp-Apim-Subscription-Key`. |

## Credentials helper

`Drupal\auto_alter\AutoAlterCredentials` (and the submodule's `AutoAlterTranslateCredentials`) turn
stored config into a usable key:

```php
$creds = new \Drupal\auto_alter\AutoAlterCredentials();
$creds->setCredentials($config->get('credential_provider'), $config->get('credentials') ?? []);
$apiKey = $creds->getApikey(); // reads config value, or loads the Key entity when provider = 'key'
```
