<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Vertex — configuration & authentication

## Install / enable

```
composer require drupal/ai_provider_google_vertex
drush en ai_provider_google_vertex
```

Pulls in `drupal/ai`, `drupal/key` and the `google/cloud-ai-platform` Composer library. Streaming
chat additionally needs the gRPC PHP extension (see the Google gRPC-for-PHP guide) and a web server
that can emit chunked output.

## Google Cloud prerequisites

1. Create/enable a Google Cloud project and enable the Vertex AI API (`aiplatform.googleapis.com`).
2. Create a service account with a Vertex AI role (baseline `roles/aiplatform.user`).
3. Create a JSON key for that service account and download it.

## Config object

Config name (`VertexConfigForm::CONFIG_NAME`): **`ai_provider_google_vertex.settings`**.

- The settings **form** (`VertexConfigForm::buildForm`/`submitForm`) reads and writes the key
  **`general_credential_file`** — a `key_select` element holding the machine name of a **Key entity**
  (drupal/key). `VertexProvider::loadCredentials()` and `isUsable()` also read
  `general_credential_file`.
- `config/install/ai_provider_google_vertex.settings.yml` and
  `config/schema/ai_provider_google_vertex.schema.yml` declare the key `general_credentials_file`
  (note the extra "s"); the runtime code path uses the singular `general_credential_file` set by the
  form, so the value the provider actually consumes is the one saved through the form.
- Update hook `ai_provider_google_vertex_update_10001()` (in the `.install`) migrates an existing
  credential Key to the key `file` provider when present.

## How credentials are stored and used

- The **service-account JSON is never stored in this module's own config as plaintext.** Config only
  stores the *machine name* of a Key entity. Choose the Key provider (File path, environment
  variable, or another secure provider) on the Key admin page (`/admin/config/system/keys`).
- At request time `VertexProvider::loadCredentials()` calls `keyRepository->getKey($key_id)` then
  `$key->getKeyValue()` and JSON-decodes the credential. `getAccessToken()` passes the decoded
  credential to `Google\Auth\Credentials\ServiceAccountCredentials` (scope
  `https://www.googleapis.com/auth/cloud-platform`) and calls `fetchAuthToken()`; the resulting
  `access_token` is sent as an `Authorization: Bearer …` header via `getAuthHeaders()`. The
  service-account private key is not written to logs and is not rendered back into the settings form
  (the form only exposes a Key selector, not the key value).

## Route, permission, menu

- Route `ai_provider_google_vertex.settings_form` → path
  `/admin/config/ai/providers/google_vertex`, requirement `_permission: 'administer ai providers'`
  (the AI module's own permission). No `_access: TRUE` routes exist.
- Menu link `ai_provider_google_vertex.settings_menu` under parent `ai.admin_providers`.

## Models table (dynamic models)

Because `$hasPredefinedModels = FALSE`, the settings form embeds the AI module's models table
(`AiProviderFormHelper::getModelsTable`). For each model `VertexProvider::loadModelsForm()` collects:

- **Project ID** (`project_id`) — Google Cloud project id (required).
- **Location** (`location`) — region, e.g. `us-central1`, `europe-west4` (required).
- **Vertex Model ID** (`vertex_model_id`) — e.g. a Gemini model id (required for chat/embeddings).
- **Data Store** (`datastore`) — optional Vertex AI Search datastore id for grounding.
- For `translate_text`, the model id becomes a **select** limited to the `TranslationModels` enum
  (`TLLM`, `NMT`); no free-text Vertex model id field is shown.

These per-model values are stored by the AI module's model-config storage (not in this module's own
settings object) and read back via `getModelInfo($operation_type, $model_id)`.
