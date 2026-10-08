# Alter Admin Table — manual setup guide

**Alter Admin Table** (`alter_admin_table`, project `ata_st`) is a small
administration helper aimed at making admin listing tables easier to tailor and
helping newcomers discover modules to install. Its stated goal is to let you adjust
the columns shown in admin listing tables per content type and to surface Composer
commands so site builders can find and add modules.

Be aware of what actually ships in this version: the module registers a single help
hook and one route, and the controller behind that route currently returns a
**placeholder ("Hello World")** rather than a finished admin table. In practice
today the value is in the module's help text and its alteration hooks — it is best
understood as a lightweight convenience/scaffold module rather than a polished
feature. It has no configuration form and no state-changing endpoints, no secrets,
and makes no external calls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds one route at **`/alter-admin-table`**, guarded by the core
**access content** permission (effectively public on most sites). Visiting it shows
the module's help/placeholder output.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Visit **`/alter-admin-table`** to see the module's help page.

Because the shipped controller is a placeholder, treat this as a starting point:
the intended use is to build on its hooks to customise admin listing columns and to
combine it with core's **Extend** page for module management. If you only need
core's built-in module list, you may not need this module.
