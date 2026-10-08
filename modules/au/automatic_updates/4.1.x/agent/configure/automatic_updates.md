# Configure updates, cron & readiness checks

Automatic Updates has **no settings form of its own** — `configure` points at core's
`update.settings` (Admin → Reports → Available updates → Settings), which this module
**alters** (`automatic_updates_form_update_settings_alter`) to add the unattended-update
options below.

## Config object — `automatic_updates.settings`

Edit via the altered settings form or `drush cset automatic_updates.settings <key> <value>`.
Install defaults:

| Key | Default | Meaning |
|---|---|---|
| `unattended.level` | `disable` | `disable`, `security` (security releases only), or `patch` (all patch releases) |
| `unattended.method` | `web` | `web` (Automated Cron / `/system/cron`) or `console` (the `auto-update` CLI) |
| `cron_port` | *(unset)* | Port for the update finalization sub-request |
| `allow_core_minor_updates` | `false` | Allow minor-level Drupal core updates (not just patch) |
| `status_check_mail` | `errors_only` | Whether cron-time readiness-check failures are emailed |

Schema: `config/schema/automatic_updates.schema.yml`. `unattended.level` constants live on
`CronUpdateRunner`: `DISABLED = 'disable'`, `SECURITY = 'security'`, `ALL = 'patch'`.

## Push-button ("attended") updates

Update from the **Available updates** report at `/admin/reports/updates/update`
(route `automatic_updates.update_form`, controller `UpdateController::dashboard`). The flow:
stage the change → confirm on the **Ready to update** page
(`/admin/automatic-update-ready/{stage_id}`, form `UpdateReady`) → finalize
(`/automatic-update/finish`). All routes require the core `administer software updates`
permission. `automatic_updates_preprocess_update_project_status` injects an "Update now" link
into the standard core update report for supported target versions.

## Unattended (cron) updates

`CronUpdateRunner` **decorates core's `cron` service**. After normal cron tasks run, if
`unattended.level` is not `disable` it launches the update as a **detached background
process** (via `CommandExecutor` running the `auto-update` command) so it outlives the web
request. With `unattended.method: console`, run the `auto-update` binary from the command
line / a system scheduler instead. The site is briefly put into maintenance mode during
finalization.

## Readiness / status checks

`StatusChecker` (service `Drupal\automatic_updates\Validation\StatusChecker`, results cached
24h) runs the same Package Manager validators outside of an update to surface problems early.
Results appear on the site **Status report** (`StatusCheckRequirements`) and as admin
messages (`AdminStatusCheckMessages`); failures can be emailed during cron via
`StatusCheckMailer` (`status_check_mail`). Force a run by visiting
`/admin/automatic_updates/status` (route `automatic_updates.status_check`,
`StatusCheckController::run`).

## The Package Manager stage

Updates run through a sandbox that extends `package_manager`'s `SandboxManagerBase`:
`UpdateSandboxManager` (attended, type `automatic_updates:attended`),
`ConsoleUpdateSandboxManager` (unattended console), and `ExtensionUpdateSandboxManager`. The
sandbox is a temporary copy of the site; only the project-level `composer.json` constraint for
`drupal/core` (or `drupal/core-recommended`) is changed there, then committed back live.

## Permissions

None defined by this module. Everything is gated by core's **`administer software updates`**
(defined by the `update`/system core). There is no `automatic_updates.permissions.yml`.
