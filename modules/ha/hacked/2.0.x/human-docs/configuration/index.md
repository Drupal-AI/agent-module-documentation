# Configuration

Hacked! is mostly about *running* the report and reading it — there is only one
actual setting. This page covers running the report, understanding the results, the
single option, the Drush commands, and permissions.

## Run the report and read it

1. Go to **Reports → Hacked!** (`/admin/reports/hacked`).
2. The report lists every project (Drupal core, modules, themes) with a status:
   - **Unchanged** — every file matches the official release. Good.
   - **Changed** — one or more files differ from, or are missing compared to, the
     official release. Worth investigating.
   - **Unchecked** — Hacked! couldn't download or compare the release (for example a
     custom module that isn't on drupal.org, a dev snapshot, or blocked outbound
     network access).
3. Click a **Changed** project to see which files differ or are missing. If the
   **Diff** module is installed, you can open a per-file **diff** to see the exact
   lines that were altered.

The report is cached (about a day) so it doesn't re-download everything on each
visit. To force a fresh check, use **`/admin/reports/hacked/check`**.

### Making sense of "Changed"

A changed project usually means one of: a **patch** was applied (often legitimate —
keep a record of it so updates don't silently drop it), a **manual edit** was made
(consider moving it into a proper patch), or something changed that you didn't
expect (investigate as a possible integrity/security issue). Remember Hacked! never
changes code — acting on the findings is up to you.

## The one setting: file hasher

Go to **Reports → Hacked! → Settings** (`/admin/reports/hacked/settings`). The only
option is which **file hasher** to use when comparing files:

- **Ignore line endings** *(default)* — differences that are only Windows vs Unix
  newline characters are **not** counted as changes. This avoids false positives from
  files that merely got re-saved with different line endings.
- **Include line endings** — newline differences **are** counted as changes. Choose
  this only if line endings genuinely matter for your audit.

Pick one and **Save**. (Developers can register additional hashers in code; that's
covered in the [`agent/`](../agent/start.md) docs.)

## Drush commands

You can run the whole integrity check from the command line — handy for CI or a
quick audit:

```bash
# Full report as a table (title, version, status, changed/deleted counts)
drush hacked:list-projects            # aliases: hlp, hacked-list-projects
drush hlp --force-rebuild             # bypass the cached report and re-download

# Per-file status for a single project
drush hacked:details token            # alias: hd
drush hd token --include-unchanged    # include the unchanged files too

# Unified diff of the changed files in a project (needs the system `diff` binary)
drush hacked:diff token               # alias: hacked-diff
```

As with the UI, the full report is cached for about a day — use `--force-rebuild` to
ignore the cache. (`hacked:lock-modified` still exists for backward compatibility but
does nothing.)

## Permissions

- **Administer site configuration** (core) — required to reach every Hacked! report
  page and the settings form. Hacked! deliberately reuses this core permission rather
  than defining its own report permission, so anyone who can administer site
  configuration can run the integrity report.
- **View diffs of changed files** (`view diffs of changed files`) — a dedicated,
  **restricted** permission for the per-file diff pages (which require the Diff
  module). Because diffs can expose file contents, grant it only to trusted auditors.
  A user still needs *Administer site configuration* to reach the report in the first
  place.

Grant the diff permission from **People → Permissions**, or with Drush:

```bash
drush role:perm:add auditor 'view diffs of changed files'
```
