<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush — deployments & per-command tracking

Command class: `\Drupal\new_relic_rpm\Commands\NewRelicRpmCommands`
(registered via `drush.services.yml`).

## `new-relic-rpm:deploy` (alias `nrd`)

Creates a New Relic **deployment marker** through REST API v2.

```bash
drush new-relic-rpm:deploy 1.2.3
drush nrd 1.2.3 --description="Release 1.2.3" --user="ci" --changelog="Fixed X, added Y"
```

- Argument: `revision` (required) — the revision label shown on the New Relic timeline.
- Options: `--description`, `--user`, `--changelog` (all optional).
- Under the hood calls `NewRelicApiClient::createDeployment($revision, $description, $user, $changelog)`,
  which POSTs to `/applications/{appId}/deployments`. The app id is resolved from the
  `newrelic.appname` PHP ini value via `listApplications()`.
- **Requires** a valid `api_key` in `new_relic_rpm.settings` **and** a resolvable app name;
  if the app id cannot be found, `createDeployment()` returns FALSE and the command logs
  `New Relic deployment failed.` (Without the `newrelic` extension there is no app name, so
  deployments cannot be created even though the command exists.)

## `pre-command` hook (automatic)

`NewRelicRpmCommands::preCommandNewrelicTransactionType()` runs before **every** Drush
command (`@hook pre-command *`). It reads `track_drush` and, when it is `bg` or `ignore`,
calls `adapter->setTransactionState()` so the Drush run is backgrounded or ignored in APM.
No action is taken for `norm`.

## Related non-Drush deployment triggers

- Installing/uninstalling a module → `new_relic_rpm_module_deploy()` calls
  `createDeployment('module_change', …)` when `module_deployment` is TRUE.
- Config import → deployment marker when `config_import` is TRUE.
