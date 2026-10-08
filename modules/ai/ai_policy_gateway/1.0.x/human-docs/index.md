# AI Policy Gateway — manual setup guide

**AI Policy Gateway** (`ai_policy_gateway`) is a governance layer that sits in
front of the AI calls your site makes. Before a prompt actually leaves Drupal, it
runs the request through a policy check and decides what to do: allow it, redact
personal information out of it, reroute it to a different provider or model, block
it because it would blow a budget, or hold it for a human to approve. Every
decision is audit-logged, so you have a record of how each AI request was
handled.

It works by listening to events from the core **AI** module (and optionally the
AI Agents module). Each request is matched against **rules** and mapped to a
**policy profile**, which sets the provider/model routing, the privacy/redaction
posture, data-residency and risk handling, and a spend ceiling. Ready-made
profiles ship with the module — `public`, `internal`, `local_only`, `high_risk`,
and `regulated` — along with example rules, so you have a working starting point.
High-risk requests can create approval requests that reviewers act on from a
queue.

Importantly, it holds **no AI provider credentials** of its own — it governs the
calls made through the AI module rather than making them. It is extensible through
plugins for risk resolvers, residency resolvers, privacy inspectors, model
metadata, and integrations with logging/observability modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI dependency.
2. [Configuration](configuration/index.md) — profiles, rules, the approvals
   queue, and the decisions report.

## Where it lives in the admin menu

- **Settings, profiles, and rules:** **Configuration → AI → Policy Gateway**
  (`/admin/config/ai/policy-gateway`), gated by **Administer AI Policy Gateway**.
- **Approvals queue:** under the same section (`/approvals`), gated by the
  restricted **Approve AI Policy Gateway actions** permission.
- **Decisions report:** under the same section (`/report`), gated by **View AI
  Policy Gateway reports**.

## How to use it

Review the bundled profiles and rules, adjust them (or add your own) to match
your organisation's AI-use policy, and decide which requests need redaction,
budget limits, or human approval. As AI requests flow through, watch the
decisions report to see how policy was applied and work the approvals queue for
anything held for review.
