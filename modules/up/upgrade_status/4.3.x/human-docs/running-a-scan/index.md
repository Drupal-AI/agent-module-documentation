# Running a scan

Upgrade Status does its work on a single page. This walkthrough takes you from
opening the report to reading the results and exporting them to share.

## 1. Open the report

Go to **Reports → Upgrade status** (`/admin/reports/upgrade-status`). You need the
**administer software updates** permission to see it.

The page opens on the target's readiness dashboard — titled for the next major
version, for example **Drupal 12 upgrade status**. At the top is a summary split
into three columns, and a circular **percentage-ready indicator** showing how many
of your projects are already compatible with the next major core version.

![The Drupal 12 upgrade status report](../images/report.png)

The three summary columns are:

- **Gather data** — links to *Check available updates* (from core's Update module)
  and to *Scan: N projects*. This is where you kick off scanning.
- **Fix incompatibilities** — a triage of what needs attention: whether the
  *Environment is incompatible*, and how many projects you should *Remove*,
  *Update*, or *Collaborate with maintainers* on.
- **Relax** — how many projects are already *compatible with the next major Drupal
  core version*.

## 2. Read the environment section

Below the summary, expand **Drupal core and hosting environment**. This checks your
runtime against the target Drupal version's **system requirements** and shows each
as a row with a **Status**:

- **Drupal core** version — whether your core is new enough to upgrade.
- **PHP version** — whether your PHP meets the minimum the next major requires.
- **Database** engine and version — for example whether your MariaDB/MySQL version
  is high enough, and whether a **deprecated database driver** is still in use.
- **Deprecated or obsolete core extensions** — core modules still enabled that will
  be removed in the next major version.

A green check means the requirement is met; a warning or red cross means it needs
attention before you upgrade. If you run multiple environments (dev, stage, live),
check the same requirements on each — they can differ.

## 3. Scan your projects

Below the environment section, your modules and themes are listed in tables grouped
by recommended action (for example **Remove**, **Update**, **Collaborate**). Each
row is a project with columns such as *Type*, *Status*, *Local version*, *Local
12-ready*, *Local scan result*, and the Drupal.org equivalents.

To analyse the code:

1. In the **Gather data** column, click **Scan: N projects** to scan everything at
   once, or
2. Select the checkbox on individual projects in the list and scan just those.

A batch process runs PHPStan over the selected extensions. This can take a while on
a large codebase, so let it finish. If PHPStan runs out of memory, lower the batch
size with `drush config:set upgrade_status.settings paths_per_scan 15` and scan
again.

## 4. Read the per-project result

Once a scan finishes, each project's **Local scan result** cell summarises what was
found. Broadly, a project is one of:

- **Compatible** — no deprecation errors detected; it is ready for the next major.
- **Needs update / has errors** — deprecated API usage was found. Click into the
  project (its per-project page) to see each finding with the **exact file and
  line**. Findings are grouped by priority — *fix now*, *fix later*, *uncategorized*,
  *ignore*, and (where drupal-rector is available) auto-fixable.
- **Collaborate with maintainers** — a contributed project with no compatible
  release yet, where the fix belongs upstream on Drupal.org rather than in your
  code.

Work through the *fix now* findings first, re-scan after applying fixes, and watch
the percentage-ready indicator climb.

## 5. Export the report

To share the results with stakeholders or paste them into a ticket, use the export
links to save a project's report as **HTML** (for sharing) or **ASCII** (for
tickets and emails).

## Running it from the command line (optional)

Everything above can also be driven headlessly with Drush — useful for CI:

```bash
# Analyse every project and print the results
drush upgrade_status:analyze --all

# Analyse a single project, reusing a prior scan if present
drush upgrade_status:analyze my_module --skip-existing

# Emit Checkstyle-style output to gate a CI pipeline
drush upgrade_status:checkstyle --all --ignore-uninstalled
```

Both commands exit non-zero when errors are found, so you can wire them into a
pipeline to block merges that introduce new deprecations.
