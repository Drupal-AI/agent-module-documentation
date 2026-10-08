# Path Redirect Import — manual setup guide

**Path Redirect Import** (`path_redirect_import`) bulk‑creates URL redirects from a
CSV file, so you can load hundreds of redirects at once instead of adding them one
by one on the Redirect module's forms. It is the tool you reach for during a site
relaunch, when importing a redirect map exported from a legacy CMS, or when the SEO
team hands you a spreadsheet of old‑to‑new URLs. It also **bulk‑deletes** redirects
listed in a CSV, and **exports** your existing redirects back out to CSV.

It adds two tabs — **Migrate** and **Export** — to the Redirect module's admin
listing, plus two Drush commands for automating imports and exports from the command
line. You upload a CSV whose header row is exactly `source,destination,language,
status_code`; each data row becomes a redirect from the source path to the
destination, in the given language, with the given HTTP status code (defaulting to a
301 permanent redirect when the code is left blank).

Under the hood the import runs through Drupal's Migrate system, which has a useful
side effect: **re‑importing the same file updates existing redirects rather than
creating duplicates**. The upload form validates each row first — the header must
match, every value must be valid UTF‑8, no cell may be empty, and a source may not
equal its destination — and rejects the whole file if anything is off.

Because it relies on the Migrate framework and the Redirect module, Path Redirect
Import brings a few dependencies along (Redirect, Migrate Source CSV, and Migrate
Tools), all installed for you by Composer. It reuses Redirect's own **Administer
redirects** permission — it defines none of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Redirect, Migrate Source CSV, and Migrate Tools) and enable it.
2. [Configuration](configuration/index.md) — the CSV format, the Migrate / Export
   tabs, the delete option, and the Drush commands.

## Where it lives in the admin menu

The two tabs hang off the Redirect admin listing at **Configuration → Search and
metadata → URL redirects** (`/admin/config/search/redirect`) — a **Migrate** tab
(`/migrate`) for import/delete and an **Export** tab (`/export`).
