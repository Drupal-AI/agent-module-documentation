<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MySQL Query Logger (mysql_query_logger) — agent index

**Logs every database query, mutation and transaction to a plaintext file via a custom MySQL driver.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Dependency:** drupal:mysql
- **Activation:** set the DB connection `driver`/namespace to `Drupal\mysql_query_logger\Driver\Database\mysql_query_logger` in settings.php; optional `output` key sets the log path (default `/tmp/mysql_query_logger.txt`).
- **Routes/permissions:** none — no HTTP surface, no UI, no config entity.
- **Key class:** `src/Driver/Database/mysql_query_logger/Connection.php` (`logQueryLine()` opens the file with `fopen(...,'a')`, `flock`, `fwrite`).

**Security:** No route exposes the log, but it captures full query text + bound arguments (potential secrets/hashes/session data) into a predictable default path `/tmp/mysql_query_logger.txt` with default permissions. Development-only; do not enable in production.

See [configure/logging.md](configure/logging.md)
