<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optimize Database Tables provides a way to optimize database tables, reclaiming space and defragmenting tables.

---

Optimize Database Tables lets administrators optimize the site's database tables — running the database's
table-optimization (e.g. MySQL `OPTIMIZE TABLE`) to defragment tables and reclaim space after large
deletes/updates. It is configured at `optimize_database_tables.settings`, provides Drush commands and its own
permissions, in the Performance package.

Use it for periodic database maintenance. It is a performance/admin operation that runs
optimization directly against the database, so restrict its permission to trusted administrators (it locks/
rebuilds tables during optimization, which can briefly affect availability on large tables) and prefer
running it during low-traffic windows (or via the Drush command in a maintenance job). It has no
content-access role beyond its permission. Configure which tables to optimize and schedule.

---

- Optimize database tables.
- Run OPTIMIZE TABLE from Drupal.
- Defragment tables and reclaim space.
- Provide Drush commands.
- Provide its own permissions.
- Restrict to trusted administrators.
- Run during low-traffic windows.
- Be aware optimization locks tables.
- Use for periodic maintenance.
- Configure at the settings form.
- Have no content-access role beyond permission.
- Schedule via Drush.
- Maintain the database.
- Reclaim table space.
- Optimize after large deletes.
- Configure which tables to optimize.
- Run DB maintenance.
- Handle table optimization.
- Restrict the operation.
- Optimize tables.
