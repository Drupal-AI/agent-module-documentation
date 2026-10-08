Database SSL Check adds diagnostic entries to Drupal's Status Report page showing whether the site's connection to its database is encrypted with SSL/TLS, which cipher and TLS version are in use, and the database client library version.

---

Frontend HTTPS is universal, but the backend link between Drupal and its database is often left unencrypted. Database SSL Check answers that question without any configuration: on module install it hooks into Drupal's runtime requirements (`hook_requirements`) and, on every visit to `/admin/reports/status`, opens a fresh PDO connection using the site's existing database connection options, reads the PDO client-library version, inspects the PDO connection status, and — for TCP/IP connections — runs `SHOW STATUS LIKE 'Ssl%'` to report the negotiated SSL version and cipher. It surfaces two rows on the Status Report: "Database client version" and "Database connection status". When a TCP connection is found to carry no `Ssl_version`/`Ssl_cipher`, the connection status is flagged as "unencrypted" at warning severity; UNIX-socket connections are reported as-is (local, not over the network). The module ships no configuration UI, no routes, no permissions, and no services — it is a read-only reporting shim aimed at MySQL/MariaDB deployments. Because the readouts appear only on the admin Status Report page, they are visible solely to users who can view site reports.

---

- Verify at a glance whether Drupal's database connection is encrypted in transit.
- See the exact TLS version and cipher negotiated with a MySQL/MariaDB server.
- Confirm an intended SSL/TLS configuration actually took effect after editing `settings.php` database options.
- Detect a silent fallback to an unencrypted database connection (warning severity on the Status Report).
- Audit remote/managed database services (e.g. RDS, Cloud SQL) that require or offer TLS.
- Document the database client library version for support or compatibility troubleshooting.
- Provide evidence of encrypted DB transport for security/compliance reviews (PCI, HIPAA, SOC 2).
- Distinguish a UNIX-socket (local) database connection from a networked TCP/IP one.
- Include DB SSL status in routine site health checks alongside other Status Report items.
- Catch a database endpoint that lost TLS after an infrastructure or credential change.
- Validate that a `pdo` `MYSQL_ATTR_SSL_*` option set in `settings.php` produced an encrypted session.
- Spot-check staging/production parity for database transport encryption.
- Give ops teams a no-config way to monitor DB encryption after a module or core update.
- Confirm client-library capability (version) when planning to require TLS on the database.
- Surface DB SSL posture to Drush/monitoring tooling that scrapes the Status Report (`drush core:requirements`).
- Raise awareness with site owners who assumed frontend HTTPS covered the whole stack.
- Support decommissioning of unencrypted DB links by making them visibly flagged.
- Onboard a newly inherited site by quickly reading its actual DB transport security.
- Sanity-check a containerized/DDEV or hosted stack where the DB host is remote.
- Keep an ongoing, zero-maintenance indicator of database encryption on every Status Report load.
