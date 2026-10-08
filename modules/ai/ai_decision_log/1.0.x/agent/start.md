<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ai Decision Log (ai_decision_log) — agent index

**Stores persistent ADR-style decisions (what/why/alternatives/relations) for human and AI-assisted changes as an `ai_decision` content entity.**

- **Version:** 1.0.x  •  **Core:** ^10.3 || ^11 || ^12  •  **PHP:** ^8.3  •  **Package:** AI
- **Routes:** `/admin/reports/ai-decisions` (settings, `administer ai_decision_log`), `/report` and `/list` (`view ai_decision_log reports`).
- **Service:** `ai_decision_log.writer` (`DecisionLogWriter`) — creates decisions; redacts secret-like values via `SECRET_PATTERN` before storage.
- **Permissions:** administer (restricted), view reports, use, run audits, approve generated changes (restricted).
- **Security:** All routes permission-gated under `/admin/reports`; no anonymous endpoints; writer redacts api-key/token/password patterns from stored text. No paid provider required. No security findings.

See [api/writer.md](api/writer.md).
