# CKEditor Plugin Report — manual setup guide

**CKEditor Plugin Report** (`ckeditor_plugin_report`) adds a single, read-only
admin report that lists every **CKEditor 5 plugin** registered on your site. For
each plugin the report shows three things: its **Plugin ID**, the **Provider** (the
module that supplies it), and the PHP **Class** that implements it.

It is purely a diagnostic aid. If a toolbar button is missing, if you want to know
which module provides a particular editor feature, or if you are auditing the full
CKEditor 5 plugin surface before a CKEditor 4 → 5 upgrade, this report gives you
the complete inventory in one table. It is also handy for confirming that a
newly-installed module's editor plugin actually registered, or that a plugin
disappeared after you uninstalled its module.

The module is deliberately tiny: one report page, gated by one permission. It has
no settings form, no configuration, no services or plugins of its own, and no Drush
commands. It reads the CKEditor 5 plugin manager gracefully, so it works even if
CKEditor 5 happens not to be installed (the table simply comes up empty).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The report sits under **Reports → CKEditor plugins**
(`/admin/reports/ckeditor-plugins`), linked from the Reports overview. Reaching it
requires the *View ckeditor plugin report* permission.

## How to use it

1. Enable the module.
2. Under **People → Permissions**, grant **View ckeditor plugin report** to the
   roles that should see the inventory. It is marked as a security-sensitive
   (restricted) permission, so grant it deliberately — though it is a good way to
   give a reviewer or QA role read access to the plugin list without broader admin
   rights.
3. Go to **Reports → CKEditor plugins** (`/admin/reports/ckeditor-plugins`). You
   will see a table of every registered CKEditor 5 plugin with its ID, provider
   module, and class.

There is nothing to configure — the page simply reflects whatever CKEditor 5
plugins your enabled modules currently register, so it always stays up to date.
