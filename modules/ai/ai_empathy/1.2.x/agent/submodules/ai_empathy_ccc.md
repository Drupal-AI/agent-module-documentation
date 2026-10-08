<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy CCC Integration (ai_empathy_ccc) — submodule

Tone-aware empathy evaluation using the **Context Control Centre** (`ai_context`). Depends on
`ai_empathy` + `ai_context`. No routes or permissions of its own; ships a config entity
`ai_context.scope_settings.request_tag` and config object `ai_empathy_ccc.settings`
(`config/schema/ai_empathy_ccc.schema.yml`).

## Mechanism

- `CccIntegrationSubscriber` (`src/EventSubscriber/`) hooks the empathy events: on `PROMPT_ALTER` it
  injects brand/organisational context resolved from `ai_context.request_factory`; on `SCORE_ALTER` it
  adds a `tone_alignment` score. Failures are logged, not fatal.
- `ToneAlignmentScorer::score($response, $brand_context)` (`src/Service/ToneAlignmentScorer.php`) reuses
  `ai_empathy.settings.scoring_provider_model` via `@ai.provider`, sends a rubric prompt, and
  `parseScore()` extracts JSON and **clamps** `tone_alignment` to 1–5 (default 1.0 on malformed output).
  The `tone_alignment` base field is added to `ai_empathy_result` (surfaced in the settings threshold and
  result view when present).
- Plugin `AiContextScopeRequestTag` (id **`request_tag`**), in
  `src/Plugin/AiContextScope/AiContextScopeRequestTag.php`, an `ai_context` AiContextScope that includes a
  context item when the AI request carries one of an admin-configured list of provider tag strings (e.g.
  `ai_empathy`, `ai_empathy_scenario:5`). Values come from admin config (textarea, one tag per line); no
  ambient page value (`doGetCurrentValue()` returns NULL). Manage route
  `ai_context.settings.scope.request_tag` (owned by `ai_context`).
