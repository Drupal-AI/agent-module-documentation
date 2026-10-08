# Entity Reference Tree — manual setup guide

**Entity reference field tree widget** (`entity_reference_tree`) gives your entity
reference fields a searchable, hierarchical **tree picker**. Instead of typing a
name into an autocomplete box, editors click a button that opens a modal showing
the target entity type's hierarchy as a checkbox tree — perfect for choosing from
deep taxonomy vocabularies with lots of nested terms.

The module adds one field widget that works on any entity reference field. It
builds on core's autocomplete widget, so the familiar type-ahead text field stays
put; the tree simply adds a button beside it. Click the button and a modal
(rendered with the bundled jsTree JavaScript library — no separate install
needed) shows the hierarchy with a search box and checkboxes. Tick what you want,
confirm, and the selections are written back into the field. Selections are always
limited to the field's configured target bundles.

Behind the scenes the tree data is assembled on the server: taxonomy vocabularies
use a dedicated tree builder, and other entity types use a general one. Developers
can add a builder for a custom entity type, and there's a hook for customizing how
each taxonomy term's label appears in the tree.

The widget itself is highly configurable — button label, dialog title, jsTree
theme (including a dark theme), connector dots, animation, autocomplete match
behavior, and more — all set on the field's form display. There is no separate
settings page, permission, or Drush command.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — select the widget on a field and
   tune its settings.

## Where it lives in the admin menu

Entity Reference Tree has **no settings page of its own**. You enable and
configure it per field under **Structure → *(entity type)* → Manage form
display**, choosing "Entity reference tree widget" as the field's widget.

## How to use it

1. On a bundle's **Manage form display**, set your entity reference field's widget
   to **Entity reference tree widget** and adjust its settings with the gear icon.
2. When editing content, click the tree button next to that field to open the
   modal picker, search or browse the hierarchy, tick your selections, and
   confirm.

See [Configuration](configuration/index.md) for each widget setting.
