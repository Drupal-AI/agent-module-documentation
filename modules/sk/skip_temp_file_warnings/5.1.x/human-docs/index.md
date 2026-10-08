# Skip Temp File Warnings — manual setup guide

**Skip Temp File Warnings** (`skip_temp_file_warnings`) gets rid of a specific,
nagging log message that Drupal produces during file garbage collection:

> Could not delete temporary file "public://sample.jpg" during garbage collection

Drupal automatically deletes unused temporary managed files on cron. But when a
file has already been removed from disk, core still tries to delete it and logs
this error — and the message reappears on every single cron run, with no obvious
way to clear it from the UI. This module removes the stale temporary-file entries
that trigger the warning, so it stops repeating.

You tell the module which file-URI schemes to clean up by entering the scheme
strings on Drupal's logging settings page (for example `public`, or several as a
comma-separated list). The cleanup then runs on cron. The module has no
dependencies, no permissions, and no access-control role of its own.

> **A note of caution:** this module *deletes temporary file records*. Core's
> default retention of temporary files exists for a reason — files that are
> legitimately mid-workflow should not be removed prematurely. Make sure the
> cleanup fits how your site uses temporary files before relying on it.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — tell it which file-URI schemes to
   clean up.

## Where it lives in the admin menu

The module does not add a page of its own. Instead it adds a setting to Drupal's
core logging page at **Configuration → Development → Logging and errors**
(`/admin/config/development/logging`), where you enter the file-URI scheme
string(s) it should clean up. The actual cleanup runs on cron.
