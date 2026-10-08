CKEditor Plugin Report adds an admin report at /admin/reports/ckeditor-plugins that lists every CKEditor 5 plugin registered on the site, showing each plugin's ID, provider module, and PHP class.

---

The module is a single read-only report. It defines one route, `ckeditor_plugin_report.plugin_report` (path `/admin/reports/ckeditor-plugins`, linked from the Reports menu under `system.admin_reports`), gated by one permission, **`view ckeditor plugin report`** (marked `restrict access: true`). Its controller (`PluginReportController::content`) injects the CKEditor 5 plugin manager service (`plugin.manager.ckeditor5.plugin`) using `NULL_ON_INVALID_REFERENCE` so the module works even if CKEditor 5 is not installed, then renders a table of every definition returned by `getDefinitions()` with three columns: **Plugin ID**, **Provider**, and **Class**. It has no configuration form, no `configure` route, no config schema, no services or plugins of its own, and no Drush commands. It is chiefly a diagnostic aid — for example when auditing which module supplies a given CKEditor plugin, or when planning a CKEditor 4 → CKEditor 5 upgrade and needing to see the full CKEditor 5 plugin surface. (The project README also mentions CKEditor 4 and CKEditor4To5Upgrade plugin types, but the D10/D11 controller reports the CKEditor 5 plugin manager's definitions.)

---

- See every CKEditor 5 plugin registered on the site in one table.
- Identify which module (provider) supplies a specific CKEditor 5 plugin.
- Find the PHP class backing a CKEditor 5 plugin for debugging or code reading.
- Audit the CKEditor 5 plugin surface before a CKEditor 4 → 5 upgrade.
- Verify that a contrib module's expected CKEditor 5 plugin actually registered.
- Confirm a newly installed editor plugin appears after enabling its module.
- Diagnose a missing toolbar button by checking whether its plugin is present.
- Give a support/QA engineer a quick inventory of editor plugins.
- Cross-reference plugin IDs against a text format's enabled toolbar items.
- Check for duplicate or conflicting plugin providers.
- Document the site's editor capabilities for a technical handover.
- Restrict who can see the plugin inventory via the "view ckeditor plugin report" permission.
- Grant a reviewer role read access to the report without giving broader admin rights.
- Spot plugins provided by premium/commercial CKEditor modules.
- Sanity-check plugin availability after a core minor upgrade.
- Locate the provider of a plugin referenced in an editor config error.
- Use the report page as a linkable reference from the Reports overview.
- Help theme/front-end developers see which editor plugins can add classes/markup.
- Confirm removal of a plugin after uninstalling its module.
- Provide evidence in a bug report about which editor plugins are active.
