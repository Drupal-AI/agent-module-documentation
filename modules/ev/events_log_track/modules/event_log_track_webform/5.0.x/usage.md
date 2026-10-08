Enables webform-submission tracking for Events Log Track: submission create/update/delete, viewing, results downloads, and results clears all appear in the audit report with type `webform_submission`.

---

`EventLogTrackWebformHooks` registers the `webform_submission` handler and implements the submission entity hooks plus `hook_entity_view` (logging a `view` when a submission is rendered); each records the webform id, submission id, and owner uid, storing the SID in `ref_numeric` and the webform id in `ref_char`. Separately, `WebformSubmissionActionLoggerSubscriber` listens on the controller event and matches Webform's results-export routes to emit a `download` event and the results-clear/purge routes to emit a `clear` event. All entries write through the parent `event_log_track.manager` service, inheriting filtering, retention, and the `access event log track` permission — giving a compliance-grade trail over personal data collected via forms.

---

- Audit every webform submission created, edited, or deleted.
- Log when a staff member views an individual submission.
- Record who exported/downloaded a webform's results.
- Track when a webform's submissions were cleared or purged.
- Filter the audit report to only `webform_submission` events.
- Distinguish the six operations (insert/update/delete/view/download/clear).
- Trace a submission's history by its SID (`ref_numeric`).
- Group all events for one webform by its id (`ref_char`).
- Demonstrate GDPR/PII handling compliance for form data.
- Detect bulk export of sensitive submission data.
- Investigate who cleared submissions before an audit.
- Correlate submission access with the acting user and IP.
- Prune old submission records via cron retention.
- Exclude specific webforms using skip patterns.
- Export a report of submission-data access over a period.
