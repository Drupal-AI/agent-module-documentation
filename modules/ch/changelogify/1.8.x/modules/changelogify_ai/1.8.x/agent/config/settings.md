<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Changelogify AI configuration (`changelogify_ai.settings`)

Edited at `/admin/config/development/changelogify/ai` via `Form\SettingsForm` (route `changelogify_ai.settings`, permission `administer changelogify ai`). Schema `config/schema/changelogify_ai.schema.yml`; install defaults `config/install/changelogify_ai.settings.yml`.

## Keys
- `consent_external_processing` (bool, default FALSE) — master gate. No AI request runs until an admin turns this on; enforced in `DrupalAiSummarizer::isAvailable()`/`summarize()` independently of provider config.
- `provider` (type `ai.provider_config`) — `{use_default, provider, model, config}`. Selected with the core `ai_provider_configuration` form element. `use_default: true` uses the site-wide default Drupal AI chat provider/model. Credentials are NOT here — they live in Drupal AI / Key.
- `eligibility.categories` (sequence) — which recorded event categories AI may consider: any of `content`, `extensions`, `users`, `configuration`, `custom` (default all). At least one is required (validated). Maps site event sources → categories in `OutboundPayloadBuilder::sourceCategory()`.
- `policy` (mapping) — what identifying/structure info may LEAVE the site, independent of eligibility:
  - `preset`: `recommended` | `more_context` | `custom`.
  - Per-field treatments `redact` | `include`: `usernames`, `actor_ids`, `entity_ids`, `paths`, `unpublished_labels`, `bundle_labels`, `changed_field_names`, `correlation_ids`. Recommended redacts identifying fields and includes only `bundle_labels` + `changed_field_names`; `more_context` also includes `entity_ids` + `paths`.
  - `allowlisted_values` (ignored-type map) — explicit field names whose values may be shared; credential-like names are always rejected (`OutboundPayloadBuilder::isCredentialKey()`).
  - `allow_manual_humanization` (bool) — permit sending manually written items (no source evidence).
- `organization_guidance` (string ≤1000) — org-wide editorial guidance; sanitized and explicitly cannot override system safety rules.
- `output_language` (string) — IETF tag, validated `^[A-Za-z]{2,3}(?:-[A-Za-z0-9]{2,8})*$`, default `en`.
- `history_retention_days` (int 1–3650, default 90) — retention for the privacy-bounded operation history (`hook_cron` purge; no release text is stored).

## Setup flow (SettingsForm)
The form shows a readiness table, a payload-preview link (`changelogify_ai.payload_preview`), the consent toggle, provider selection (with a development-provider warning for test/fake/deterministic providers), eligibility checkboxes, an AJAX privacy-policy panel with an effective-policy summary + sensitive-includes warning, guidance/language, and retention. "Save and verify configuration" reports readiness via `AiReadinessChecker` without contacting the provider. Config is read cacheably; controllers/forms surface `config:changelogify_ai.settings` cache dependencies.
