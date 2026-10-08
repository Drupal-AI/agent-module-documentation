# Admin page, settings & scoring

## Admin page

- `site_audit.report` — `admin/reports/site-audit`, permission **`administer site configuration`**.
  Renders the HTML report inline. If the settings form has selected a subset of reports it runs only
  those, otherwise it runs **all** reports.
- `site_audit.settings` — `admin/reports/site-audit/settings`, same permission. A checkboxes form
  (`SiteAuditConfigForm`) listing every checklist.

info.yml has **no `configure` key**; reach settings via the *Settings* local task on the report page.

## Config: `site_audit.settings`

```yaml
# site_audit.settings
reports:
  cache: cache        # checked report ids map to their id (truthy)
  security: security
  block: 0            # unchecked = 0
  # ...one entry per checklist
```

- Key `reports` is a checkboxes value: an enabled report has a truthy value (its id), a disabled one
  is `0`.
- **Empty / nothing selected ⇒ the admin page runs all reports.** The controller treats an all-zero
  or empty `reports` as "run everything".
- `drush config:get site_audit.settings reports` reads it; set with `drush config:set` or via the form.

There is also an `opt_out.<checklistId><checkId>` convention read by checklists to permanently skip a
single check (see the `--skip` / settings.php opt-out in `drush/commands.md`).

## Scoring

Each check returns a score constant: PASS=2, WARN=1, FAIL=0, INFO=3 (INFO is excluded from the
percentage). A checklist sums check scores over the max and reports a percentage; a check that
`shouldAbort()` stops the remaining checks in that report.

## Core Site module integration

If the core `site` module is present, `site_audit_form_site_entity_settings_alter()` adds a "Required
Site Audit Checklists" option so chosen reports must pass 100% for the site to be in an OK state
(stored in `site.settings` `site_audit_required`).
