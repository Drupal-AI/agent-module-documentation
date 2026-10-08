<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Policy Gateway (ai_policy_gateway) — agent index

**Event-driven governance for drupal/ai: policy profiles + rules enforce routing, privacy redaction, residency, risk, budgets and approval gates before a prompt is sent.**

- **Version:** 1.0.x (1.0.2)  •  **Core:** ^10.3 || ^11 || ^12  •  **Package:** AI
- **Depends on:** ai, system, user, datetime (optional: ai_model_registry, ai_agents, ai_observability, ai_logging, ai_decision_log)
- **Config entities:** `ai_policy_profile`, `ai_policy_rule`.  **Subscribers:** AiCore / AiAgents / Ecosystem event subscribers.
- **Routes:** settings `/admin/config/ai/policy-gateway` (`administer ai_policy_gateway`); report `/report` (`view ai_policy_gateway reports`); approvals `/approvals` + approve/reject (`approve ai_policy_gateway actions`).
- **Permissions:** `administer ai_policy_gateway` (restricted), `view ai_policy_gateway reports`, `approve ai_policy_gateway actions` (restricted).
- **Plugin managers:** risk resolver, residency resolver, privacy inspector, model-metadata provider, ecosystem integration.

**Security:** all routes permission-gated; approve/reject gated by the restricted `approve ai_policy_gateway actions` permission with numeric `{approval}` constraints. The module reduces AI risk (redaction/budgets/approvals) and holds no provider credentials. See [configure/policy.md](configure/policy.md).
