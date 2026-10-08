# Remove Unused Files — manual setup guide

**Remove Unused Files** (`remove_unused_files`) is a housekeeping tool for sites
that have accumulated **orphaned files** — an image uploaded and then removed from
a node, a document that was replaced, a media item that was deleted — which still
sit in the files directory and the `file_managed` table taking up space. Drupal
does not remove these for you by default. This module finds managed files whose
recorded **usage count is zero** and moves them to **temporary** status; Drupal's
normal temporary-file cleanup then deletes them on a later cron run.

That "move to temporary, delete on a later cron" behavior is a deliberate safety
margin — files are not unlinked the instant you run the tool, which gives you a
window to notice a mistake. You trigger a cleanup with the Drush command
`drush remove_unused_files`, and an optional submodule adds a menu-link/form way to
run it from the UI. It depends on core's **File** module and runs on Drupal 10 and
newer.

## Please read this before you run it

This is where data loss happens, so it's worth being blunt: **"zero file_usage"
does not reliably mean "unused."** Drupal's file-usage tracking is only as complete
as every module that registers usage correctly — and many do not. A file embedded
in body text through a WYSIWYG editor, referenced from configuration, used by a
custom module that never called `FileUsage::add()`, or linked from another system
entirely, can show a usage count of zero while being very much in use. Delete it
and you silently break whatever referenced it; the breakage surfaces later as a
missing image or a 404.

So treat this as a powerful tool to be used **with verification, not trust**:

- **Back up** your public files, private files, and database before running it.
- **Review** what it proposes to remove against how your site actually uses files.
- Be **especially cautious** on sites that use WYSIWYG file embeds, or any module
  known not to register file usage.
- Lean on the temporary-status grace window — don't assume the first run is final.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   add the optional form submodule.

There is **no configuration form** — the tool is run on demand via Drush or the
optional form submodule, as described below.

## How to use it

1. **Back up first** (public files, private files, and database).
2. Run the cleanup from the command line:

   ```bash
   drush remove_unused_files
   ```

   This moves managed files with zero usage to temporary status.
3. On the **next cron run**, Drupal's temporary-file cleanup deletes those files.
   You can run cron from **Reports → Status report** or with `drush cron`.

If you prefer a UI, enable the **remove_unused_files_form** submodule, which adds a
menu link/form to trigger the same cleanup from the admin interface. (The older
`remove_unused_files_link` submodule is **deprecated** — uninstall it and use
`remove_unused_files_form` instead.)

> **Tip:** On a first run against an important site, verify the list of affected
> files against real usage before letting cron complete the deletion, and keep the
> backup until you're confident nothing was lost.
