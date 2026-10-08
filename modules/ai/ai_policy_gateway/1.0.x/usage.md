<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Policy Gateway inserts a governance layer in front of Drupal AI calls, evaluating policy profiles and rules to allow, redact, reroute, budget-block or hold-for-approval a request before the prompt leaves the site.
---
It subscribes to drupal/ai (and optionally ai_agents) events and runs each request through a `PolicyEngine`/`PolicyEvaluator`: `AiPolicyRule`s are matched by `PolicyRuleMatcher` and mapped to an `AiPolicyProfile` that sets provider/model routing, a `PrivacyScanner`/`InputRedactor` pass (PII), residency and risk resolution (pluggable via attribute plugins), and a `BudgetManager` cost ceiling. Decisions (`PolicyDecision`) are audit-logged (`AuditLogger`) and can require a human approval gate; high-risk requests create approval requests reviewers act on.

Admins configure profiles and rules as config entities under `/admin/config/ai/policy-gateway`; bundled profiles (public, internal, local_only, high_risk, regulated) and example rules ship in config. A read-only decisions report (`view ai_policy_gateway reports`) and an approvals queue with approve/reject forms (`approve ai_policy_gateway actions`, restricted) complete the surface. Pluggable managers exist for risk resolvers, residency resolvers, privacy inspectors, model-metadata providers and ecosystem integrations. No AI credentials are held here — it governs calls made through the drupal/ai layer.
---
- Enforce an organisation AI-use policy before prompts are sent.
- Match requests to policy rules by operation, tag or context.
- Assign requests to a policy profile (public, internal, regulated…).
- Route a request to a specific provider/model per policy.
- Redact PII from prompt input before it leaves the site.
- Scan inputs for privacy-sensitive content.
- Resolve data-residency requirements for a request.
- Score and gate high-risk AI actions.
- Enforce per-profile spend budgets with a budget manager.
- Block a request that would exceed its budget.
- Require human approval for high-risk requests.
- Approve or reject queued AI requests as a reviewer.
- Audit every policy decision for compliance.
- View a read-only report of policy decisions.
- Ship with ready-made profiles and example rules.
- Add a custom risk resolver plugin.
- Add a custom residency resolver plugin.
- Add a custom privacy inspector plugin.
- Provide model metadata via a metadata-provider plugin.
- Integrate with ai_agents, ai_logging or ai_decision_log.
- Restrict approvals and administration to trusted roles.
- Keep governance independent of provider credentials.