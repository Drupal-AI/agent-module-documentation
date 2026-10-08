<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup & configuration

## Install / enable

```bash
composer require drupal/ai_provider_bytedance
drush en ai_provider_bytedance
```

`drupal/ai` (module dep `ai:ai`) and `drupal/key` are pulled by Composer; enable Key if it is not
already on. Create a Key entity (Configuration » System » Keys) holding your ByteDance ModelArk
API key before configuring the provider.

## Config form

`src/Form/ByteDanceConfigForm.php` (`ConfigFormBase`, form id `bytedance_settings`), route
**`ai_provider_bytedance.settings_form`** at `/admin/config/ai/providers/bytedance`, requirement
**`_permission: 'administer ai providers'`** (`ai_provider_bytedance.routing.yml`). Menu link
`ai_provider_bytedance.settings_menu` sits under `ai.admin_providers`. Injected services:
`ai.provider` (`AiProviderPluginManager`) and `key.repository` (`KeyRepositoryInterface`).

Fields:
- `api_key` — `#type: key_select` (required); stores the **Key entity id**, not the raw secret.
- `host` — `#type: url` (optional) endpoint override; default shown is
  `https://ark.ap-southeast.bytepluses.com/api/v3`.

`validateForm()` resolves the selected key via `keyRepository->getKey(...)->getKeyValue()`,
instantiates the `bytedance` provider, applies the key with `setAuthentication()` and the host
with `setConfiguration(['host' => …])`, then calls `getConfiguredModels('text_to_image')` to
prove the key/endpoint work; failures set a form error. `submitForm()` saves `api_key` and `host`
and calls `setDefaultModels()`, which reads `getSetupData()['default_models']` and applies each
via `aiProviderManager->defaultIfNone($op_type, 'bytedance', $model_id)`.

## Config object

`ai_provider_bytedance.settings` (schema `config/schema/ai_provider_bytedance.schema.yml`,
`type: config_object`):
- `api_key` (string) — Key entity id.
- `host` (string) — API base URL override.

Install defaults (`config/install/…settings.yml`): both empty strings.

## Operation

Once saved, select the **ByteDance ModelArk** provider wherever the AI module offers a
provider/model dropdown (Fields, Actions, Views, custom services). Per-model options
(thinking, reasoning effort, image size, seed, watermark, sequential generation, prompt
optimization) come from `getModelSettings()` and `definitions/api_defaults.yml`.
