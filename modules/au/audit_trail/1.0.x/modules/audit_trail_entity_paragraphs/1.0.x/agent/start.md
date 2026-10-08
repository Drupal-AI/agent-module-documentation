<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Trail Paragraph ancestry (audit_trail_entity_paragraphs) — agent index

Submodule of [audit_trail](../../../../agent/start.md). Core `^11.3 || ^12`. Depends on `audit_trail`, `audit_trail_entity`, `paragraphs`.

## What it does
Registers one context contributor: `ParagraphAncestryContributor` (`src/Plugin/ContextContributor/ParagraphAncestryContributor.php`, plugin id `audit_trail_entity_paragraphs_ancestry`, weight 10). `applies()` when `$subject->live` is a `ParagraphInterface`. `contribute()` walks `parent_type` / `parent_id` / `parent_field_name` iteratively to the first non-Paragraph ancestor (the host entity) or the `depth_cap` (default 32), with a visited-set cycle guard.

## Emits (into `context_permanent`, PII-free structural metadata)
- `paragraphs.root` — namespaced host resource id, e.g. `entity:node/4711` (or the terminal walked step / the paragraph itself for orphans).
- `paragraphs.path` — ordered list of `{type, field, id}` intermediate steps.
- `paragraphs.depth_cap_hit` / `paragraphs.cycle_detected` — set when the walk terminates early.

## Configuration
Instance setting `depth_cap` (1–256, default 32) exposed on the chain's contributor config form (`buildConfigurationForm` / validate 1–256). No module config object, no routes, no permissions. Enable by adding the contributor to a chain's `contributors[]` (e.g. the `audit_trail_entity` chain) so paragraph create/update/delete rows carry ancestry. Contributor plugin mechanics: see the parent [plugins doc](../../../../agent/plugins/contributors-and-filters.md).
