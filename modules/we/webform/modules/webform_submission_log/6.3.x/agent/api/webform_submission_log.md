# Submission log storage & reports

## Enable
Per webform: turn on **Submission logging** in the webform's settings. Events then flow into
the `webform_submission_log` table.

## Services
- `logger.webform_submission_log` → `WebformSubmissionLogLogger` — a tagged logger channel
  that writes submission events to the log table.
- `webform_submission_log.manager` → `WebformSubmissionLogManagerInterface`
  (`WebformSubmissionLogManager`, ctor arg `@database`) — query/read log entries for a
  webform, submission, or handler.

Get the manager with `\Drupal::service('webform_submission_log.manager')`.

## Report routes
| Route | Path |
|---|---|
| `entity.webform_submission.collection_log` | `/admin/structure/webform/submissions/log` (site-wide) |
| `entity.webform.results_log` | `/admin/structure/webform/manage/{webform}/results/log` |
| `entity.webform_submission.log` | `/admin/structure/webform/manage/{webform}/submission/{webform_submission}/log` |
| `entity.node.webform.results_log` | `/node/{node}/webform/results/log` |
| `entity.node.webform_submission.log` | `/node/{node}/webform/submission/{webform_submission}/log` |

`Routing/WebformSubmissionLogRouteSubscriber` attaches these to webforms and webform nodes.
Each entry stores operation, handler id, message, user, and timestamp.
