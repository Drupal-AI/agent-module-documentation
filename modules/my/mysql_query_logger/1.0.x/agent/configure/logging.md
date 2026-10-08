<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling MySQL Query Logger

There is no UI. Activate by wiring the driver into a database connection in `settings.php`, e.g. a dedicated connection or by overriding the default connection's `namespace`/`driver` to `Drupal\mysql_query_logger\Driver\Database\mysql_query_logger`.

- Log path: set the connection option `output` to a writable file; default is `/tmp/mysql_query_logger.txt`.
- Logged per call: `[timestamp] ACTION (duration s): <json of query/args/options>` for insert/update/delete/merge/upsert/truncate/query/select and transaction start/commit.
- **Caution:** the log captures full query text and bound arguments — this can include password hashes, session ids, secrets and private field data. Use only in development, keep the file out of web-accessible paths, and remove the driver before production.
