<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Provenance records and displays how much AI contributed to a piece of content — by which model and provider — per entity, revision, and field, and renders a machine-readable and human-visible transparency badge.
---
The EU AI Act's text-transparency obligations (effective August 2026) require AI-generated content to be labelled; beyond compliance, disclosing AI involvement is becoming an editorial-trust baseline. Existing Drupal.org tooling (`c2pa_sign`) covers media/image signing only — nothing addresses node/field-level editorial text disclosure. This module fills that gap, complementing `ai_decision_log` (which records why/what was decided). Provenance is expressed as a disclosure gradient: `generated`, `ai_assisted`, `human_reviewed`, `human_written`. Data is stored in a dedicated `ai_provenance_record` content entity rather than base fields on tracked entities, giving one queryable store with per-revision and per-field granularity and independent access control across heterogeneous content types (nodes, media, custom entities).

Configuration at `/admin/config/ai/provenance` (restricted `administer ai provenance`) chooses which entity types are tracked and manages records; the records collection at `/admin/reports/ai-provenance` is also admin-gated, while a separate `view ai provenance` permission governs viewing recorded provenance and disclosure badges on the front end. No provider is called and no keys are stored; there are no anonymous mutating endpoints.
---
- Label AI-generated content to meet EU AI Act text-transparency rules.
- Record per-entity how much AI contributed to content.
- Store provenance per revision, not just per entity.
- Track AI contribution at the individual field level.
- Capture which model and provider produced content.
- Render a human-visible transparency badge on the front end.
- Emit machine-readable provenance for downstream consumers.
- Use the disclosure gradient (generated / ai_assisted / human_reviewed / human_written).
- Choose which entity types are tracked for provenance.
- Keep provenance in a dedicated record entity, not base fields.
- Query one store across nodes, media, and custom entities.
- Manage provenance records from the admin reports collection.
- Grant front-end badge viewing via the `view ai provenance` permission.
- Complement `ai_decision_log` (why decided) with what-was-AI-produced.
- Optionally leave human-written content unlabelled unless opted in.
- Provide auditors/regulators evidence of AI-content disclosure.
- Avoid polluting tracked entity schemas with disclosure fields.
- Apply independent access control to provenance vs content.
- Build editorial trust by disclosing AI involvement.
