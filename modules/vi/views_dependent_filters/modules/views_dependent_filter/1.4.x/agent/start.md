<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Dependent Filter (Deprecated) — agent index

Hidden, **deprecated** legacy-rename shim. The project's original D8 machine name was
`views_dependent_filter` (singular); the correct module is now `views_dependent_filters`
(plural — see the parent docs). This stub exists only to migrate off the old name.

No configure route, no permissions, no services. It provides:
- A `Broken` Views filter `views_dependent_filter_obselete` (class
  `Drupal\views_dependent_filter\Plugin\views\filter\ViewsDependentFilter extends Broken`) so
  stale configs don't fatal.
- Update hook **`views_dependent_filter_update_8001()`**: run by `drush updatedb`, it uninstalls
  `views_dependent_filter`, installs `views_dependent_filters`, and re-saves any views that
  depended on the old module so their dependencies point at the new name.

**What to do:** never enable this on a new site (use `views_dependent_filters`). On an existing
site, remove it by running database updates (`drush updatedb`) or uninstalling it
(`drush pmu views_dependent_filter -y`). There are no capability docs to link — the parent
module's [plugins/dependent-filter.md](../../../../1.4.x/agent/plugins/dependent-filter.md) covers
the actual feature.
