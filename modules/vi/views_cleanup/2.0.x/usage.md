<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Offers a set of helper services (and a Drush command) for bulk-editing Views configuration in code — removing, replacing or adding filters, fields and module dependencies across many views at once.

---
Maintaining large Views config becomes painful when a field is renamed, a module removed, or a filter must change site-wide. Views Cleanup exposes method services — `views_cleanup.filter_cleanup`, `filter_replacement`, `filter_add`, `aggregate_views_filter_option`, `dependencies` (module dependency cleanup) and `fields_cleanup` — each operating over a supplied list of view ids (or all views when none is given). You call them from update hooks or custom code, e.g. `\Drupal::service('views_cleanup.filter_cleanup')->cleanupViewsFiltersByFilterCheckOptions($options, $view_ids)`. A Drush command (`ViewsCleanupCommands`) wraps the same operations for the CLI.

There is no HTTP surface: the module ships only services, a Drush command and a base class — no routes, permissions or forms — so it is a developer/deployment tool with no anonymous or mutating web endpoint. Because the methods rewrite Views config directly, run them in a controlled deployment context (update hook or CLI) and export the resulting config. Setup is simply enabling the module and invoking the services where needed.
---
- Remove matching filters from selected views.
- Remove matching filters from all views at once.
- Replace a filter across multiple views.
- Add a filter to a set of views programmatically.
- Adjust aggregate view filter options in bulk.
- Clean up stale module dependencies on views.
- Remove orphaned fields from views.
- Run cleanup from a custom update hook.
- Run cleanup from the Drush CLI.
- Fix views after renaming an entity field.
- Repair views after uninstalling a module.
- Standardise a filter operator across a site's views.
- Target specific view ids or default to all views.
- Script bulk Views config edits in a deployment.
- Reduce manual Views UI edits during migrations.
