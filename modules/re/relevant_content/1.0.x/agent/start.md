<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Relevant Content — agent orientation

- Config entity `RelevantContentPreset` (`administer relevant content` admin permission); forms
  and list builder under `src/`. Each preset stores node_types, vocabularies, max_results.
- Block plugin `RelevantContentBlock` (deriver per preset) with `node` context. `build()` calls
  `RelevantContentService::getNodeTerms()` then `findRelevantContent()`.
- `RelevantContentService` (service `relevant_content`): queries `taxonomy_index` for the node's
  tids (dispatches `TermAlter` event), then queries `node_field_data`+`taxonomy_index` for
  published nodes of allowed types sharing terms, grouped/ordered by match count.
- Permission file is mis-named `relevant_contnt.permissions.yml`; `administer relevant content`
  has `restrict access: false`.

Security review (sound): DB queries use parameterized `condition(..., 'IN')`; only published
nodes returned; admin config gated by admin permission. Note info.yml key typo `dependenciess`
means declared deps are ignored by Drupal, but modules are core.
