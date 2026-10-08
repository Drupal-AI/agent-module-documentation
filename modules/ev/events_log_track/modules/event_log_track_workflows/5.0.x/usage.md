Enables content-moderation workflow tracking for Events Log Track: when a node or group with a `moderation_state` field changes state (e.g. Draft → Published), the transition appears in the audit report with type `workflows`.

---

`EventLogTrackWorkflowsHooks` registers the `workflows` handler and implements `node_insert`/`node_update` and `group_insert`/`group_update`, guarded by `hasField('moderation_state')`. Insert records the initial workflow state of a newly created entity; update records only genuine state transitions by comparing the original and current `moderation_state`. The description names the entity and the old→new state; `ref_numeric` is the entity id and `ref_char` its title/label. Entries write through the parent `event_log_track.manager` service. Deletions are not tracked here (use the node/group submodules). Filtering, retention, and the `access event log track` permission are inherited from the parent.

---

- Audit content-moderation state transitions (Draft → Review → Published).
- See who moved a node from one workflow state to another.
- Record the initial state of newly created moderated content.
- Track workflow transitions on moderated Group entities.
- Filter the audit report to only `workflows` events.
- Reconstruct the moderation timeline of a single node.
- Detect content published without going through review.
- Investigate who archived or unpublished content via workflow.
- Correlate state changes with the acting editor and IP.
- Demonstrate editorial-workflow compliance.
- Prune old workflow records via cron retention.
- Exclude specific titles using skip patterns.
- Export a report of moderation activity over a period.
- Combine with node tracking for a full content history.
- Identify rapid back-and-forth state changes on an item.
