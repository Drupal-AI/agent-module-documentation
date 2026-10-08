Enables taxonomy tracking for Events Log Track: vocabulary and term create/update/delete operations appear in the audit report with type `taxonomy` and a distinct operation label for each (e.g. `vocabulary insert`, `term delete`).

---

`EventLogTrackTaxonomyHooks` registers the `taxonomy` handler with six operations and implements the vocabulary and term entity hooks. Vocabulary hooks record the vocabulary label and machine name (`ref_char` = vid); term hooks record the term name and id (`ref_numeric` = tid, `ref_char` = the term's vocabulary id). Each entry is written through the parent `event_log_track.manager` service. Filtering by type/operation, retention, and the `access event log track` permission are inherited from the parent.

---

- Audit creation of new vocabularies and their machine names.
- Track edits to vocabulary labels and settings.
- See who deleted a vocabulary.
- Record term creation across all vocabularies.
- Track term renames and moves (update events).
- Detect term deletions and who performed them.
- Filter the report to only taxonomy events.
- Distinguish vocabulary-level from term-level operations by operation label.
- Trace a term's history by its id (`ref_numeric`).
- Group term events by their vocabulary (`ref_char`).
- Demonstrate governance over site taxonomy structure.
- Prune old taxonomy-change records via cron retention.
- Exclude specific vocabularies from logging with skip patterns.
- Export a report of all term changes for a vocabulary.
- Correlate taxonomy changes with the acting user and IP.
