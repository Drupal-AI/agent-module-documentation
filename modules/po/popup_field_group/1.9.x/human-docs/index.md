# Popup Field Group — manual setup guide

**Popup Field Group** (`popup_field_group`) adds a new "Popup" option to the
**Field Group** module. Field Group lets you wrap a set of fields into a named
group (tabs, accordions, fieldsets, and so on); this module contributes one more
group style — **Popup** — that hides the group's fields on the page and reveals
them in a jQuery‑UI dialog when the visitor clicks an "Open popup" link.

It is handy any time a form or a rendered page has more fields than you want to
show at once. Put a long list of "advanced" fields behind a popup on the node
edit form to declutter it, tuck supplementary product specs into a "More
details" modal on the display, or move rarely used settings into a dialog so
editors see a shorter main form. Because it is a field‑group formatter, it works
on both **Manage form display** (edit forms) and **Manage display** (rendered
output).

Each popup group has its own set of options — the trigger link's text and CSS
classes, the dialog title and close‑button caption, whether the dialog is modal
(blocking) or a floating window, its size and on‑screen position, and whether the
Escape key closes it. There is no site‑wide settings page: everything is
configured per group, right where you add it, and saved into the display's
configuration.

The module depends only on the contributed **Field Group** module. It adds no
permissions, entities, or Drush commands of its own. It optionally works with the
**System Stream Wrapper** module, which unlocks a per‑group field for including
custom CSS files in the dialog.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Field Group.
2. [Configuration](configuration/index.md) — how to add a Popup group and every
   dialog option, field by field.

## Where it lives in the admin menu

Popup Field Group has no menu entry of its own. You work with it inside the
**Manage form display** and **Manage display** screens of any content type,
media type, taxonomy vocabulary, or other fieldable entity — for example
**Structure → Content types → Article → Manage form display**
(`/admin/structure/types/manage/article/form-display`).

## How to use it

On a Manage display or Manage form display screen, click **Add group**, choose
**Popup** as the group type, and drag the fields you want to hide into it. Set
the popup's options, save, and the group's fields will now open in a dialog from
an "Open popup" link. The full walkthrough is in
[Configuration](configuration/index.md).
