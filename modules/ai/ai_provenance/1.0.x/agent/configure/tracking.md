<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Provenance — configure tracking

1. Enable `ai_provenance` and open **Configuration → AI → AI provenance** (`/admin/config/ai/provenance`, `administer ai provenance`).
2. Choose which entity types are tracked for provenance.
3. Provenance is stored in a dedicated `ai_provenance_record` content entity (not base fields on tracked entities) → one queryable store, per-revision and per-field granularity, independent access control across nodes/media/custom entities.

**Disclosure gradient** (`options`-backed):

| Value | Public disclosure |
|---|---|
| `generated` | AI-generated content |
| `ai_assisted` | Created with AI assistance |
| `human_reviewed` | AI-generated, reviewed by a human |
| `human_written` | Written by a human (not labelled unless opted in) |

Manage records at `/admin/reports/ai-provenance`. Front-end badges (machine-readable + human-visible) are shown to users with `view ai provenance`. Targets EU AI Act text-transparency obligations (Aug 2026); complements `ai_decision_log`.
