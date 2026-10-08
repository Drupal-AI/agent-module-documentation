<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a context contributor that walks a Paragraph entity's parent chain at audit time so a paragraph mutation is traceable to its host entity even after the paragraph is deleted.

---

`audit_trail_entity_paragraphs` registers the `audit_trail_entity_paragraphs_ancestry` context contributor. When an audited event's subject is a Paragraph, it walks `parent_type` / `parent_id` / `parent_field_name` pointers iteratively to the first non-Paragraph ancestor (the real host entity) or a configurable depth cap (default 32), guarding against cyclic pointers. It emits into the row's permanent bucket (structural metadata, no PII) `paragraphs.root` — the namespaced host resource id (e.g. `entity:node/4711`) — and `paragraphs.path`, the ordered list of intermediate `{type, field, id}` steps, so an investigator can answer "what changed on the contract document at node 4711" rather than "what changed on paragraph 92831". Enable it on a chain by adding the contributor to that chain's contributors list. Requires `audit_trail`, `audit_trail_entity`, and the contrib `paragraphs` module.

---

- Trace a paragraph field edit back to the node/host it belongs to.
- Keep the host-entity reference even after the paragraph itself is deleted.
- Record the full nested-paragraph path for paragraph-on-paragraph structures.
- Filter the entries list for every paragraph row sharing a host entity by resource substring.
- Tighten the ancestry-walk depth cap per chain for pathologically nested layouts.
- Surface a `paragraphs.cycle_detected` marker so operators can find and fix corrupt parent pointers.
- Add host context to a paragraphs-heavy content model's audit rows for forensics.
- Combine with `audit_trail_entity` so paragraph create/update/delete rows carry ancestry.
- Store the ancestry in the permanent (never-purged) tier since it is PII-free structural data.
- Reconstruct which host field a paragraph hung off at the time of the change.
