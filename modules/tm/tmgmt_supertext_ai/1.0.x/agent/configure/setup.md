<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Supertext AI translator

## Steps
1. Enable the module: `drush en tmgmt_supertext_ai` (pulls in `tmgmt`).
2. Go to **Admin → Translation → Providers** (`/admin/tmgmt/translators`) and add/edit a translator.
3. Set **Plugin** = *Supertext AI translator*.
4. Fill the settings:
   - **API key** (textarea, required) — from the Supertext Cockpit (`https://www.supertext.com/cockpit/api`). Stored in config as `api_key`.
   - **API server** — `live`, `staging` (labelled Development), `testing`, or `other`.
   - **Other API server url** — required only when server = `other`.
5. Save. On save, `validateConfigurationForm()` sends a dummy `text/quote` request; invalid credentials/URL block the save with the API error.

## Endpoint resolution (`SupertextAITranslator::getApiUrl`)
- `live` → `https://api.supertext.com/v1/translate/ai/`
- `other` → the trimmed `api_server_other` (must be non-empty) with a trailing `/`
- anything else → `https://api.<api_server>.supertext.com/v1/translate/ai/`

## Request flow
`requestTranslation()` → per job item `requestJobItemTranslation()` → `dataHelper->filterTranslatable()` → chunked by `SupertextAiData` (≤10 000 chars, `tag_handling=html`, `politeness=default`) → POST `text` with header `Authorization: Supertext-Auth-Key <key>`, `timeout=60` → decode `translated_text` → `addTranslatedData(unflatten(...))`. Exceptions call `$job->rejected()`.

## Programmatic knobs (`SupertextAiData`)
`setPoliteness('default'|'more'|'less')`, `setTagHandling('none'|'xml'|'html')`, `setGlossary([source=>target])`.

## Security notes
- HTTPS with default TLS verification; no `verify => false`.
- API key persists as plaintext in the translator config entity — keep config exports out of public repos or use environment-specific overrides.
