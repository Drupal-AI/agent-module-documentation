<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ai Decision Log records persistent, ADR-style decisions — what was decided, why, the alternatives considered, and what it relates to — for both human and AI-assisted changes.
---
The reasoning behind a change often disappears once the change ships. This module stores it in an `ai_decision` content entity (title, summary, context, decision, alternatives, related, source, author), with related entity/config/module references kept as structured text. Code can create entries through the `ai_decision_log.writer` service; the module also ships an admin report, a decisions list builder, and a settings form. It is a ready integration point for AI Policy Gateway, which mirrors every policy decision here for audit. It is standalone with no hard dependency on any sibling AI module and needs no paid provider.

Access is permission-gated: `administer ai_decision_log` (restricted) for settings, `view ai_decision_log reports` for the report and entity list, plus `use`, `run audits`, and the restricted `approve ai_decision_log generated changes` for review-first workflows. The `DecisionLogWriter` service defines a `SECRET_PATTERN` regex that redacts api-key/token/password-like values from stored decision text — a deliberate measure to avoid persisting secrets in the log. All routes are under `/admin/reports/ai-decisions` and permission-gated; there are no anonymous or unauthenticated endpoints.
---
- Record an ADR-style decision with context, rationale, and alternatives.
- Persist why an AI-assisted change was made, not just what changed.
- Create decisions from code via the `ai_decision_log.writer` service.
- Link a decision to related entities, config, or modules.
- Review decisions in the admin report at `/admin/reports/ai-decisions/report`.
- Browse all decisions via the entity list builder.
- Mirror AI Policy Gateway policy decisions into one audit store.
- Capture the source and author of each decision.
- Keep a durable governance trail for editorial choices.
- Redact secrets from decision text automatically before storage.
- Gate report access with `view ai_decision_log reports`.
- Restrict settings to admins via a restricted permission.
- Support review-first approval of AI-generated changes.
- Run audit operations under the `run ai_decision_log audits` permission.
- Provide auditors a queryable record of decisions over time.
- Use as a standalone decision store without any AI provider.
- Document trade-offs so future maintainers understand a choice.
- Track technical debt decisions alongside editorial ones.
- Export decisions as part of site governance reporting.
