Configuration Log records every configuration change on a Drupal site (create, update, rename, delete, and config import) to one or more destinations, with a per-value diff and automatic redaction of likely secrets.

---

The module subscribes to core's configuration CRUD events (`ConfigEvents::SAVE`, `DELETE`, `RENAME`, `IMPORT`) and fans each change out to three independent destinations you can toggle on the settings form: a custom database table (`config_log`), the default logging system (watchdog/dblog via the PSR logger), and email notifications. Each database record stores the operation, the acting user, the config object name, and the full YAML of both the new and original data, so a diff can be reconstructed later. A single global settings object, `config_log.settings`, controls which destinations are active, an ignore list of config names (glob `*` wildcards, optionally negated to a keep-only list), whether config imports are logged, whether no-op saves are skipped, how many rows to retain, and how many context lines a diff shows. By default it redacts likely sensitive leaf values (passwords, secrets, tokens, API keys, client secrets, SMTP passwords) before writing them, redacting only the matching leaf, not the whole object. A `hook_cron` implementation trims the `config_log` table to the configured row limit in batches. There is no plugin system; extension happens by adding your own event subscriber. The optional **Config Log Views** submodule exposes the `config_log` table to Views with a custom diff field and ships a ready-made report at `/admin/reports/config-log`.

---

- Keep an audit trail of who changed which configuration and when on a production site.
- Diff a configuration object between two points in time using the stored original vs new YAML.
- Email a site owner whenever any configuration changes, with the diff in the body.
- Send configuration changes to watchdog/dblog so they appear in *Reports → Recent log messages*.
- Store config changes in a dedicated `config_log` database table for later reporting.
- Redact passwords, API keys, and tokens automatically so secrets never land in the log.
- Ignore noisy config objects (e.g. `core.*`, `system.*`) by adding glob patterns to the ignore list.
- Invert the ignore list to log **only** a specific whitelist of config names.
- Stop logging changes that happen during a configuration import (deployments) to avoid noise.
- Skip logging saves that did not actually change any value (`ignore_no_changes`).
- Cap the log table to the last N rows (100 → 1,000,000) and let cron prune older entries.
- Show a few unchanged leading/trailing context lines around each diff for readability.
- Detect an unexpected/unauthorized config change during incident response.
- Review the sequence of config operations after a botched deployment.
- Customize the notification email subject and body with `@site`, `@id`, `@config_name`, `@time`, `@changes` placeholders.
- Track content-type, view, or field-storage config edits made through the admin UI.
- Build a compliance report of configuration activity via the Views submodule.
- Provide a `/admin/reports/config-log` screen with an inline From/To diff for editors and admins.
- Add a custom destination (e.g. Slack, syslog) by writing your own `EventSubscriber` on the same config events.
- Reconstruct the pre-change state of a config object to roll back manually.
- Confirm a config import actually applied the expected changes by reading the logged changelist.
- Monitor for changes to a single critical config object by negating the ignore list to just that name.
- Keep configuration history without committing exported config to git.
- Alert on changes to security-relevant settings (e.g. `user.settings`, `system.site`).
