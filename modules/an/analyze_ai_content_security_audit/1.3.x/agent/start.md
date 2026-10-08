<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze AI Content Security Audit (analyze_ai_content_security_audit) — agent index

**Analyze plugin that AI-scores content entities (0–100) for PII / credential disclosure risk and caches results in a custom table.**

- **Version:** 1.3.x
- **Core:** ^10.2 || ^11
- **Dependencies:** `analyze` (>=1.3.0), `views_color_scales` (>=1.1.0), `ai`
- **Routes (all `_permission: 'administer analyze settings'`):**
  - `analyze_ai_content_security_audit.settings` → `/admin/config/analyze/content-security-audit`
  - `…vector.add` → `/…/vector/add`
  - `…vector.delete` → `/…/vector/{vector_id}/delete`
- **Plugin:** `AIContentSecurityAuditAnalyzer` (Analyze, `BatchableAnalyzerInterface`) — renders entity, prompts default chat AI provider, clamps scores 0–100.
- **Service:** `analyze_ai_content_security_audit.storage` (`SecurityVectorStorageService`) — parameterized reads/writes to table `analyze_ai_content_security_audit_results`.
- **Config:** `analyze_ai_content_security_audit.settings` (`vectors.<id>.{label,description,weight}`); defaults `pii_disclosure`, `credentials_disclosure` seeded on install. View: `ai_content_security_audit_results`.

**Security:** all three admin routes gated by `administer analyze settings`; no anonymous or mutating public endpoints; SQL is fully parameterized (`merge`/`select`/`delete`, bound `:type` join). Operational caveat: it transmits rendered content to the configured external AI provider. See [configure/security-vectors.md](configure/security-vectors.md).
