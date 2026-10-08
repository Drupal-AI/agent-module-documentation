# Configuration

Site Audit is mostly *run* rather than *configured*. This page covers running it
from Drush and the admin page, the one small settings form, and how the scoring
works.

## Running the audit from Drush

The command line is the most capable way to use Site Audit — it's the only route to
JSON/Markdown output and to save a report to a file.

```bash
drush audit                 # interactive: pick a single report, or "All"
drush audit cache           # run just the cache report (text output)
drush audit-all             # run every report
drush audit-list            # list every available report and check
```

Useful options for `audit` / `audit-all`:

- **`--format=`** — `text` (default, prints to the console), `html`, `json`, or
  `markdown`. Redirect the non-text formats to a file, e.g.
  `drush audit security --format=html --detail > report.html`.
- **`--detail`** — show details even for checks that passed, not just the problems.
- **`--bootstrap`** — wrap the HTML output in Bootstrap-derived styling (this forces
  HTML format).
- **`--skip=`** — a comma-separated list of reports to skip (by report id, e.g.
  `--skip=block,status`) or individual checks to skip (by check id, e.g.
  `--skip=StatusSystem`).

The thirteen shipped reports are: `best_practices`, `block`, `cache`, `codebase`,
`content`, `cron`, `database`, `extensions`, `security`, `status`, `users`,
`views`, and `watchdog`. Run `drush audit-list` to see them all with their checks.

## Running the audit from the admin page

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Reports → Site Audit** (`/admin/reports/site-audit`). The HTML report
   renders inline.

By default the page runs **all** reports. To limit it to a subset, use the settings
form.

## The settings form

1. From the report page, open the **Settings** tab, or navigate to
   `/admin/reports/site-audit/settings`.
2. This is a simple checkboxes form listing every report. Tick the reports you want
   the admin page to run and **Save**.
3. If you leave everything unchecked, the report page runs **all** reports — an
   empty selection means "run everything".

(The setting lives in the `site_audit.settings` config object under the `reports`
key, so you can also read or set it with `drush config:get` / `drush config:set`.)

## Permanently opting out of a check

Instead of passing `--skip` on every run, you can disable a check for good with a
config override in `settings.php`, for example:

```php
$config['site_audit.settings']['reports']['cache'] = TRUE;
```

## How scoring works

Each check returns a score: **PASS = 2, WARN = 1, FAIL = 0, INFO = 3** (INFO is
excluded from the percentage). A report sums its checks' scores against the maximum
and reports a percentage. A check that hits a blocking problem can abort the rest of
that report.

## Core Site module integration (optional)

If Drupal core's **Site** module is present, Site Audit adds a "Required Site Audit
Checklists" option to the site's settings, so the reports you choose must score 100%
for the site to be considered in an OK state.

## Extending Site Audit (for developers)

Other modules can add their own reports and checks by extending
`SiteAuditChecklistBase` / `SiteAuditCheckBase` with the `@SiteAuditChecklist` /
`@SiteAuditCheck` annotations — see the [`agent/`](../agent/start.md) docs for the
plugin details.
