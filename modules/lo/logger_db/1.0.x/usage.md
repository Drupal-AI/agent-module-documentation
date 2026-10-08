<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logger DB provides a database storage backend with UI in the Drupal admin panel for the Logger and Monolog modules.

---

Logger DB provides a database storage backend with an admin UI for the Logger and Monolog modules — so
log entries produced through those logging frameworks are stored in the database and browsable in the Drupal
admin, giving a queryable log store. It is configured at `logger_db.settings`, in the Logging package.

Use it to store Logger/Monolog logs in the database with a UI. It is a developer/logging feature. As with any
logging store: be mindful that log entries can contain sensitive detail (avoid logging secrets/PII), the
stored logs grow over time (rotation/retention), and access to the log UI should be gated to trusted admins
(logs can reveal internal detail). It has no access-control role. Configure the log storage.

---

- Store Logger/Monolog logs in the DB.
- Provide an admin log UI.
- Give a queryable log store.
- Configure at logger_db.settings.
- Browse logs in the admin.
- Store framework logs.
- Avoid logging secrets/PII.
- Handle log growth (rotation/retention).
- Gate the log UI to trusted admins.
- Have no access-control role.
- Configure log storage.
- Handle DB logging.
- Store logs.
- Configure the backend.
- Browse logs.
- Handle the log store.
- Store framework logs.
- Configure logging.
- Restrict log access.
- Store log entries.
