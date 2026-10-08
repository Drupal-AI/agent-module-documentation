<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy Evaluation (ai_empathy) — agent index

Framework that **scores AI responses to ethical-dilemma scenarios** for empathetic decision-making,
through Drupal's **`ai`** provider layer. Package `AI`. Requires `drupal/ai ^1.3` (dep `ai:ai`).
Core `^10.4 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.2.0. Configure route
`ai_empathy.settings_form`. All UI is under `/admin/config/ai/empathy`. No Drush.

## What it provides

- **Entities**: `ai_empathy_scenario` (config entity — the dilemma + reference decision + difficulty),
  and content entities `ai_empathy_result`, `ai_empathy_session`, `ai_empathy_rating`,
  `ai_empathy_comparison`. Defined in `src/Entity/*.php`.
- **Services** (`ai_empathy.services.yml`): `ai_empathy.evaluator` (runs a scenario through a provider),
  `ai_empathy.scoring` (grades a response — the core reused everywhere), `ai_empathy.training`,
  `ai_empathy.reliability`, `ai_empathy.scenario_generator`, `ai_empathy.calibration`,
  `ai_empathy.benchmark`, `ai_empathy.scheduled_evaluator`. See [api/services.md](api/services.md).
- **Events** `AiEmpathyEvents::PROMPT_ALTER` and `::SCORE_ALTER` — extension points submodules use to
  add prompt context and extra score metrics. `src/Event/`.
- **Permissions** (`ai_empathy.permissions.yml`): `administer ai empathy` (restricted),
  `run ai empathy evaluation`, `view ai empathy results`, `rate ai empathy results`.
- **Hooks**: `hook_cron` → scheduled evaluator; `hook_mail` (`threshold_alert`); `hook_theme`.
- **Enums**: `ScenarioCategory` (military/medical/emotion/cultural/organizational),
  `DifficultyLevel` (1–5). `src/Enum/`.
- **Config**: object `ai_empathy.settings` (providers, thresholds, scheduling) + 19 default
  `ai_empathy_scenario` entities in `config/install/`. Schema in `config/schema/`.

## Solution docs

- **Settings, thresholds, scheduled cron evaluation** → [config/settings.md](config/settings.md)
- **Scenarios, results, routes & permissions** → [entities/entities.md](entities/entities.md)
- **Services, the scoring pipeline, and events** → [api/services.md](api/services.md)

## Submodules (8, folded into this project's docs)

Each is documented under [submodules/](submodules/):

- [ai_empathy_guardrail](submodules/ai_empathy_guardrail.md) — `empathy_score_check` AiGuardrail plugin (blocks low-empathy output; **fails closed**).
- [ai_empathy_field_action](submodules/ai_empathy_field_action.md) — `check_empathy` FieldWidgetAction button + optional content-moderation publish gate.
- [ai_empathy_governance](submodules/ai_empathy_governance.md) — adds Accountability + Trust metrics and the triad view.
- [ai_empathy_observability](submodules/ai_empathy_observability.md) — emits OpenTelemetry spans per result.
- [ai_empathy_ccc](submodules/ai_empathy_ccc.md) — Context Control Centre tone-alignment scoring + `request_tag` AiContextScope.
- [ai_empathy_healthcare](submodules/ai_empathy_healthcare.md) — clinical governance metrics + scenario pack.
- [ai_empathy_hr](submodules/ai_empathy_hr.md) — hiring-fairness metrics + scenario pack.
- [ai_empathy_finance](submodules/ai_empathy_finance.md) — finance scenario pack (config only).

Every submodule depends on `ai_empathy`; guardrail/ccc/governance also need `ai`, field_action needs
`field_widget_actions`, ccc needs `ai_context`, observability needs `opentelemetry`.
