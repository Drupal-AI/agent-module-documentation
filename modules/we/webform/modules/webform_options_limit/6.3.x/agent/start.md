# webform_options_limit — agent start

Adds an **Options limit** WebformHandler that enforces per-option (and total) submission
quotas on select/checkboxes/radios. Depends only on `webform`. Ships config schema; no
permissions/drush. Summary report at
`/admin/structure/webform/manage/{webform}/results/options-limit`.

- Attach & configure the Options limit handler → [configure/webform_options_limit.md](configure/webform_options_limit.md)
