<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PatchInfo records which patches are applied to which Drupal modules and themes and shows them prominently on the update status report and update manager form — and is now marked **obsolete** by its maintainers, so it can no longer be freshly installed.

---

Every non-trivial Drupal site carries patches — a fix backported from an unreleased branch, a workaround for an incompatibility, a local behaviour change — usually applied by `cweagans/composer-patches` from a list in `composer.json`. Once applied they become invisible: the update report shows a project's version but says nothing about the patches on top of it, so whoever runs the next update can silently lose them. PatchInfo closes that gap by reading **patch sources** and displaying each project's patches beside it on *Reports » Available Updates* and on the update manager form. It ships two source sub-modules you enable as needed: **PatchInfo composer.json Source** (`patchinfo_source_composer`) reads `extra.patches` from your `composer.json` (cweagans format, `drupal/*` packages only), and **PatchInfo info.yml Source** (`patchinfo_source_info`) reads a legacy `patches:` list you add to a module or theme's `*.info.yml`, e.g. `patches:` then `- 'https://www.drupal.org/node/1739718 Issue 1739718, Patch #32'` (URL first, optional, then any description; quote the entry). A third sub-module, **PatchInfo Drupal.org**, enriches the CLI report with issue metadata. On the command line, `drush patchinfo:list` (alias `pil`) prints a table of every tracked patch; `--projects=`, `--format=` and `--fields=` narrow it. The update settings form also gains an **"Exclude modules from update check"** textarea (one machine name per line) so unsupported or intentionally frozen modules stop generating update noise, with the excluded list shown above the report. **The catch:** `patchinfo.info.yml` now declares `lifecycle: obsolete`, and Drupal core will not install an obsolete module — a fresh `drush en patchinfo` fails, though a site upgraded from an older release keeps working. The maintainers recommend recording patches directly in `composer.json` with an issue URL and comment per entry as the durable replacement, and reviewing that list as part of every update.

---

- Track which patches are applied to which modules.
- See applied patches on the update status report.
- See applied patches on the update manager form.
- Avoid silently dropping patches during an update.
- Read patches from `composer.json` (cweagans/composer-patches).
- Read patches from legacy `*.info.yml` `patches:` lists.
- Annotate a patched module in its info.yml with an issue URL.
- Enable only the patch source sub-module(s) you need.
- List all tracked patches on the CLI with `drush patchinfo:list`.
- Filter the CLI report by project with `--projects=`.
- Output the patch report as YAML or CSV.
- Choose which columns the patch report shows with `--fields=`.
- Enrich the CLI report with drupal.org issue metadata.
- Exclude an unsupported module from the update check.
- Silence update noise for an intentionally frozen module.
- Show the excluded-modules list above the update report.
- Write a custom patch source plugin for another patch store.
- Audit an inherited site's applied patches.
- Review patch coverage before a core or contrib upgrade.
- Understand why patchinfo cannot be freshly installed.
- Recognise Drupal's obsolete lifecycle state.
- Migrate patch tracking into `composer.json` as the replacement.
- Keep an issue URL and comment for every recorded patch.
