# Field Help Text Display — manual setup guide

**Field Help Text Display** (`field_help_text_display`) adds a **Help text
column** to the *Manage fields* table in Drupal's Field UI. Out of the box that
table shows each field's label and type but not its configured help text
(description), which means an administrator has to open each field's edit form
individually just to check what help text — if any — a field has. This module
surfaces all of those descriptions at a glance.

The column shows the description that appears below the field widget on entity
forms. When a field has no help text configured, the cell is simply left blank,
keeping the table clean and easy to scan. It works across **every fieldable
entity type** that uses Field UI — content types, media types, taxonomy
vocabularies, user profiles, and custom entities alike.

Best of all, there's **nothing to configure**: enable the module and the column
appears automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module and no settings — the Help
text column appears automatically once the module is enabled.

## Where it lives in the admin menu

Field Help Text Display adds no admin page of its own. Its effect shows up on the
existing **Manage fields** pages — for example **Structure → Content types →
*(your type)* → Manage fields** — where the new **Help text** column appears
between the existing columns and the Operations column. The same column appears
on the Manage fields page of every other fieldable entity type.

## How to use it

Just enable the module and browse to any entity type's **Manage fields** page.
The **Help text** column is there automatically, showing each field's configured
description (blank where none is set). There are no steps beyond installation.
