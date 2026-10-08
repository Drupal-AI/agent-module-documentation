<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Module usage lets teams document how, why, and where each installed module is used — attaching rich-text descriptions, notes, and reference URLs per module — and reports on module version-change activity.
---
The module stores its data in custom tables (`module_usage`, `module_usage_activity`, `module_usage_urls`, `module_usage_notes`) accessed through `QueryService` with parameterised queries. Editors add/edit/delete URLs and notes and edit descriptions through AJAX modal forms (permissions `edit module_usage`, `delete module_usage`); reports at `/admin/reports/module-usage/...` and per-module views require `view module_usage`. An import form (`/admin/module_usage/import`) accepts a JSON/TXT upload and merges it into the four tables, and an export route streams the data back out as `module_usage.json`; matching Drush commands `moduse:export` and `moduse:import` do the same from a private-scheme file. A Views field plugin renders the description text, and an install hook seeds records for currently enabled modules while tracking version changes over time.

Security posture: all routes are permission-gated (no anonymous or `access content` exposure) and SQL is parameterised. Typical setup: enable the module (pulls in jquery_ui_accordion), grant the four `*module_usage` permissions appropriately, then document modules from the modules list or reports.
---
- Document why each contrib/custom module is installed on the site.
- Attach a rich-text description to a module and track when it was last updated.
- Add reference URLs (issue queues, docs, tickets) per module.
- Add free-form notes with titles to a module.
- Edit or delete existing URLs and notes via modal forms.
- View a per-module documentation page with activity, notes, and URLs.
- Browse a module-usage report at `/admin/reports/module-usage/usage-docs`.
- Review a "recent module updates" report of version changes.
- Track install and version-change events automatically via activity records.
- Export all module-usage documentation as JSON.
- Import module-usage documentation from a JSON/TXT file.
- Migrate documentation between environments with `drush moduse:export`/`moduse:import`.
- Restrict who can view vs. edit vs. delete documentation via distinct permissions.
- Render the description field inside a View using the provided field plugin.
- Seed initial records for all enabled modules on install.
- Keep an audit trail of when modules changed version.
- Standardise onboarding by capturing tribal knowledge about modules.
- Filter exports to a specific list of modules.
- Store exports under a private:// path for safekeeping.
- Surface documentation links from the core Extend (modules) page.