<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unused Modules lists the modules and projects present in your codebase that are fully disabled and therefore safe to uninstall/delete, via an admin report and a Drush command.

---

This is a development/maintenance helper. It scans all modules on disk (via `ExtensionDiscovery`), drops core modules, groups each module into its **project** (from the `.info.yml` `project` key, the Composer package name, or a `custom` grouping), and works out for each project whether it currently has any **enabled** modules. A **module** is "unused" when it is disabled; a **project** is "unused / safe to delete" only when **none** of its modules are enabled (e.g. `admin_menu` is deletable only if both `admin_menu` and `admin_menu_toolbar` are disabled). It exposes this two ways: an admin report under **Configuration → Development → Unused Modules** (`/admin/config/development/unused_modules/...`), with tabs for Projects vs Modules and "Fully disabled" vs "Also enabled", all gated by the core `administer modules` permission; and a Drush command **`drush unused:modules [projects|modules] [disabled|all]`** (aliases `um`, `unused-modules`) that returns a table with columns project/module/enabled/has_modules/path. It also ships Site Audit integration (a checklist + check plugin). It defines a service `unused_modules.helper` (`getModulesByProject()`) but no permissions, config schema, or config entities of its own; nothing is changed on the site — it only reports. The report is intentionally a heavy page load.

---

- List every contrib project on disk whose modules are all disabled, so you can delete them.
- Find disabled modules cluttering the codebase after a site cleanup.
- Run `drush unused:modules projects disabled` in CI to flag deletable projects.
- Audit which submodules are enabled before removing a multi-module project.
- Confirm a project is safe to delete because none of its modules are enabled.
- Produce a maintenance report of orphaned modules for a codebase review.
- Keep the repository lean by removing modules no longer in use.
- Speed up a site by pruning unused code from the modules directory.
- Distinguish "project deletable" from "module disabled" (project needs ALL modules off).
- Generate a shortlist of modules to uninstall as part of a Drupal upgrade.
- Include unused-module detection in a Site Audit run.
- Export the unused-modules table as JSON/CSV via Drush `--format` for tooling.
- Check both fully-disabled and also-enabled views to understand a project's state.
- Review the project path of each unused module before deleting its directory.
- Hand a developer a list of safe-to-delete projects after a feature removal.
- Verify no enabled module still depends on a project before removal.
- Detect leftover modules from an abandoned experiment.
- Use the `unused_modules.helper` service in custom code to enumerate module/project state.
- Document which modules are candidates for removal in release notes.
- Periodically scan a long-lived site for accumulated dead modules.
- Combine with composer to remove the corresponding packages after uninstalling.
- Avoid accidentally deleting a project that still has an enabled submodule.
- Give site owners a clear "safe to delete" list without reading the module list by hand.
