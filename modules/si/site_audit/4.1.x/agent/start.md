# Site Audit — agent index

Static site-analysis platform: **checklists** (reports) made of **checks**, run via Drush or the
`/admin/reports/site-audit` page, output as text/HTML/JSON/Markdown. Two plugin types
(`site_audit_check`, `site_audit_checklist`). No `configure` route in info.yml (settings live at
`/admin/reports/site-audit/settings`).

- **Drush commands (`audit`, `audit-all`, `audit-list`), options, formats, skipping** →
  [drush/commands.md](drush/commands.md)
- **The two plugin types and how to add a custom report / check** →
  [plugins/checks-and-checklists.md](plugins/checks-and-checklists.md)
- **The admin page, the `site_audit.settings` config (`reports`), scoring, permissions** →
  [configure/settings.md](configure/settings.md)

Key facts:
- 13 shipped reports (checklist ids): `best_practices`, `block`, `cache`, `codebase`, `content`,
  `cron`, `database`, `extensions`, `security`, `status`, `users`, `views`, `watchdog`.
- `drush site_audit:audit <report>` (alias `audit`), `drush site_audit:all` (aliases `audit-all`,
  `aa`), `drush site_audit:list` (alias `audit-list`).
- Admin page route `site_audit.report` (`admin/reports/site-audit`, permission
  `administer site configuration`); settings route `site_audit.settings`, config `site_audit.settings`
  key `reports` (checkboxes; empty ⇒ run all).
- Submodules: `site_audit_report_entity` (saved report entity), `site_audit_send` (remote/cron send).
