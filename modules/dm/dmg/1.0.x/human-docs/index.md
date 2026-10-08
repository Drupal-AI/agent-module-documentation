# Display Mode Guidelines — manual setup guide

**Display Mode Guidelines** (`dmg`) helps site builders keep display modes under
control by letting you attach free-text *usage guidelines* to them. On a large
site, view modes ("Teaser", "Card", "Full") and form modes tend to multiply, and
nobody remembers what each one is for. This module lets you write a note
explaining how a mode should be used, and shows it as a warning message right on
the Field UI forms where someone would work with — or create — a display mode.

There are two kinds of guideline. A **per-display-mode guideline** is attached to
a specific view or form mode and appears at the top of that mode's *Manage
display* form, reminding editors how it should be used. A **creation guideline**
is set per entity type and appears when someone goes to add a *new* display mode
for that type — the ideal moment to say "please reuse an existing mode instead of
inventing a one-off." Both are written in rich text (admin-filtered HTML) and both
are stored in configuration, so they travel with your config exports.

The module also adds a **Guidelines** column to the view/form mode admin listings,
so you can see at a glance which modes have guidance and which do not. It depends
only on core's **Field UI** module, adds no permissions of its own, and ships no
Drush commands. Editing guidelines is limited to users who can administer display
modes or site configuration, and all guideline text is sanitised on output.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — where to write per-mode and
   per-entity-type guidelines.

## Where it lives in the admin menu

The display mode listings live under **Structure → Display modes → View modes**
and **→ Form modes** (`/admin/structure/display-modes/...`). That is where the new
**Guidelines** column and the **Set creation guidelines** action links appear.
There is no single top-level settings page — guidelines are written in the places
described in [Configuration](configuration/index.md).

## How to use it

- To document an existing mode, edit that view or form mode and fill in its
  **Configuration Guidelines** field; the text then appears as a warning at the
  top of that mode's *Manage display* form.
- To warn people before they create a new mode for a type, use the **Set creation
  guidelines** action link on the display-modes listing; that text appears on the
  "add display mode" form for the matching entity type.

See [Configuration](configuration/index.md) for the step-by-step.
