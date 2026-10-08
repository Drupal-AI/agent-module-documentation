<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MySQL Query Logger is a development-only database driver that logs all database activity to a text file.

---

It ships a `Connection` class extending the core MySQL driver (`src/Driver/Database/mysql_query_logger/Connection.php`) and overrides `insert()`, `update()`, `delete()`, `merge()`, `upsert()`, `truncate()`, `query()`, `select()`, `startTransaction()` and `commitAll()`. Each override times the parent call with `microtime()` and appends a line — timestamp, action, duration and a JSON-encoded dump of the query text plus its arguments/options — to a log file. You activate it by pointing your database connection in `settings.php` at this driver (namespace `Drupal\mysql_query_logger\Driver\Database\mysql_query_logger`) and optionally setting an `output` key for the log path; the default is `/tmp/mysql_query_logger.txt`.

Operationally this is a debugging aid for spotting slow or unexpected queries during development, not a production tool. Because it serializes the full query and its bound parameters, the log can contain sensitive values that pass through the database layer (password hashes, session identifiers, private field data, API secrets stored in config). There is no route, permission or UI — the module exposes nothing over HTTP — but the plaintext file is written with default permissions to a predictable, often world-readable path, so treat the log as sensitive and remove the driver before deploying.

---
- Enable low-level logging of every SQL statement to a file
- Diagnose which queries run on a given page request
- Measure per-query execution time to find slow queries
- Capture insert/update/delete activity for a debugging session
- Log transaction start/commit boundaries
- Point the log at a custom path via the connection `output` option
- Inspect the exact arguments bound to a prepared statement
- Trace the order of queries during a complex operation
- Audit which tables a module touches during install
- Reproduce and study an N+1 query problem
- Compare query counts before and after a code change
- Feed the log into a script for query-frequency analysis
- Confirm a cache layer is actually preventing DB hits
- Debug a migration by watching its write pattern
- Verify a hook is (or is not) issuing extra queries
- Keep a query trail while stepping through a request in a debugger
- Disable by switching the connection back to the standard mysql driver
- Rotate or delete the log file between test runs
