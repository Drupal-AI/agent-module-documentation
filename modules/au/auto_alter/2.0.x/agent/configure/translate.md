<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure auto_alter_translate (submodule)

Submodule **Automatic Alternative Text Translation** (`auto_alter_translate`). Translates the
English description returned by the **Azure** engine into the current content language using the
Azure Translator Text API. Depends on `auto_alter:auto_alter`. Only relevant when the active
`engine` is `azure_cognitive_services`; it has no effect for the Alttext.ai engine (Alttext.ai does
its own multilingual output — see configure/settings.md).

Form `Drupal\auto_alter_translate\Form\AutoAlterTranslateSettingsForm` (form id
`auto_alter_translate_form`), route `auto_alter_translate.settings_form` at
`admin/config/media/auto_alter/translate` (a local task tab under the main settings). Same
`administer Automatic Alternative Text` permission requirement. Editable config:
`auto_alter_translate.settings`.

## Config keys (`auto_alter_translate.settings`)

| Key | Type | Meaning |
|-----|------|---------|
| `active` | bool | Master switch — translation only runs when TRUE. |
| `endpoint` | string | Azure Translator URL, e.g. `https://api.cognitive.microsofttranslator.com/translate?api-version=3.0`. The `to=`/`from=` params are appended at runtime. |
| `credential_provider` | string | `config` or `key` (same pattern as the parent module). |
| `credentials.config.api_key` / `credentials.key.api_key_key` | string | Azure Translator subscription key, sent as `Ocp-Apim-Subscription-Key`. |
| `region` | string | Optional Azure resource region → sent as `Ocp-Apim-Subscription-Region`. **Not in the config schema.** |

Install defaults: empty `endpoint`/credentials, `credential_provider: 'config'`, `status: false`,
`suggestion: false` (the schema also lists `status`/`suggestion`, but the form saves `active`,
`region`, `endpoint`, credentials only). Form validation, when `active`, calls
`AzureTranslate::gettranslation('Please translate this text', region, endpoint, key, 'en', 'de')`
and requires HTTP 200.

## How it is invoked

`auto_alter_get_description_by_uri()` and `AzureVision::sendDescriptionRequest()` check
`moduleExists('auto_alter_translate')`, `auto_alter_translate.settings:active`, and that
`auto_alter.settings:engine == 'azure_cognitive_services'`; if all hold they call service
`auto_alter_translate.get_translation` (`AzureTranslate::gettranslation($text, $region)`) and replace
the description with `translations[0]->text` from the JSON response.

```php
\Drupal::configFactory()->getEditable('auto_alter_translate.settings')
  ->set('active', TRUE)
  ->set('endpoint', 'https://api.cognitive.microsofttranslator.com/translate?api-version=3.0')
  ->set('region', 'westeurope')
  ->set('credential_provider', 'config')
  ->set('credentials.config.api_key', getenv('AZURE_TRANSLATE_KEY'))
  ->save();
```

`hook_requirements` errors if the resolved key or `endpoint` is empty.
