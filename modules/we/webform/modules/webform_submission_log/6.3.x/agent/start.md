# webform_submission_log — agent start

Dedicated per-submission event logging (own table + logger channel) with log reports at
site/webform/submission level. Depends only on `webform`. Ships one permission; no
drush/config schema. Enable "Submission logging" on a webform, then see logs under
`/admin/structure/webform/.../results/log`.

- Log reports, storage & manager service → [api/webform_submission_log.md](api/webform_submission_log.md)
- Permission → [permissions/webform_submission_log.md](permissions/webform_submission_log.md)
