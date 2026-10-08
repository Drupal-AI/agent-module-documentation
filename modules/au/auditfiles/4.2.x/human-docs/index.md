# Audit Files — manual setup guide

**Audit Files** (`auditfiles`) helps you find and fix mismatches between the files
on your server's disk, the file records in Drupal's database, and the file
references inside your content. Over the life of a site these three views drift
apart — someone uploads a file over FTP that Drupal never registered, a migration
leaves behind database rows pointing at files that no longer exist, or duplicate
records pile up. Audit Files surfaces those discrepancies as a set of reports and
lets you correct them in bulk.

It ships **seven reports**, all under **Reports → Audit Files**. Each one compares
two of the three "views" of your files and lists the records that do not line up —
files on disk with no database record, database records with no file, managed files
nothing uses, references with no usage entry, and so on. Every report offers fix
actions (delete, add, or merge) that run through Drupal's batch system so they work
on large sites.

A settings page lets you choose which storage scheme to scan (public or private),
exclude files, extensions, and paths you never want audited, and cap how many
records a report loads at once. Deliberately, the fix actions write to the file
tables directly rather than through the normal File API — that avoids triggering the
very problems you are trying to repair. The module works on Drupal 10.3+ and 11 and
depends only on core's **File** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the two
   permissions, and what each of the seven reports finds and fixes.

## Where it lives in the admin menu

- The reports live under **Reports → Audit Files**
  (`/admin/reports/auditfiles`), gated by the *Access Audit Files reports*
  permission.
- The settings form is at **Configuration → System → Audit Files**
  (`/admin/config/system/auditfiles`), gated by the *Configure Audit Files module*
  permission.

## A word of caution

The fix actions on these reports permanently **delete files and database records**.
Take a backup before running large clean-ups, and treat both permissions as
sensitive — the *Configure Audit Files module* permission is flagged
security-sensitive by Drupal for exactly this reason.
