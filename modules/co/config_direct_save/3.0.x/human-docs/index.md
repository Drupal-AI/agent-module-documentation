# Config Direct Save — manual setup guide

**Config Direct Save** (`config_direct_save`) is a small utility that adds one
button to the admin UI: press it and Drupal writes your site's entire **active
configuration** out to the configuration sync directory as YAML files — no
command line, no Drush required. It is the point‑and‑click equivalent of running
`drush config:export`.

This is handy whenever you cannot (or would rather not) reach a shell. On locked‑
down managed hosting, shared hosting, or for a non‑developer site builder who
edits configuration through the admin screens, this module turns "save my config
to files" into a single click. Typical uses: snapshotting configuration before a
risky change, regenerating stale sync files after editing config in the UI,
seeding an empty sync directory for a fresh checkout, or producing the YAML you
need for a code review — all from the browser.

Optionally, the form can take a **timestamped backup** of the current sync
directory before it overwrites anything, giving you a dated trail of previous
exports (`sync-DD-MM-YYYY-H-i-s`). The export is always the *complete* active
configuration — including config collections such as language overrides — and it
removes YAML for config that no longer exists, so the files end up as a clean
mirror of what's live.

Two things to keep in mind. First, this only writes configuration **out** to
files; it does not import anything. To import, use core's Synchronize screen or
`drush config:import`. Second, unlike core's Synchronize workflow there is **no
diff/review step** — pressing the button overwrites the sync files immediately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module has no settings page of its own. Instead it adds an **"Update"** tab
next to core's configuration Synchronize screen. Go to **Configuration →
Development → Configuration synchronization** (`/admin/config/development/configuration`)
and click the **Update** tab, or navigate directly to
`/admin/config/development/configuration/full/update`.

Access is controlled by core's **Export configuration** permission (from the
Configuration Manager module). The module ships no permission of its own — grant
that core permission to any role you want to be able to run the export.

## How to use it

1. Go to **Configuration → Development → Configuration synchronization → Update**
   (`/admin/config/development/configuration/full/update`).
2. **Config source** — this select is fixed to your site's sync directory (taken
   from the `config_sync_directory` setting); there is nothing to change here.
3. **Backup** — tick this if you want the module to copy the current sync
   directory to a dated sibling folder (`sync-DD-MM-YYYY-H-i-s`) before
   overwriting it. Recommended if you want to be able to roll back.
4. Click **Update configuration**. Drupal deletes the existing `*.yml` files in
   the sync directory and re‑writes every active config object (and every config
   collection) as YAML. You'll see the confirmation "The configuration has been
   uploaded."

**Permissions note:** the web server user must be able to write to — and create
backup subdirectories inside — the sync directory. If the export fails, check the
directory's write permissions (the project README suggests `chmod -R 775` on the
config directory).
