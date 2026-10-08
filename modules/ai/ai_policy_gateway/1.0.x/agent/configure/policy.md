<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI Policy Gateway

Admin route `/admin/config/ai/policy-gateway` (`administer ai_policy_gateway`).

**Profiles** (`ai_policy_profile` config entity) — the policy applied once a request matches. Controls provider/model routing, privacy/redaction posture, residency, risk threshold, budget ceiling and whether approval is required. Bundled: `public`, `internal`, `local_only`, `high_risk`, `regulated`.

**Rules** (`ai_policy_rule` config entity) — matched by `PolicyRuleMatcher` against the request context (operation type, tags, caller) and mapped to a profile. Bundled examples: `public_alt_text`, `internal_embeddings`, `agent_tools_high_risk`.

**Evaluation** (`PolicyEngine` → `PolicyEvaluator`, driven by `AiCoreEventSubscriber` / `AiAgentsEventSubscriber` on drupal/ai events):
1. Match a rule → resolve profile.
2. `PrivacyScanner` + `InputRedactor` inspect/redact input (PII).
3. `ResidencyResolver` and `RiskResolver` (pluggable) classify the request.
4. `PolicyRouter` selects provider/model; `BudgetManager` checks spend.
5. Emit a `PolicyDecision` (allow / redact / reroute / block / require-approval); `AuditLogger` records it.

**Approvals:** require-approval decisions create requests in the approvals queue `/admin/config/ai/policy-gateway/approvals` (`approve ai_policy_gateway actions`). Reviewers approve/reject via `AiPolicyApprovalDecisionForm`.

**Reports:** `/admin/config/ai/policy-gateway/report` (`view ai_policy_gateway reports`) is a read-only decision audit.

**Extending:** implement attribute plugins — `#[RiskResolver]`, `#[ResidencyResolver]`, `#[PrivacyInspector]`, `#[AiPolicyModelMetadataProvider]`, `#[AiPolicyEcosystemIntegration]` — to plug in custom logic and integrate ai_logging / ai_decision_log / ai_observability.
