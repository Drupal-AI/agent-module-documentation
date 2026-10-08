# Module Cleanup — manual setup guide

**Module Cleanup** (`module_cleanup`) finds and removes the data that uninstalled or
deleted modules leave behind. Drupal's `hook_uninstall()` only removes what a module
chooses to clean up, and a module that is simply deleted from the codebase — without
being properly uninstalled first — leaves everything behind with nothing left to
tidy it. That residue then travels in every database dump. Module Cleanup lists the
leftover transient data (entries in `system.schema` key/value storage, state, and
similar) and lets an administrator delete it.

It is the fix for several familiar, hard‑to‑clear errors, including *"Module
`module_name` has an entry in the system.schema key/value storage"*, *"The
`module_name` entity type does not exist"*, and the *"No available releases found"*
message on the Available updates report. It also addresses the
*"non‑existent config entity name returned by FieldStorageConfigInterface::getBundles()"*
error using a logger that listens for the relevant log entry and cleans it up
automatically when you clear caches or install a module.

Beyond the admin screen, the module provides a set of **Drush commands** for the
same jobs, which are handy for scripting or CI. The module has no third‑party
dependencies and supports a very wide range of Drupal core versions.

> **Deletion is irreversible, and ownership is inferred from module naming.** Review
> the list rather than clearing it wholesale, take a database backup first, and be
> careful when a name prefix is shared between a removed module and one still
> installed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no settings form to configure — you use the module directly from its admin
screen and Drush commands, described below.

## Where it lives in the admin menu

The screen is at **Configuration → System → Delete transient module data**
(`/admin/config/system/delete-transient-module-data`), gated by the **Delete
transient module data** (`delete transient module data`) permission. It lists
uninstalled or deleted modules that still have leftover data and lets you delete it.

## Drush commands

The module also ships Drush commands for the same tasks:

- `modcup:delete-config` (alias `modcup-dc`) — deletes leftover data after a module
  is uninstalled. One required parameter: the module machine name.
- `modcup:field-purge-batch` (alias `modcup-fpb`) — runs `field_purge_batch(1000)`
  and reports any errors.
- `modcup:create-storage` (alias `modcup-cs`) — creates a field storage only. Two
  parameters: the field name and the entity type.
- `modcup:delete-field` (alias `modcup-df`) — purges, (re)creates a field storage if
  needed, then deletes the field and its storage. The module owning the entity must
  be installed. Two parameters: the field name and the entity type.
- `modcup:clear-updates` (alias `modcup-cu`) — clears *"No available releases found"*
  errors on the Available updates report.
