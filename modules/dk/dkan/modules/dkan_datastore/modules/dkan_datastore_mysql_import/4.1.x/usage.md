<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A faster, MySQL-native import path for the datastore, using the database's own bulk-load facilities instead of row-by-row PHP import.

---

A faster, MySQL-native import path for the datastore, using the database's own bulk-load facilities instead of row-by-row PHP import. Enable it when the site runs on MySQL/MariaDB and imports large CSV resources where the default importer is too slow.

---

- Import large CSVs quickly.
- Use MySQL native bulk load.
- Speed up datastore imports.
- Skip row-by-row PHP import.
- Handle multi-million-row resources.
- Enable on MySQL or MariaDB.
- Reduce import time for big files.
- Pair with dkan_datastore.
- Fall back to the default importer elsewhere.
- Bulk-load resource tables.
- Cut import CPU cost.
- Import federal-scale datasets.
- Choose the fast path per environment.
- Keep off on non-MySQL databases.
- Optimise the datastore pipeline.
- Benchmark against the default importer.