Database Export UI adds a single admin form that runs `mysqldump` and produces a compressed, optionally sanitized `.sql.gz` dump of the site's MySQL/MariaDB database.

---

Database Export UI is a deliberately small module aimed at developers, internal teams and local/development environments that need a one-click way to snapshot the site database without the configuration surface of Backup and Migrate. Enabling it exposes one route — `/admin/config/development/db-export` (permission `administer db exports`) — whose form shells out to `mysqldump` via a `DatabaseExportService`, writes the resulting `.sql` to a per-timestamp file, optionally runs a light email/user sanitization pass, then gzips the result. It offers no restore, no scheduling, no remote destinations and no selective table UI; the shipped sanitization is intentionally basic (an email-address regex replacement and an optional watchdog-strip helper) and is expected to be customized per project. It supports MySQL/MariaDB only and requires the `mysqldump` and `gzip` binaries to be available to the web server user.

---

- Take a quick one-click SQL snapshot of a development site from the Drupal admin UI.
- Generate a `mysqldump` dump without dropping to a shell or writing Drush commands.
- Produce a compressed `.sql.gz` archive ready to hand to a teammate.
- Optionally replace email addresses in the dump before sharing it externally.
- Give an internal QA team a self-service way to grab a fresh database copy.
- Seed a local environment by exporting from a shared dev database.
- Capture a pre-deployment snapshot of a staging database.
- Provide a lightweight export workflow inside a custom distribution or install profile.
- Serve as a small, readable starting point for building project-specific export tooling.
- Export a database on a host where Backup and Migrate is considered too heavyweight.
- Create a throwaway dump for debugging a data-specific bug locally.
- Standardize how developers on a team pull database copies.
- Generate a dump to feed into a migration or data-analysis pipeline.
- Snapshot the database before running a risky content or config change on dev.
- Attach a compressed database export to an issue reproduction on a non-production site.
- Give a developer-friendly UI to trigger `mysqldump` with sensible default flags (`--single-transaction --quick --lock-tables=false`).
- Strip watchdog log rows from a dump via the service's optional helper when building custom flows.
- Export from either a Drupal 10.3+ or Drupal 11 site using the same tool.
- Provide an export button gated behind a dedicated administrator permission.
- Build custom sanitization by extending or wrapping the `DatabaseExportService::export()` method.
