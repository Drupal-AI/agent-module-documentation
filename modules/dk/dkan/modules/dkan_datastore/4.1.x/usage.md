<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Turns the tabular resource behind a dataset — usually a CSV — into a database table that can be queried over HTTP through the datastore API.

---

Turns the tabular resource behind a dataset — usually a CSV — into a database table that can be queried over HTTP through the datastore API. Import and drop operations are gated by the granular `datastore_api_import` and `datastore_api_drop` permissions, so an automated importer can be given exactly those verbs and nothing else. A nested `dkan_datastore_mysql_import` submodule provides a faster MySQL-native import path for large files.

---

- Import a CSV into a datastore table.
- Query tabular data over HTTP.
- Drop a datastore table via the API.
- Grant a client import-only access.
- Grant a client drop access separately.
- Use the MySQL fast-import path for large files.
- Expose a dataset's rows as an API.
- Filter datastore rows by query.
- Re-import a resource after it changes.
- Keep import verbs off general roles.
- Serve tabular data to a front end.
- Back a dataset preview with the datastore.
- Handle large CSV imports efficiently.
- Manage datastore tables per resource.
- Restrict datastore mutations to entitled clients.
- Aggregate query results from the datastore.