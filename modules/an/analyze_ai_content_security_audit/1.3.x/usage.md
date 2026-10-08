<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze AI Content Security Audit is a submodule of Analyze that sends rendered content to a configured AI provider and stores a 0–100 risk score per "security vector" (e.g. PII disclosure, credential disclosure).
---
Editors can inadvertently publish sensitive data — personal information, API keys, passwords — inside node bodies and fields. This module plugs an AI analyzer (`AIContentSecurityAuditAnalyzer`, an Analyze plugin implementing `BatchableAnalyzerInterface`) into the Analyze framework: it renders an entity, strips markup, builds a prompt describing each enabled security vector, asks the site's default chat AI provider (temperature 0.2) for integer risk scores, clamps them to 0–100, and displays them as gauges in the entity's Analyze report. Results are cached in the custom `analyze_ai_content_security_audit_results` table keyed by entity, revision, language, a SHA-256 content hash and an MD5 config hash, so re-analysis only happens when content or vector configuration changes; a Views view (`ai_content_security_audit_results`) lists results with color-scaled gauges.

Security vectors are configurable through three admin forms — a settings/list form, an add-vector form and a delete-vector form — all under `/admin/config/analyze/content-security-audit` and all gated by the Analyze permission **`administer analyze settings`**. Two default vectors (`pii_disclosure`, `credentials_disclosure`) are seeded on install; each has a label, description and weight, and their detection criteria are embedded in the analyzer prompt. Storage uses parameterized `merge`/`select`/`delete` queries throughout. Note the module sends rendered content to an external AI provider, so it should only be enabled where sending content off-site is acceptable, and per-content-type enablement is controlled from the Analyze settings (`/admin/config/content/analyze-settings`).
---
- Score nodes for potential PII disclosure before publishing.
- Detect exposed API keys or passwords in content with an AI vector.
- Add a custom organization-specific security vector with its own risk weight.
- Edit an existing vector's label, description or weight.
- Delete a vector and purge all of its stored analysis results.
- Enable the analyzer per content type via Analyze settings.
- View a per-entity gauge of the highest security risk score.
- See individual gauges for each enabled vector in the full report.
- Batch-analyze existing content across a bundle.
- Sort and filter audited content in the Views results dashboard.
- Re-run analysis automatically when a node's content changes (hash-based cache).
- Invalidate cached scores after changing vector configuration.
- Restrict who can manage vectors via `administer analyze settings`.
- Configure the AI provider/model used for scoring at `/admin/config/ai/providers`.
- Review statistics (counts, oldest/newest analysis) from the storage service.
- Identify the content type + language with the highest average risk.
- Force-refresh a single entity's scores, discarding cached results.
- Use color-scaled gauges to triage high-risk content quickly.
- Confirm no scores are generated when no chat provider is configured.
- Audit multilingual content, scoring each translation separately.
- Clean up all results on uninstall.
