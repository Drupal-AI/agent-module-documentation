<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hacked! detects whether Drupal core or any installed contrib module/theme has been changed from its official packaged release, by re-downloading each project and comparing file hashes.

---

For every project the `update` module knows about, Hacked! downloads the original release archive for the installed version, hashes each file, and compares those hashes against the files on disk to flag projects as **Unchanged**, **Changed**, or **Unchecked**, plus per-file **different**/**missing** counts. Results appear in a report at `/admin/reports/hacked` (rebuild via `/admin/reports/hacked/check`), with a per-project file list and, when the `diff` module is enabled, a line-by-line diff of each changed file at `/admin/reports/hacked/{project}/diff`. The same data is available on the command line via Drush: `hacked:list-projects` (alias `hlp`), `hacked:details` (`hd`), and `hacked:diff`. Hashing is done by one of two swappable "file hashers" declared through `hook_hacked_file_hashers_info()` — `hacked_ignore_line_endings` (default, so Windows/Unix newline changes are not reported) and `hacked_include_line_endings` — chosen in the single config value `hacked.settings:selected_file_hasher` on the settings form (`/admin/reports/hacked/settings`). It depends only on core's `update` module, caches its report in a dedicated `hacked` cache bin, and gates report access behind `administer site configuration` and diff viewing behind the `view diffs of changed files` permission. It does not modify or revert code — it only reports what has drifted from the release.

---

- Detect whether any contrib module has been patched or hand-edited on a live site.
- Verify Drupal core files match the official release (integrity/tamper check).
- Find undocumented "hacks" left by a previous developer before an upgrade.
- List every project with a Changed / Unchanged / Unchecked status in one report.
- See exactly which files in a module differ from the packaged release.
- View a line-by-line diff of a changed file (with the `diff` module enabled).
- Audit a site you inherited to know which modules can be safely updated.
- Catch files accidentally modified during an FTP deploy or hotfix.
- Identify missing/deleted files in a project compared with its release.
- Produce a code-integrity report from the CLI with `drush hacked:list-projects`.
- Script a CI check that fails if core/contrib has drifted from its release.
- Get machine-readable per-project details with `drush hacked:details <name>`.
- Output a unified diff for a project via `drush hacked:diff <name>`.
- Decide whether a module's local changes must be re-applied as a patch after updating.
- Ignore cross-platform line-ending differences when hashing (default hasher).
- Include line-ending differences in the comparison when that matters (strict hasher).
- Confirm a security patch was actually applied to a module's files.
- Review third-party code before trusting a site handed over by a contractor.
- Prioritise which "changed" projects need patch documentation before a major update.
- Rebuild the report on demand after applying or reverting local changes.
- Check a specific project's status quickly by machine name.
- Support a governance/compliance process that requires verifying unmodified core.
- Spot a compromised file whose contents no longer match the official hash.
- Extend the comparison with a custom file hasher via `hook_hacked_file_hashers_info()`.
- Keep the integrity report cached (1 day) to avoid re-downloading releases on every view.
