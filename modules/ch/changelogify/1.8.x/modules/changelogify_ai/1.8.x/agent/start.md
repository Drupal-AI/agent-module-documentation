<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Changelogify AI (changelogify_ai) — agent index

Optional Changelogify submodule adding **evidence-backed, bring-your-own-key AI drafting** of release notes via the Drupal AI module. Version dir **1.8.x** (installed 1.8.1). Core `^10.5 || ^11.2`, PHP `>=8.1`.

## Dependencies
`changelogify:changelogify` and `ai:ai (^1.4)`. Uses the Drupal AI provider abstraction (`@ai.provider`); provider credentials are managed by Drupal AI + Key, never by this module.

## What it does (3 operations)
1. **Synthesize** a full draft release from a window's eligible evidence (`SynthesisJobManager` → `SynthesisDraftFinalizer`).
2. **Humanize item** — rewrite one release-note item (`ReleaseSuggestionManager::suggest/accept`).
3. **Humanize release** — rewrite all selected notes (`suggestRelease/acceptRelease`).
Nothing publishes automatically; suggestions are staged and accepted into a new release revision only on explicit editor action, with stale-revision protection.

## Gating (defense in depth)
- Config `consent_external_processing` (admin toggle, default FALSE) — checked in `DrupalAiSummarizer::isAvailable()/summarize()`.
- Permission `use changelogify ai` per editor; `administer changelogify ai` (config); `view changelogify ai history`.
- `AiReadinessChecker::status()` reports readiness without exposing credentials.

## Permissions (`changelogify_ai.permissions.yml`)
`administer changelogify ai` (restrict access), `use changelogify ai`, `view changelogify ai history`.

## Routes (`changelogify_ai.routing.yml`)
- `changelogify_ai.settings` `/admin/config/development/changelogify/ai` — `Form\SettingsForm` (`administer changelogify ai`).
- `changelogify_ai.payload_preview` — no-network filtered payload preview (`administer changelogify ai`).
- `changelogify_ai.operation_history` `/…/ai/history` — `Controller\OperationHistoryController` (`view changelogify ai history`).
- `changelogify_ai.synthesis_job` `/…/ai/jobs/{job_id}` + `.synthesis_job_status` — `Controller\SynthesisJobController`; custom access `SynthesisOperationAccess::view` (owner or privileged); `job_id` = 64-hex.
- `changelogify_ai.cancel_operation` — `Form\CancelOperationForm`; access `SynthesisOperationAccess::cancel`.
- `changelogify_ai.humanize_item` `/admin/content/changelogify/releases/{changelogify_release}/items/{item_id}/humanize` — `Form\HumanizeItemForm` (`use changelogify ai` + `_entity_access: changelogify_release.update`).

## Key services (`changelogify_ai.services.yml`, autowired)
`DrupalAiSummarizer` (impl of `Summarization\SummarizerInterface`), `PromptTemplateRegistry`, `OutboundPayloadBuilder`, `ResultValidator`, `SynthesisEvidenceSelector`, `SynthesisJobManager`, `SynthesisDraftFinalizer`, `SynthesisProvenanceResolver`, `SynthesisStatusBuilder`, `ReleaseSuggestionManager`, `CompleteDraftGenerator`, `AiOperationManager`, `AiOperationHistoryRepository`, `AiReadinessChecker`, `AiFailureMessage`, `DrupalAiChatRequestFactory` (`ChatRequestFactoryInterface`), `SynthesisOperationAccess` (tagged `access_check`).

## Storage
Table `changelogify_ai_operation` (`changelogify_ai.install` `hook_schema`) — privacy-bounded operation summaries (no release text), queried via `AiOperationHistoryRepository`. `hook_cron` purges per `history_retention_days`.

## Hooks (`changelogify_ai.module`)
`hook_form_changelogify_release_form_alter` (inline "Improve with AI" + release workspace), `hook_form_changelogify_generate_release_form_alter` (AI synthesis draft), `hook_theme` (`changelogify_ai_job`), `hook_cron`.

## Solution docs
- `agent/config/settings.md` — `changelogify_ai.settings`, consent, provider, eligibility & privacy policy.
- `agent/architecture/synthesis.md` — evidence selection, payload filtering, prompts, job flow, review/accept.
