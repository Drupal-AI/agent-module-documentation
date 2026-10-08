<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A developer/administration UI that runs [drupal-rector](https://www.drupal.org/project/rector) against your installed custom and contrib projects and shows the suggested deprecation-fix patches, as a head start for a Drupal major-version upgrade.

---

Upgrade Rector wraps the `palantirnet/drupal-rector` Composer library behind an admin form at `/admin/reports/upgrade-rector`. It collects the site's installed modules, themes, and profiles (via `ProjectCollector`, split into "custom" and "contrib"), lets you pick one, and on submit shells out to `vendor/bin/rector process <extension-path> --dry-run` (`RectorProcessor::runRector()` uses PHP `exec()`) with a generated config derived from `rector-config-template.php`. Raw rector output is stored per extension in the `upgrade_status_rector_results` key/value collection; a controller reformats it into a reviewable diff (`RectorResultController::resultPage`) or a downloadable `.patch` file (`resultExport`). It also weaves its results into the Upgrade Status module's report via `hook_form_drupal_upgrade_status_form_alter()`. Everything is gated behind core's `administer software updates` permission (restrict access), and the module requires the rector binary to be installed alongside the webroot's `vendor/`. It generates *suggestions* only — it never writes patches back to your code, and it does not replace manual testing.

---

- See automated deprecation-fix suggestions for a custom module before a Drupal 10/11 upgrade.
- Run rector against a specific contrib module to gauge upgrade effort.
- Generate a downloadable `.patch` file of rector's proposed changes for a project.
- Review a rector diff inline in the admin UI without leaving Drupal.
- Jump-start Drupal 9/10/11 readiness alongside the Upgrade Status module.
- Identify which installed projects have "nothing to patch" vs. "patch available".
- Surface rector run errors (e.g., missing binary, parse failures) per project.
- Batch a mental upgrade plan by scanning all custom projects' patch states at once.
- Weave rector patch links into the Upgrade Status deprecation report.
- Confirm the `palantirnet/drupal-rector` toolchain is wired up correctly on a site.
- Produce a starting patch a developer then refines and tests manually.
- Check a theme or install profile for deprecated API usage, not just modules.
- Collect rector results for later review (stored in key/value, survives the request).
- Demonstrate rector output to a team without each dev installing the CLI locally.
- Prioritize which contrib modules to update vs. patch during an upgrade sprint.
- Re-run rector after updating a module to confirm remaining deprecations.
- Export patches for multiple projects to feed into a CI or review workflow.
- Use as a complement to (not a replacement for) test suites during upgrades.
