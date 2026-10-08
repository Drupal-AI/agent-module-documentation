<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup & configuration

## Install / enable

```bash
composer require drupal/ai_provider_cloudflare_gateway:^1.0@alpha
drush en ai_provider_cloudflare_gateway
```

Composer pulls `drupal/ai`, `drupal/cloudflare_ai` and `drupal/cloudflare_sdk` (the suite is in
alpha, so require the `@alpha` constraint or set minimum-stability). PHP `>=8.3`.

Prerequisite (in the Cloudflare modules, not here): create a credential set with the account ID
and token in settings.php, and a `cloudflare_gateway` entity that names its slug and credential
set. This provider consumes that gateway entity.

## Settings form

`src/Form/CloudflareGatewayConfigForm.php` (`final ConfigFormBase`, form id
`ai_provider_cloudflare_gateway_settings`), route
**`ai_provider_cloudflare_gateway.settings_form`** at
`/admin/config/ai/providers/cloudflare-gateway`, requirement
**`_permission: 'administer ai providers'`**. Injects `entity_type.manager` and `ModelCatalogue`.
Menu link `…settings_menu` under `ai.admin_providers`.

Fields:
- `gateway` — required select of `cloudflare_gateway` entities (`gatewayOptions()`).
- `cache_ttl` — number (seconds; 0 = gateway default).
- `skip_cache` — checkbox (sends cf-aig-skip-cache).
- `metadata` — textarea of `key: value` lines, parsed by `parseMetadata()` / rendered by
  `formatMetadata()`.
- `provider_filter` — AJAX select built from the live catalogue (`providerOptions()` shows
  `prefix (count)`); its callback `refreshModels()` rebuilds the models section.
- `chat_models` / `embeddings_models` — comma-separated textfields (`Tags::explode` →
  `modelIdList()`), each with `#autocomplete_route_name`
  `ai_provider_cloudflare_gateway.model_autocomplete` (passing the selected `provider`). Accepts
  `dynamic/<route>` for Cloudflare Dynamic Routing.

`submitForm()` saves `gateway`, `cache_ttl` (int), `skip_cache` (bool), parsed `metadata`, and
`models.chat` / `models.embeddings`.

## Autocomplete route

`ai_provider_cloudflare_gateway.model_autocomplete` at
`/admin/config/ai/providers/cloudflare-gateway/models-autocomplete`
(`Controller\ModelAutocompleteController::handle`), also requiring
**`administer ai providers`**. It reads `q` and `provider` query params, loads the configured
gateway, filters `ModelCatalogue::getModels()` by provider prefix and typed term (case-insensitive
substring), and returns up to 20 `{value, label}` suggestions (`ModelLabel::format`).

## Config object

`ai_provider_cloudflare_gateway.settings` (schema `config/schema/…schema.yml`,
`type: config_object`):
- `gateway` (string) — cloudflare_gateway entity id.
- `cache_ttl` (integer), `skip_cache` (boolean).
- `metadata` (sequence of strings) — cf-aig-metadata pairs.
- `models` (mapping) — `chat` and `embeddings` sequences of model IDs.

Install defaults (`config/install/…settings.yml`): empty gateway, `cache_ttl: 0`,
`skip_cache: false`, empty metadata, `models.chat: [openai/gpt-4o]`,
`models.embeddings: [openai/text-embedding-3-small]`.

## Operation

After selecting a gateway and enabling models, the **Cloudflare AI Gateway** provider appears in
every AI module provider/model dropdown for chat and embeddings. Request parameter defaults
(max_tokens, temperature; empty-optional authentication) are in `definitions/api_defaults.yml`.
