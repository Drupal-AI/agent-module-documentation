# Configure OpenAI Core

## Settings form
Route `openai.api_settings` → `/admin/config/openai/settings`, permission
`administer site configuration`. Config object **`openai.settings`**
(`config/install/openai.settings.yml`, schema `openai.schema.yml`):

| Key | Required | Meaning |
|---|---|---|
| `api_key` | yes | OpenAI API key. `ApiSettingsForm` marks it `#required`. |
| `api_org` | no | OpenAI organization ID (needed by some endpoints). |

`ClientFactory::create()` builds `\OpenAI::client($api_key, $api_org)` — exposed as service
`openai.client`.

## Storing the key
The key is saved as ordinary Drupal config. Per the campaign's guidance this is **not** a
vulnerability: override it out of config for real deployments via `settings.php`
(`$config['openai.settings']['api_key'] = getenv('OPENAI_API_KEY');`) or an environment-driven
config override, so it need not live in exported config. The module does **not** integrate the
Key module.

## Other admin routes
- `openai.models` → `/admin/config/openai/settings/models` — `Admin::listModels()` lists the
  models available to your account (via `openai.api->getModels()`).
- `openai.docs` → `/admin/config/openai/settings/docs` — `Admin::docs()` returns a
  `TrustedRedirectResponse` to `https://platform.openai.com/docs`.
- `openai.admin_config_openai` → `/admin/config/openai` — the section landing menu.

All are gated by `administer site configuration`.

## Missing-key warning
`OpenAIEventSubscriber::onKernelRequest()` shows an admin warning message on admin routes when
`api_key` is empty, pointing to this settings form — so features don't fail silently.

## Enable submodules for actual features
Core is plumbing only. Enable the submodule(s) you need (see the parent start.md list), each
adds its own routes/permissions/forms on top of `openai.api`.
