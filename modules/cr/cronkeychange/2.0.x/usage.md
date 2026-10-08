Cron Key Change adds a "Generate new key" button (and a Drush command) that regenerates Drupal's cron key — the secret embedded in the `/cron/{key}` URL used to trigger cron externally.

---

Drupal stores a per-site cron key in state under `system.cron_key`; it is baked into the external cron URL (`/cron/<key>`) so remote schedulers can run cron without authentication. Core has no UI to rotate that key, so if it leaks (log files, shared URLs, backups) the only way to change it is via code. This tiny utility module fills that gap: it alters the core Cron settings form (`system.cron_settings`, at `/admin/config/system/cron`) to add a "Change cron key" fieldset that displays the current key and a **Generate new key** button. Clicking it calls `cronkeychange_generate_new_key()`, which sets `system.cron_key` to a fresh `Crypt::randomBytesBase64(55)` value, shows a status message, and logs a notice. The same function is exposed as the Drush command `drush cronkeychange`, which prints and generates a new key for CLI/automation use. There is no configuration, no permission of its own, and no config schema — the form lives behind core's `administer site configuration` permission.

---

- Rotate the cron key after you suspect it was disclosed (leaked in a log, chat, or screenshot).
- Regenerate the cron key on a schedule as a routine security hygiene practice.
- Change the cron key immediately after copying a database from production to a shared/staging environment.
- Invalidate an old `/cron/<key>` URL that was shared with a third-party monitoring service.
- Generate a new cron key from the command line during a deployment via `drush cronkeychange`.
- Script cron-key rotation in CI/CD by calling the Drush command.
- View the site's current cron key from the admin UI without querying state manually.
- Reset the cron key after an offboarded contractor had access to the external cron URL.
- Break external cron triggering deliberately by rotating the key (old URL stops working).
- Rotate the key across a multi-site fleet by looping the Drush command over sites.
- Confirm a new key took effect by re-reading the "Current cron key" display on the cron form.
- Regenerate the key after restoring an old backup that may contain a stale/known key.
- Add cron-key rotation to an incident-response runbook.
- Replace a weak or manually-set cron key with a cryptographically strong random one.
- Rotate the key when moving external cron from one scheduler host to another.
