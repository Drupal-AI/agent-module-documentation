<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & provider settings

## Install / enable
`composer require drupal/ai_document_ocr` (pulls `google/cloud-document-ai:^1.0`), then enable with deps `ai`, `key`, `ai_automators`. Requires the `openssl` PHP extension (JWT signing of the service-account assertion).

## Config object: `ai_document_ocr.settings`
Defined in `config/install/ai_document_ocr.settings.yml`, schema in `config/schema/ai_document_ocr.schema.yml` (`type: config_object`). Keys:
- `general_credentials_file` (string) — the machine name of a Key entity holding the Google Cloud service-account JSON. Default `''`.
- `default_region` (string) — Document AI location/region. Install default `eu`. Provider falls back to `us` if unset (`DocumentOcrProvider::documentToText()`).
- `processor_id` (string) — the selected Document AI processor id. Default `''`.

Note: `DocumentOcrProvider::applyProviderDefaults()` and `getPromptTemplate()` read several extra keys (`default_confidence_threshold`, `default_extract_structured_data`, `default_timeout`, `default_max_file_size`, `cache_enabled`, `cache_duration`, `form_prompt`, `handwriting_prompt`, `general_prompt`) but the settings form never writes them and they are absent from the schema — they resolve to their inline fallbacks (e.g. confidence `0.8`, extract structured data `TRUE`).

## Settings form: `Form\AiProviderConfigForm`
Route `ai_document_ocr.ai_provider` → path `/admin/config/ai/providers/document-ocr`, permission `administer ai_document_ocr` (`restrict access: true`). Menu link `ai_document_ocr.ai_provider` under `ai.admin_providers`. Form id `ai_document_ocr_provider_config_form`; `getEditableConfigNames()` = `['ai_document_ocr.settings']`.

Flow:
1. `buildForm()` uses `AiProviderFormHelper::generateAiProvidersForm()` for AI-provider selection, then a `key_select` element (`#key_filters => ['provider' => 'file']`) for the service-account key. If the Key module is absent it shows an error and no credential field.
2. Selecting a key fires the AJAX `loadProcessorsCallback()`, which:
   - reads the JSON via `getProjectIdFromKey()` → `project_id`;
   - `getAccessToken()` builds a JWT (`Firebase\JWT\JWT::encode`, RS256, scope `cloud-platform`) from `client_email`/`private_key` and POSTs it to `https://oauth2.googleapis.com/token` (Guzzle);
   - `loadAvailableProcessors()` loops every region in `getRegionOptions()` (us, eu, us-central1, us-east1, us-west1, europe-west1/2/4, asia-east1, asia-northeast1, asia-southeast1), GET `{region}-documentai.googleapis.com/v1/projects/{project}/locations/{region}/processors` with a Bearer header (10s timeout), and lists processors whose `state === 'ENABLED'` as `displayName (region)` keyed by `basename($processor['name'])`.
3. `submitForm()` saves `general_credentials_file` and `processor_id` (the `default_region`/location is not written by this form — it comes from install default `eu` or must be set via config).

## Credentials
Loaded through the Key module only. `DocumentOcrProvider::loadCredentials()` calls `keyRepository->getKey($key_id)->getKeyValue()` and `Json::decode()`s it; `project_id` is read from the decoded JSON (`getProjectIdFromCredentials()`). No credentials are stored in module config beyond the Key machine name. `isConfigured()` returns TRUE once `general_credentials_file` is set.

All outbound calls use HTTPS Google endpoints; the Guzzle client uses default TLS verification (no `verify => false`).
