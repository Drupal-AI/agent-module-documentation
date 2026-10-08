<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_taxonomy — agent index

Submodule of **events_log_track**. Records taxonomy vocabulary and term CUD into the shared
`event_log_track` table. Depends on `event_log_track` + core `taxonomy`.

- Handler (`hook_event_log_track_handlers`): type **`taxonomy`**, title *Taxonomy*, operations
  `vocabulary insert`, `vocabulary update`, `vocabulary delete`, `term insert`,
  `term update`, `term delete` — `EventLogTrackTaxonomyHooks`.
- Vocabulary events via `taxonomy_vocabulary_insert/update/delete`: description `"<label> (<vid>)"`,
  `ref_char` = vocabulary id. Term events via `taxonomy_term_insert/update/delete`:
  description `"<name> (<tid>)"`, `ref_numeric` = term id, `ref_char` = the term's vocabulary
  id (`vid`).

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
