# Configuration

## Open the admin section

1. Log in as a user with the **Administer AI Policy Gateway** permission.
2. Go to **Configuration → AI → Policy Gateway**
   (`/admin/config/ai/policy-gateway`).

The module governs AI requests through two kinds of configuration entity —
**profiles** and **rules** — plus an approvals queue and a decisions report.

## Profiles — what happens once a request matches

A **policy profile** (`ai_policy_profile`) is the policy applied to a request. It
controls:

- **Provider/model routing** — which provider and model the request should use.
- **Privacy / redaction posture** — whether input is scanned and PII redacted
  before the prompt leaves the site.
- **Residency** — data-residency requirements to enforce.
- **Risk threshold** — how much risk is tolerated before the request is gated.
- **Budget ceiling** — a spend limit; requests that would exceed it are blocked.
- **Approval** — whether a matching request must be held for human approval.

Five profiles ship ready to use: **public**, **internal**, **local_only**,
**high_risk**, and **regulated**. Edit these or add your own.

## Rules — deciding which profile applies

A **rule** (`ai_policy_rule`) is matched against a request's context — the
operation type, tags, and caller — and maps it to a profile. Bundled examples
include `public_alt_text`, `internal_embeddings`, and `agent_tools_high_risk`.
Adjust the matching so each kind of AI request lands on the right profile.

## How a request is evaluated

When the AI module fires a request, the gateway:

1. Matches a rule and resolves its profile.
2. Scans and redacts the input for personal information.
3. Classifies the request for residency and risk.
4. Selects the provider/model and checks the budget.
5. Emits a decision — **allow**, **redact**, **reroute**, **block**, or
   **require approval** — and records it in the audit log.

## Approvals queue

Requests that need sign-off appear at **…/policy-gateway/approvals**, gated by the
restricted **Approve AI Policy Gateway actions** permission. Reviewers approve or
reject each one from that queue.

## Decisions report

**…/policy-gateway/report** (gated by **View AI Policy Gateway reports**) is a
read-only audit of every policy decision — useful for compliance and for tuning
your rules and profiles.

## Extending

Developers can plug in custom logic with attribute plugins — risk resolvers,
residency resolvers, privacy inspectors, model-metadata providers, and ecosystem
integrations — to connect the gateway to modules such as AI Logging, AI Decision
Log, or AI Observability.
