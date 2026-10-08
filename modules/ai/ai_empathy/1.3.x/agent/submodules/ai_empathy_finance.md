<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy Finance Scenario Pack (ai_empathy_finance) — submodule

A **config-only** scenario pack of financial-services ethical dilemmas. Depends on `ai_empathy`. No PHP,
no routes, no permissions, no services, no config object — just scenario config entities.

- Ships 3 `ai_empathy_scenario` config entities in `config/install/`:
  `finance_robo_advice`, `finance_loan_denial`, `finance_hardship_collections`.
- Once enabled, these scenarios appear in the standard scenario collection and can be evaluated,
  benchmarked and scored by the base module exactly like the built-in scenarios. Nothing else is added.
