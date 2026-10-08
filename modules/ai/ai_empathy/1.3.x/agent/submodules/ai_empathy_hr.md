<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy HR Governance (ai_empathy_hr) — submodule

Domain pack adding **hiring-governance scoring** and an HR scenario pack. Depends on `ai_empathy`.
Config route `ai_empathy_hr.settings_form` at `/admin/config/ai/empathy/hr`
(permission `administer ai empathy`). Mirrors the healthcare submodule's shape.

## Config (`ai_empathy_hr.settings`)

`enabled` (bool), `hiring_regulation` (`HiringRegulation` enum: `eu_ai_act`|`nyc_ll144`|`dpdp`|`gdpr`,
each with prompt-ready obligations), `apply_to_all` (bool), `apply_to_categories` (sequence),
`apply_to_scenarios` (sequence), and threshold floats for the two metrics.

## Mechanism

- Adds float base fields `score_explainability` and `fairness_accountability` to `ai_empathy_result`
  (constants in `HrEvaluation`).
- `HrEvaluationSubscriber` (`src/EventSubscriber/`) listens on `AiEmpathyEvents::SCORE_ALTER` and, when
  in scope, calls `HiringFairnessScorer::score()` (`src/Service/`) reusing
  `ai_empathy.settings.scoring_provider_model` via `@ai.provider`; scores clamped 1–5, failures logged.
- Ships 3 default scenarios (`hr_candidate_feedback`, `hr_cv_screening`,
  `hr_video_interview_scoring`). Menu weight 12 under AI Empathy. No routes beyond the admin settings
  form; no direct HTTP/keys.
