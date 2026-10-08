<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy Governance (ai_empathy_governance) — submodule

Extends evaluation with **Accountability** and **Trust** metrics, forming the Trust · Accountability ·
Empathy triad. Depends on `ai_empathy` + `ai`. Config object `ai_empathy_governance.settings`
(`accountability_threshold`, `trust_threshold`, both float, default 3.0).

## Routes (`ai_empathy_governance.routing.yml`)

- `ai_empathy_governance.settings` — `/admin/config/ai/empathy/governance/settings`, `administer ai empathy`.
- `ai_empathy_governance.triad` — `/admin/config/ai/empathy/governance`, `view ai empathy results`.

## Mechanism

- `AiEmpathyGovernanceHooks::entityBaseFieldInfo()` adds float base fields `accountability` and `trust`
  to `ai_empathy_result` (so they disappear cleanly on uninstall).
- `GovernanceScoreSubscriber` (`src/EventSubscriber/`) listens on `AiEmpathyEvents::SCORE_ALTER` and
  calls `GovernanceScorer::score()` (`src/Service/GovernanceScorer.php`) for every evaluation, adding the
  two scores via `$event->setScore()`. Scoring failures are caught and logged (evaluation continues).
- `GovernanceScorer` reuses `ai_empathy.settings.scoring_provider_model` through `@ai.provider`
  (`ChatInput`, rubric system prompt), then `parseScores()` extracts JSON and **clamps** each to 1–5
  (defaults to 1.0 on malformed output). No direct HTTP/keys.
- `GovernanceTriadController::overview()` renders a Chart.js triad + a table of the averaged
  empathy/accountability/trust scores vs thresholds. `averageMetric()` uses `AVG(r.$field)` where
  `$field` is a **hardcoded literal** column name ('empathy_alignment'/'accountability'/'trust'), value
  conditions bound — no dynamic SQL. Library `ai_empathy_governance/triad`.
