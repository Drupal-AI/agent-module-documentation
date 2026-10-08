<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Provenance (ai_provenance) — agent index

**Records and displays editorial AI-disclosure / content provenance (how much AI contributed, by which model) per entity, revision, and field, with a transparency badge.**

- **Version:** 1.0.x  •  **Core:** ^10.3 || ^11 || ^12  •  **Package:** AI  •  **Depends on:** `system`, `user`, `options`
- **Configure:** `/admin/config/ai/provenance` (`administer ai provenance`, restricted).
- **Records:** `/admin/reports/ai-provenance` (`administer ai provenance`); front-end viewing via `view ai provenance`.
- **Entity:** `ai_provenance_record` content entity (per entity/revision/field). Disclosure gradient: `generated`, `ai_assisted`, `human_reviewed`, `human_written`.
- **Security:** Admin routes restricted; front-end badge viewing behind `view ai provenance`; no provider calls, no stored keys, no anonymous mutating endpoints. Aimed at EU AI Act (Aug 2026) compliance. No security findings.

See [configure/tracking.md](configure/tracking.md).
