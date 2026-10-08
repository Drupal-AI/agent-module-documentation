<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Dependent Filter (Deprecated) is a hidden legacy-rename shim: the project's original D8 machine name was `views_dependent_filter` (singular), and this stub exists only so sites on the old name can run database updates that uninstall it and switch to the correctly named `views_dependent_filters` (plural).

---

The module is `hidden: true` and deprecated. It ships no working functionality: its only Views plugin is a `Broken` filter registered as `views_dependent_filter_obselete`, which safely marks any leftover handler from the old module so it does not fatal. Its real payload is the update hook `views_dependent_filter_update_8001()`, run by `drush updatedb` / `update.php`: it finds every view whose config depends on the old `views_dependent_filter` module, uninstalls that module, installs `views_dependent_filters`, flushes caches, and re-saves the affected views so their dependencies recalculate to the new module name. New installs should never enable this module — enable `views_dependent_filters` instead. On existing sites it should be removed by running the database updates (or uninstalling it directly).

---

- Migrate a legacy Drupal 8 site from the mis-named `views_dependent_filter` module to `views_dependent_filters` by running database updates.
- Provide a safe `Broken` placeholder (`views_dependent_filter_obselete`) so old view configs don't fatally error before migration.
- Uninstall the deprecated module automatically via `update_8001` while preserving views that used the old dependent filter.
- Recalculate and re-save view dependencies so they point at the new module machine name.
- Recognise this module in `drush pml` as a hidden, deprecated stub that should be removed.
- Confirm that no new configuration should reference `views_dependent_filter` (singular).
- Clean up a site upgraded from the old project name so only `views_dependent_filters` remains enabled.
- Understand why a hidden "(Deprecated)" module appears in the project and that it is intentional, not a bug.
- Serve as the documented uninstall path for the historical rename.
- Avoid enabling it on a fresh install (use the plural `views_dependent_filters` module instead).
- Audit an inherited codebase to detect leftover use of the deprecated module name.
- Ensure `drush updatedb` completes the rename without manual view edits.
- Keep old exported view configs loadable (via the Broken handler) until the update hook migrates them.
- Document, for maintainers, that removing this module is the intended end state.
- Trace the project's history: the singular name was a mistake corrected by the plural module.
