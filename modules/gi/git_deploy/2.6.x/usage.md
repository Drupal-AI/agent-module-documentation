Git Deploy reconstructs the project/version/datestamp info that Drupal's packaging script normally injects, by reading it from the Git log — so projects checked out with Git report accurate versions and stop triggering unsupported-version warnings on the Available Updates page.

---

When Drupal.org packages a release it writes `version`, `project`, and `datestamp` into each `.info.yml`; a raw `git clone` has none of that, which makes the Update Status system flag the project as an unsupported/unknown version. Git Deploy fills the gap at runtime: it implements `hook_system_info_alter()` to inspect each non-hidden extension's repository via shell `git` commands (`rev-parse`, `describe --tags`, `merge-base`, `branch -r`, `log`), determine the best-matching upstream branch or release tag, and synthesize the missing `version` (e.g. `2.6.x-dev` or a real tag), `project` (from the remote fetch URL), and `datestamp` (from the last common commit). For core it verifies the repository is really Drupal before touching versions. It also implements `hook_update_projects_alter()` to sync dev-release datestamps against the Update Status feed so "update available" comparisons are accurate. It requires PHP's `exec()` to be enabled and the `git` binary to be on PATH — `hook_requirements()` reports an error if either is missing. There is no UI, no configuration, no permissions, and no services; enabling the module is the whole setup. It is aimed at developers who work directly in Git checkouts of core and contrib (e.g. to contribute patches) but still want a clean update report.

---

- Develop on a live/staging site from Git checkouts without unsupported-version warnings.
- Get accurate version strings on `/admin/reports/updates` for Git-checked-out contrib.
- Show a real `x.y-dev` version for a module tracking a contrib dev branch.
- Report the correct release tag when a checkout sits exactly on a tagged commit.
- Restore the `project` name (from the Git remote URL) for cloned projects.
- Restore a sensible `datestamp` so "last updated" columns are populated.
- Verify that a cloned core checkout is really Drupal before altering its version.
- Let the Update Status module compare your dev checkout against available releases.
- Contribute patches to contrib modules from a working Git clone while keeping update reports sane.
- Keep several sites on the same dev release consistent (paired with a pinned commit checkout).
- Avoid manually editing `.info.yml` files to add version stanzas after a clone.
- Detect when a tracked upstream branch is out of sync with the local checkout.
- Sync dev-release datestamps with the Drupal.org release feed for accurate freshness.
- Diagnose a broken update report by enabling the module's `hook_requirements()` check for `git`/`exec()`.
- Work around Git failing for PHP users with no HOME directory (module sets HOME automatically).
- Support Windows hosts (falls back to `nul` when `/dev/null` is absent).
- Use as a lighter alternative to Drush make/`git_drupalorg` package handlers for version info.
- Keep contrib modules recognizable to Update Status even when checked out on `master`/`main`.
- Provide correct version metadata to other modules that read extension `version` at runtime.
