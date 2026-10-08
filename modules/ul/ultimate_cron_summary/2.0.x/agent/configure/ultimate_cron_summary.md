<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Ultimate Cron Summary

The only setting is which job **statuses to hide** from the summary dashboard. There is no dedicated route: the
module injects an **Exclude** checkboxes field into Ultimate Cron's general settings form, and `configure` in
`info.yml` points at that form (`ultimate_cron.settings`).

## Admin UI

Administration > Configuration > Cron > Cron settings (route `ultimate_cron.settings`). In the **Exclude** field,
check any statuses that should NOT appear in the dashboard, then save. Contextual links let you jump from the
dashboard to this form and back.

## Config object

`ultimate_cron_summary.settings` (config schema provided; default shipped in `config/install`):

```yaml
exclude: []   # sequence of status name strings; [] = show every status
```

Empty (`[]`) means nothing is excluded. Only names from the allowed set are valid (enforced by a Choice constraint
on `\Drupal\ultimate_cron_summary\Status::names`).

### Allowed status names (lowercase)

`disabled`, `error`, `missing`, `notice`, `running`, `success`, `unfinished`, `warning`

(These are the cases of the `Status` enum; each maps to a status-tile icon.)

## Set via Drush

`exclude` is a sequence, so set it by index or with a YAML value:

```bash
# hide the "success" and "running" tiles
drush config:set ultimate_cron_summary.settings exclude.0 success -y
drush config:set ultimate_cron_summary.settings exclude.1 running -y

# read current value
drush config:get ultimate_cron_summary.settings exclude
```

Invalid names are silently dropped at render time (the list builder intersects the saved values with the valid
status names before filtering).
