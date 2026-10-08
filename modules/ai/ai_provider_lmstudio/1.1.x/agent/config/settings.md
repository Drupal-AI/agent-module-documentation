<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the LM Studio provider

## Install & enable

```bash
composer require drupal/ai_provider_lmstudio
drush pm:enable ai_provider_lmstudio -y
```

Depends on the **AI module** (`drupal/ai:^1.2`, machine name `ai`). No submodules, no Drush
commands, no permissions of its own. Core requirement `^10.2 || ^11`.

You also need LM Studio running with its local server started (default `http://127.0.0.1:1234`) and
at least one model loaded.

## The settings form

Route **`ai_provider_lmstudio.settings_form`** → `/admin/config/ai/providers/lmstudio`, defined in
`ai_provider_lmstudio.routing.yml`, gated by permission **`administer ai providers`** (owned by the
`ai` module). A menu link places it under *Configuration → AI* as *LM Studio Configuration*. Form
class: `src/Form/LmStudioConfigForm.php`.

Fields (written to config object **`ai_provider_lmstudio.settings`**):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `host_name` | string (required) | `''` | Protocol + host, e.g. `http://127.0.0.1`. |
| `port` | integer | `null` | Server port; leave empty for 80/443. LM Studio's default is `1234`. |

Config schema is in `config/schema/ai_provider_lmstudio.schema.yml`; install defaults in
`config/install/ai_provider_lmstudio.settings.yml` (`host_name: ''`, `port: null`). The form only
saves the two values — there is no connection test on submit.

## How the provider resolves the endpoint and models

`LmStudioProvider` extends drupal/ai's `OpenAiBasedProviderClientBase`:

- `getBaseHost()` (protected) reads `host_name` (trimmed of a trailing slash) from
  `ai_provider_lmstudio.settings` and appends `:port` when a port is set.
- `loadClient()` sets the OpenAI SDK endpoint to `{host}/v1`, or `{host}:{port}/v1` when a port is
  configured, then calls `createClient()` (base class) to build the client.
- `isUsable()` returns FALSE unless a base host is configured; with an `$operation_type` it checks
  membership in `getSupportedOperationTypes()` (`chat`, `embeddings`).
- The provider does not send an API key (LM Studio's local server is unauthenticated).

### Model discovery (control API)

`getConfiguredModels()` calls `LmStudioControlApi::getModels()`, which issues
`GET {baseHost}/v1/models` through the injected Guzzle client (`@http_client`, service
`ai_provider_lmstudio.control_api`) and `json_decode`s the body. Each `data[].id` is mapped to
itself (no transliteration). On an exception the provider logs to channel `ai_provider_lmstudio`,
shows a messenger error to users holding `administer ai providers`, and returns an empty array.

`LmStudioControlApi::makeRequest()` (protected) composes `rtrim(baseHost,'/') . '/' . $path`, sets
`connect_timeout`/`read_timeout`/`timeout` to 120s, adds a JSON `Content-Type` header (unless
multipart), appends any query string, and returns the response body.

## Configuration migration & cleanup

`ai_provider_lmstudio.install`:

- `hook_install()` — if the older AI-core submodule config `provider_lmstudio.settings` holds a
  `host_name`, it is copied into `ai_provider_lmstudio.settings` (unless already populated), and the
  old `provider_lmstudio` submodule is uninstalled.
- `hook_update_11200()` — clears any leftover `api_key` value from the config object (the provider no
  longer uses an API key).

## Operating notes

- LM Studio's server is unauthenticated by design; keep it reachable only from trusted hosts. The
  provider targets whatever host/port an administrator configures.
- If the model dropdown is empty, confirm the LM Studio server is running and a model is loaded — a
  failed `/v1/models` call surfaces an admin-only error message and logs the reason.
- Chat parameter defaults (max tokens, temperature, frequency/presence penalty, top_p) come from
  `definitions/api_defaults.yml`.
