<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Audit Export inventories your Drupal site's structure — content types, entities, blocks, menus, taxonomy, views, users/roles and enabled modules — into stored reports you can view, export to CSV, schedule, or push to a remote endpoint.

---

Install the module with Composer (`composer require drupal/audit_export`) and enable it with `drush en audit_export`; the required **Audit Export Core** submodule is pulled in automatically. Configure it at **`/admin/config/system/audit-export`** (permission *Administer Audit Export settings*), where you set whether exports are saved to the filesystem (`temporary`, `public`, or `private`) and how cron processing is scheduled. Run and read reports at **`/admin/reports/audit-export/reports`**: the overview lists each audit with a **Run audit** action and a **Process all** button, and each report page shows the data as a table with a **Download CSV** button (when filesystem saving is enabled). Audits are plugins (`@AuditExport`), so developers can add custom ones under `src/Plugin/AuditExport/`. From the command line use `drush audit-export:list`, `drush audit-export:run [--all]`, `drush audit-export:export <id>`, and `drush audit-export:queue`. Enable the optional **Audit Export Post** submodule to POST reports to an external URL (with none/basic/bearer auth and TLS verification), and the optional **Audit Export Tool API** submodule (needs `drupal/tool`) to expose audits as Tool API tools for AI agents and MCP clients. Reports are stored in the `audit_export_report` table and can be regenerated any time.

---

- Inventory every content type on a site.
- Audit entity types and their fields.
- List all placed/enabled blocks.
- Report on menus and their links.
- Audit taxonomy vocabularies and terms.
- Inventory Views and their displays.
- List enabled modules with versions.
- Flag modules with pending security updates.
- Build a users-by-roles matrix.
- Export any report as a CSV file.
- Prepare a site handover document.
- Support a compliance or security review.
- Schedule audits to refresh via cron.
- Run audits from the command line in CI/CD.
- Queue large audits for background processing.
- Push audit data to a central monitoring endpoint.
- Track site health across multiple environments.
- Feed audit CSVs into external analytics tools.
- Expose audits to AI agents via Tool API / MCP.
- Let an LLM query stored report data with pagination.
- Write a custom audit plugin for bespoke data.
- Store report snapshots for trend analysis.
- Restrict who can view, run, and export audits.
