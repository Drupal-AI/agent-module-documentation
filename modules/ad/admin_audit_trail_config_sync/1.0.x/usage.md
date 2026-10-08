Logs command-line configuration imports (drush config:import / config sync) into the Admin Audit Trail so CLI config changes are captured alongside web-triggered activity.

---

Admin Audit Trail Config Sync is a small add-on to the Admin Audit Trail module. Core's configuration import through the web UI is already logged by Admin Audit Trail, but Admin Audit Trail's own insert path is guarded to run only for web requests, so imports run from the command line (drush config:import, deployment scripts, CI) are never recorded. This module closes that gap: it subscribes to the core ConfigEvents::IMPORT event and, on a successful import, writes an audit-trail row directly to the admin_audit_trail table using its own CLI-safe writer. It also registers a "Config Sync" handler so those rows show up as a distinct, filterable event type in the audit trail overview. Each entry records a summary of the change counts (create/update/delete), the source collection, and — when the import was run over SSH — the SSH user and client IP taken from $_SERVER['SSH_CONNECTION']. There is nothing to configure; enabling the module is enough.

---

- Record every `drush config:import` (or `drush cim`) run in the site's audit trail.
- Capture config sync that happens during automated deployments or CI pipelines.
- Get an audit record for config imports triggered by cron jobs or shell scripts.
- Fill the blind spot where Admin Audit Trail logs UI config changes but not CLI ones.
- See a filterable "Config Sync" event type on the Admin Audit Trail overview page.
- Know how many config items were created, updated, and deleted in each import.
- Track which environment/collection a config import was applied from.
- Attribute a CLI import to the SSH user who ran it (when connected over SSH).
- Record the originating client IP address of an SSH-driven import.
- Maintain a compliance / change-management log that includes command-line config changes.
- Detect unexpected or out-of-process configuration imports on production.
- Correlate config drift with a specific deployment by timestamp in the audit log.
- Provide reviewers a single place to see both UI and CLI configuration activity.
- Confirm that a scheduled config import actually completed successfully.
- Support incident forensics by showing when configuration last changed via CLI.
- Keep an append-only history of config syncs without adding custom code.
- Give operations teams visibility into who is pushing config from the shell.
- Audit multi-developer workflows where config is imported from different machines.
- Reuse Admin Audit Trail's existing overview UI and filters for CLI config events.
- Run entirely passively — no forms, no settings, no scheduled tasks to manage.
