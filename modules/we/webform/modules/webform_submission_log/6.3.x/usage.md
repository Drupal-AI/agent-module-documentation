Webform Submission Log records per-submission events (created, updated, drafts, handler actions, notes) in a dedicated log table and surfaces them through log reports at the webform, submission, and site levels.

---

Webform can optionally log submission events, but this module gives that logging a dedicated storage, logger channel, and reporting UI. It registers a `logger.webform_submission_log` service (`WebformSubmissionLogLogger`) that captures events into a `webform_submission_log` table, managed via the `webform_submission_log.manager` service. Once a webform has "Submission logging" enabled, admins get log tabs: a site-wide log at `/admin/structure/webform/submissions/log`, a per-webform log at `/admin/structure/webform/manage/{webform}/results/log`, and a per-submission log at the submission's `log` tab (plus node equivalents). Each entry records the operation, handler, message, user, and timestamp, giving an audit trail of what happened to a submission and which handlers fired. A single permission — `access webform submission log` — gates viewing the log for users who can already access a webform's results. Route subscribers add the log routes onto webforms and webform nodes. It is useful for auditing, debugging handler behavior, and demonstrating compliance/traceability.

---

- Keep an audit trail of every submission's lifecycle events.
- See when a submission was created, updated, or converted from a draft.
- Track which handlers fired for a given submission (emails, remote posts).
- Review a site-wide feed of all submission events in one place.
- View the log for a single webform's submissions.
- Inspect the event history of an individual submission.
- Debug why an email or handler did/didn't run.
- Provide compliance/traceability for regulated forms.
- Record custom notes/events against submissions from handlers.
- Grant reviewers read access to logs via one permission.
- Investigate user-reported issues by replaying submission history.
- Monitor draft-save and resume activity.
- Audit edits made to submissions after the fact.
- Correlate submission events with the acting user and timestamp.
- Surface handler errors captured as log messages.
- View logs for webform-node forms as well as standalone webforms.
- Support helpdesk workflows by showing what happened to a submission.
- Demonstrate an approval/processing chain via logged operations.
- Feed submission events into broader audit reporting.
- Detect anomalous or repeated submission activity from the log.
