# webform_submission_log permission

Defined in `webform_submission_log.permissions.yml`.

| Permission | Gates |
|---|---|
| `access webform submission log` | Viewing **all** submission log events, provided the user can already access the webform's results. |

There is a single permission; it layers on top of core Webform's results-access checks
rather than replacing them.
