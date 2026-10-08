<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Upgrade Rector runs the Drupal-rector tool against a chosen custom or contributed extension and turns its output into a downloadable patch that fixes deprecated Drupal API use. It is a companion to Upgrade Status: Upgrade Status finds deprecations, Upgrade Rector suggests the code changes.

---

Upgrade Rector wraps `palantirnet/drupal-rector` (which bundles the `rector/rector` engine, installed via Composer) behind an admin form at `/admin/reports/upgrade-rector`. It lists every non-core module, theme and profile grouped into "Custom projects" and "Contributed projects"; you pick one and click "Run rector". The module writes a Rector config from `rector-config-template.php` (loading the Drupal 8, 9 and 10 rule sets), then shells out via PHP `exec()` to `vendor/bin/rector process <extension-path> --dry-run` — a dry run that never edits your files. Raw output is stored per extension in the `upgrade_status_rector_results` keyvalue collection, reformatted into a unified diff, and shown in a modal with the list of applied Rector rules and any error log; an "Export patch" link downloads it as `<name>-upgrade-rector.patch` (or `-results.txt` / `-errors.txt`). When the separate Upgrade Status module is also installed, Upgrade Rector weaves itself into that module's scan form — adding a "Generate patches" checkbox, running Rector as an extra batch step per scanned project, and showing "Patch available / Nothing to patch / Patch error" links in the results. It works standalone without Upgrade Status. Access is gated by the core `administer software updates` permission, and it requires the `exec()` PHP function plus a Composer-installed `vendor/bin/rector` binary. Patches are suggestions to review and apply manually, not an automatic in-place upgrade.

---

- Generate a Rector patch that fixes deprecated API calls in a single custom module before a Drupal 10/11 upgrade.
- Get code-fix suggestions for a contributed module while waiting on (or contributing to) its upstream compatibility work.
- Produce a downloadable `.patch` file to review in a diff tool, commit, or attach to a drupal.org issue.
- See exactly which Rector rules were applied to your code (the "List of applied rectors" in the result modal).
- Run the tool against a theme or install profile, not just modules (the `type` route parameter accepts module/theme/profile).
- Confirm a module has "Nothing to patch" for the transformations Rector currently covers.
- Complement an Upgrade Status scan: after Upgrade Status flags deprecations, use the woven-in checkbox to auto-generate patches for the same projects in one run.
- Batch-generate patches for all scanned projects at once through the Upgrade Status form integration.
- Export the raw error log (`-errors.txt`) when a Rector run fails, to file an issue against Drupal-rector.
- Preview suggested changes as a unified diff inside the admin UI without touching the codebase (dry-run only).
- Jump-start deprecation cleanup on legacy custom code inherited on a project.
- Apply the exported patch locally with `git apply` or `patch -p1`, then run tests before committing.
- Check whether the installed environment can run the tool at all (Status report shows a "PHP exec()" requirement).
- Identify the topmost project for nested custom modules (sub-extensions are collated to their parent for a single run).
- Use it as a teaching aid to learn how deprecated patterns should be rewritten for modern Drupal.
- Re-run after updating a contributed module to its latest dev version to catch remaining incompatibilities.
- Feed the applied-rules list into a manual review checklist for changes Rector cannot fully automate.
- Clear all stored results by uninstalling the module (keyvalue collection is deleted on uninstall).
