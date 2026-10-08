<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the llama.cpp provider

## Install & enable

```bash
composer require drupal/ai_provider_llama_cpp
drush pm:enable ai_provider_llama_cpp -y
```

Depends on the **AI module** (`drupal/ai:^1.2.0`, machine name `ai`). No submodules, no Drush
commands, no permissions of its own. Core requirement `^10.2 || ^11`.

You also need a running `llama-server` reachable from the Drupal web container, e.g.:

```bash
llama-server --model /path/to/model.gguf --port 8080            # chat
llama-server --model /path/to/embed.gguf --port 8080 --embeddings   # embeddings
```

## The settings form

Route **`ai_provider_llama_cpp.settings_form`** →
`/admin/config/ai/providers/llama-cpp`, defined in `ai_provider_llama_cpp.routing.yml`, gated by
permission **`administer ai providers`** (a permission owned by the `ai` module). A menu link
(`ai_provider_llama_cpp.links.menu.yml`) places it under *Configuration → AI* as
*llama.cpp Configuration*. Form class: `src/Form/LlamaCppConfigForm.php`.

Fields (both written to config object **`ai_provider_llama_cpp.settings`**):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `host_name` | string (required) | — | Protocol + host, e.g. `http://127.0.0.1`, or `http://host.docker.internal` for DDEV/Docker. |
| `port` | string | `8080` | Server port; may be left empty for a default port. llama.cpp default is 8080. |

Config schema is in `config/schema/ai_provider_llama_cpp.schema.yml` (both keys typed `string`).

`validateForm()` instantiates the `llama_cpp` provider with the submitted host/port and calls
`testConnection()` (a `/v1/models` list). If the server is unreachable it sets a form error on
`host_name` and the config is not saved. `submitForm()` persists `host_name` and `port`.

The form also renders a models table via `AiProviderFormHelper::getModelsTable()` (from the `ai`
module) so an admin can see and select the models the server currently exposes.

## How the provider resolves the endpoint and models

`LlamaCppProvider` extends drupal/ai's `OpenAiBasedProviderClientBase`:

- `getBaseHost()` (protected) reads `host_name` (and `port`) from the plugin's runtime
  configuration or from `ai_provider_llama_cpp.settings`, trims a trailing slash, and appends
  `:port` when a port is set.
- `loadClient()` sets the endpoint to `rtrim($host,'/') . '/v1'`, constructs the HTTP client with a
  600-second timeout (`new GuzzleClient(['timeout' => 600])`), and calls `createClient()` to build
  the OpenAI SDK client. It throws `AiRequestErrorException` if no host is configured.
- `isUsable()` returns FALSE unless a base host is configured; with an `$operation_type` it checks
  membership in `getSupportedOperationTypes()` (`chat`, `embeddings`).
- `hasAuthentication()` returns **FALSE** and `setAuthentication()` only resets the client — no API
  key is sent or stored; this provider is for unauthenticated local/self-hosted servers.

### Model discovery & caching

`getConfiguredModels()` calls `$this->client->models()->list()`. For each returned model it derives
a machine id with `getMachineName()` (`transliteration->transliterate()` → `mb_strtolower()` →
`preg_replace('@[^a-z0-9_]+@','_', …)`) and builds a `machine_id => raw_id` map, saved to State key
**`ai_provider_llama_cpp.models`**. If the request throws, it logs to channel
`ai_provider_llama_cpp` and returns the last cached State map, so the selectable model list survives
a temporarily offline server.

`chat()` and `embeddings()` call `getModel()` to translate the stored machine id back to the raw
llama.cpp model id before delegating to the parent implementation. `embeddingsVectorSize()` calls
`models()->retrieve($raw_id)` and reads `embedding.size` / `hidden_size` / `context_length` from the
metadata, falling back to the parent default on error.

`hook_uninstall()` (`ai_provider_llama_cpp.install`) deletes the State model cache on uninstall.

## Operating notes

- Because there is no authentication, keep `llama-server` reachable only on a trusted network
  segment; the provider simply targets whatever host/port an administrator configures.
- The model list is cached in State — after starting the server with different models, revisit the
  settings form (or re-run model discovery) to refresh the map.
- The 600-second client timeout accommodates slow local generation on large models.
