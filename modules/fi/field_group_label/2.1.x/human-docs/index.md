# Field Group Label — manual setup guide

**Field Group Label** (`field_group_label`) lets each individual entity supply its
own heading for a **field group** — the collapsible sections, tabs, and accordions
you build with the [Field Group](https://www.drupal.org/project/field_group)
module. Normally a group's label is fixed in the display configuration and is the
same on every node. With this module, an editor can type a per-entity value that
*becomes* the group's rendered title, so a "Details" or "Additional information"
section can read something meaningful and specific to each record.

It works by adding a small text field (its own **Field Group Label** field type)
that you place *inside* the group whose heading you want to drive. The field never
renders in its own right — instead its value is used to override the group's
title when the entity is displayed. If an editor leaves it empty, the group falls
back to its normal configured label, so nothing breaks. The value is treated as
plain text (it is HTML-escaped), and only the first such field in a group takes
effect.

This is a small, code-only helper — there's no settings page, no permissions, and
no configuration beyond adding the field and pointing its formatter at the group.
It pairs naturally with tabs/accordion field-group formatters where per-entity
section titles make the layout feel like part of the content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Field Group)
   with Composer and enable it.

## Where it lives in the admin menu

There is no settings page. You configure everything on the target bundle's
**Manage fields**, **Manage form display**, and **Manage display** tabs under
**Structure**, alongside your existing field groups.

## How to use it

1. On the bundle you're working with (for example **Structure → Content types →
   *(your type)***), create the **field group** you want a per-entity heading for,
   as usual, on *Manage form display* and/or *Manage display*.
2. On **Manage fields**, click **Add field** and choose **Field Group Label**.
   Give it a label and save. (You can set a **Maximum length** on the storage
   settings; the default is 255.)
3. On **Manage display**, place that field **inside** the group whose heading it
   should control, and set its formatter to **Field Group Label**. The field
   itself won't be shown — its value replaces the group's title.
4. On **Manage form display**, use the **Field Group Label** widget so editors get
   a text box to type the heading. You can set the box's **size** and an optional
   **placeholder** hint in the widget settings.

Now, when an editor fills in that field on a node, the group's heading on the
rendered page becomes whatever they typed. Leave it blank and the group keeps its
normal configured label.

Notes:

- Put **exactly one** Field Group Label field inside a given group. If there are
  several, only the first is used.
- The value is rendered as escaped plain text, so HTML in it is shown literally
  rather than interpreted.
- This works anywhere Field Group does — nodes, users, paragraphs, media, and so
  on — which makes it handy for captioning repeatable paragraph sections or giving
  tabs entity-specific titles.
