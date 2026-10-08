<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `scripts/git-clone-origin-for-drutopia-projects.php`

A standalone **developer maintenance script**, not Drupal-loaded code — there is no route, hook, or
Drush command that runs it. A maintainer runs it by hand from a project root
(`php web/modules/contrib/drutopia_dev/scripts/git-clone-origin-for-drutopia-projects.php`).

## What it does

1. Iterates `getcwd() . '/web/modules/contrib/'` with a `DirectoryIterator`.
2. For each subdirectory whose name matches `|^drutopia.*$|` (any `drutopia…` module), opens that
   module's `.git/config`.
3. Runs one `preg_replace` swapping the `origin` remote URL from the HTTPS clone URL to the SSH push
   URL — pattern `|(\[remote "origin"\]\n\surl = )(https://git.drupalcode.org/)|sm` →
   `${1}git@git.drupal.org:` (limit 1 replacement) — then writes the file back with `file_put_contents`.

Net effect: converts checked-out `drutopia*` modules from a read-only HTTPS git remote to the SSH
remote so a maintainer can push. It only helps a developer who has a local git checkout of these
modules.

## Safety notes (dev script, not a web/Drupal boundary)

- Uses only `file_get_contents` / `file_put_contents` / `preg_replace`. **No `exec`, `shell_exec`,
  `system`, `proc_open`, or `passthru`** — no command-injection surface.
- Takes **no user/request input**: paths are derived from `getcwd()` and a fixed directory pattern;
  the substitution strings are hard-coded literals.
- It is a manually-run CLI helper on the developer's own machine, not reachable over the web and not a
  Drupal privilege boundary. It edits local `.git/config` files only; it does not clone or fetch
  anything itself despite the filename.
