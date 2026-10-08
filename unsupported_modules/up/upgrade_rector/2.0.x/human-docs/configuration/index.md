# Configuration

Upgrade Rector has no settings form — its "configuration" is the run report
itself. Everything happens on one page, and all of it requires core's
**Administer software updates** permission (restrict this to trusted
administrators).

## Open the report

1. Log in as a user with the **Administer software updates** permission.
2. Go to **Reports → Upgrade Rector**, or navigate directly to
   `/admin/reports/upgrade-rector`.

## Pick a project and run Rector

The form lists your installed projects in two collapsible sections:

- **Custom projects** — your site's own modules, themes, and profiles.
- **Contributed projects** — the contrib extensions you have installed.

Each section has a **Select project** dropdown and a **Run rector** button.
Choose the extension you want to analyze and click **Run rector**. Rector runs
synchronously (in the same request — there is no background queue), so on a large
codebase it can take a while, and the page reloads with the formatted result.

Under the hood the module runs `vendor/bin/rector process <extension> --dry-run`.
The `--dry-run` flag means Rector **reports** the changes it would make but never
modifies your files.

## Reading the results

After a run, the module shows the suggested changes as a reviewable diff. Each
project ends up in one of a few states:

- **Patch available** — Rector found deprecations it can rewrite; the diff shows
  the proposed changes.
- **Nothing to patch** — Rector ran cleanly and found nothing to change.
- **Patch error** — the run failed (for example the Rector binary could not be
  found, or a file failed to parse). The most common cause is that the Rector
  binary is not reachable from the webroot — reinstall the module's Composer
  dependencies so `vendor/bin/rector` exists.

## Export a patch

For any project with suggestions, you can download the result as a `.patch` file
(named `<project>-upgrade-rector.patch`). This is handy for feeding the starting
point into a code review or CI workflow. Remember it is a *starting* patch — a
developer still needs to refine and test it.

## Upgrade Status integration

If the **Upgrade Status** module is installed, Upgrade Rector adds a per‑project
link into its deprecation report (**Patch available** / **Nothing to patch** /
**Patch error**) that jumps straight to the corresponding Rector result. Both
modules read the same stored results, so you can drive your whole upgrade review
from the Upgrade Status page.

## Important caveats

- Output is **advisory**. Upgrade Rector never patches your code, and it does not
  replace running your tests.
- Runs are synchronous within the request — large codebases can be slow.
- The Rector binary must be installed in your site's `vendor/` (a Composer
  dependency of the module). If it is missing, runs fail with a logged error
  rather than doing anything to your code.
