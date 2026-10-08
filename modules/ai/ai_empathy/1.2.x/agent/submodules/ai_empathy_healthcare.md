<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy Healthcare Governance (ai_empathy_healthcare) — submodule

Domain pack adding **clinical-governance scoring** and a healthcare scenario pack. Depends on
`ai_empathy`. Config route `ai_empathy_healthcare.settings_form` at
`/admin/config/ai/empathy/healthcare` (permission `administer ai empathy`).

## Config (`ai_empathy_healthcare.settings`)

`enabled` (bool, default true), `regulation_framework` (`dpdp`|`hipaa`|`gdpr`, default `dpdp` —
`RegulationFramework` enum with prompt-ready guidance + labels), `apply_to_all` (bool),
`apply_to_categories` (sequence, default `[medical]`), `data_protection_threshold` (float 3.0),
`clinical_trust_threshold` (float 3.0).

## Mechanism

- `ai_empathy_healthcare_entity_base_field_info()` adds float base fields `data_protection` and
  `clinical_trust` to `ai_empathy_result` (constants in `HealthcareEvaluation`).
- `HealthcareEvaluationSubscriber` (`src/EventSubscriber/`) listens on `AiEmpathyEvents::SCORE_ALTER`,
  and — when enabled and the scenario is in scope (`apply_to_all` or category match) — calls
  `HealthcareComplianceScorer::score()` (`src/Service/`) to add the two metrics via `setScore()`. The
  chosen framework's `guidance()` text is injected into the scoring prompt. Failures logged, not fatal.
- `HealthcareComplianceScorer` reuses `ai_empathy.settings.scoring_provider_model` via `@ai.provider`,
  parses/clamps scores 1–5. No direct HTTP/keys/routes beyond the admin settings form.
- Ships 3 default scenarios (`config/install/ai_empathy.ai_empathy_scenario.healthcare_*.yml`:
  triage assistant, readmission prediction, mental-health chatbot). Menu weight 11 under AI Empathy.
