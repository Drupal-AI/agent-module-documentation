<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & OpenAI credentials

Class: `Drupal\feedback_ai\Form\FeedbackAiSettingForm` (extends `ConfigFormBase`).
Form id: `feedback_openai_settings`. Route: `feedback_ai.feedback_api_settings` at
`/admin/config/feedbackopenai/settings` (menu: Configuration > Feedback OpenAI > Api Settings),
requirement `_permission: 'administer feedback ai'`.

## Config object
Editable config name: `feedback_openai.settings` (`getEditableConfigNames()`). Keys written by
`submitForm()`:

| Key | Field type | Purpose | Default |
|-----|-----------|---------|---------|
| `feedbackai_secret_key` | textfield (required) | OpenAI API bearer token, stored in this config object | — |
| `feedbackai_endpoint` | textfield | Chat Completions endpoint | `https://api.openai.com/v1/chat/completions` |
| `feedbackai_api_model` | select | Model name | `gpt-3.5-turbo` (options: gpt-3.5-turbo, gpt-4, gpt-4-turbo, gpt-4o) |
| `feedbackai_api_max_token` | textfield | Max tokens (input+output) | `256` |

The credential is held in **plain module configuration** (`feedback_openai.settings:feedbackai_secret_key`);
the module does not use the Key module or an environment variable. It is read back at runtime by
`FeedbackOpenAIClient` (see [api/openai-client.md](../api/openai-client.md)).

> No `config/schema/*` file ships with the module, so these keys have no config schema definition.

## Validation (`validateForm()`)
- Endpoint must match exactly `^https://api\.openai\.com/v1/chat/completions$` (regex) when non-empty.
- Secret key must match `^[A-Za-z0-9-_]+$` (alphanumeric, hyphen, underscore) when non-empty.
- Max token must be numeric.

## Related routes/links
- `feedback_ai.feedback_admin_config_openai` (`/admin/config/Feedback openai`) — a
  `SystemController::systemAdminMenuBlockPage` admin-menu landing page, same permission.
- Menu links in `feedback_ai.links.menu.yml`; the settings link weight is `-90`.
