<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy Guardrail (ai_empathy_guardrail) — submodule

Provides one **AiGuardrail plugin** for the `ai` module's guardrails system that blocks AI output whose
empathy score is below a configured threshold. Depends on `ai_empathy` + `ai`. No routes, no config
object (plugin config is per-guardrail-instance, stored by the `ai` module). No permissions.

- Plugin `EmpathyScoreGuardrail` (id **`empathy_score_check`**, label "Empathy Score Check"), in
  `src/Plugin/AiGuardrail/EmpathyScoreGuardrail.php`. Implements `ConfigurableInterface`,
  `PluginFormInterface`, `NonDeterministicGuardrailInterface`, `NonStreamableGuardrailInterface`.
- One setting `empathy_threshold` (default 3.0, validated 1.0–5.0 in `validateConfigurationForm()`).
- `processInput()` always passes (checks output only). `processOutput()` runs only on `ChatOutput`,
  scores the normalized text with `ai_empathy.scoring::scoreResponseGeneral()`, and returns
  `StopResult` when `empathy_alignment < threshold`, else `PassResult` — both carry the scores in
  metadata.
- **Fails closed**: if scoring throws, `processOutput()` returns `StopResult` (blocks), not a pass. There
  is no attacker-controlled input to the guardrail; the threshold is admin config.

Enable, then add the "Empathy Score Check" guardrail to a provider/operation in the `ai` module's
guardrail configuration.
