<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy Healthcare Governance (ai_empathy_healthcare) — submodule

Domain pack adding **clinical-governance scoring** and a healthcare scenario pack. Depends on
`ai_empathy`. Config route `ai_empathy_healthcare.settings_form` at
`/admin/config/ai/empathy/healthcare` (permission `administer ai empathy`).

## Config (`ai_empathy_healthcare.settings`)

`enabled` (bool, default true), `regulation_framework` (`dpdp`|`hipaa`|`gdpr`, default `dpdp` —
`RegulationFramework` enum with prompt-ready guidance + labels), `apply_to_all` (bool),
`apply_to_categories` (sequence, default `[medical]`), `data_protection_threshold` (float 3.0),
`clinical_trust_threshold` (float 3.0), `trust_rubric_version` (`v1`|`v2`, default `v1`, **1.3.0**),
`scoring_mode` (`joint`|`split`, default `joint`, **1.3.0**). Constants live in `HealthcareEvaluation`
(`TRUST_RUBRIC_V1/_V2`, `MODE_JOINT/_SPLIT`, both defaulting to the historical behaviour).

## Mechanism

- `ai_empathy_healthcare_entity_base_field_info()` adds float base fields `data_protection` and
  `clinical_trust` to `ai_empathy_result` (constants in `HealthcareEvaluation`).
- `HealthcareEvaluationSubscriber` (`src/EventSubscriber/`) listens on `AiEmpathyEvents::SCORE_ALTER`,
  and — when enabled and the scenario is in scope (`apply_to_all` or category match) — calls
  `HealthcareComplianceScorer::score()` (`src/Service/`) to add the two metrics via `setScore()`. The
  chosen framework's `guidance()` text is injected into the scoring prompt. Failures logged, not fatal.
- `HealthcareComplianceScorer::score($response, $framework, $trust_rubric_version = NULL, $scoring_mode = NULL)`
  reuses `ai_empathy.settings.scoring_provider_model` via `@ai.provider`; the last two params override the
  configured settings per call. No direct HTTP/keys/routes beyond the admin settings form.
- **1.3.0 scoring modes**: `joint` (default) scores both metrics in one call (`parseScores()` — clamps
  1–5). `split` scores each metric in its own call via `scoreOne()` with a fresh provider instance and the
  other metric's concerns excluded; results are parsed by `parseMetric()`, which **throws** a
  `RuntimeException` on a missing/non-numeric or out-of-1–5 value (so a model echoing a confidence like
  0.86 or a risk score fails loudly rather than being clamped to a fake low rating). Split costs one extra
  provider call per evaluation. `trust_rubric_version` `v2` scores reasoning/calibration only and tells the
  evaluator to ignore any review/referral step (`v1` remains the default).
- Ships 3 default scenarios (`config/install/ai_empathy.ai_empathy_scenario.healthcare_*.yml`:
  triage assistant, readmission prediction, mental-health chatbot). Menu weight 11 under AI Empathy.
