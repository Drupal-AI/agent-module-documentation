# Display Selected and Unselected — manual setup guide

**Display Selected and Unselected** (`display_selected_and_unselected`) is a pair
of field formatters that show *every* allowed option of a list field — not just
the ones a content editor picked — with the chosen options visually marked. Where
a normal list-field display shows only the selected values ("Wi‑Fi, Parking"),
this module renders the full set of choices as read‑only radios or checkboxes,
ticking the ones that apply and leaving the rest unticked.

It's handy for survey‑style or feature‑matrix displays: think "here are all the
amenities, and these are the ones this property has," or an eligibility list that
shows every criterion with the met ones checked. When the field's *Allowed number
of values* is 1 the options render as radio buttons; otherwise they render as
checkboxes. The module supports List (text), List (float) and List (integer)
fields, and ships two formatters — **Display selected and unselected values**
(which outputs the option labels) and **Display selected and unselected keys**
(which outputs the raw option keys).

The module is purely presentational. It has no routes, no permissions, no
services and no settings form — you enable it, then pick one of its formatters on
a content type's *Manage display* tab. If you need custom markup, it renders
through four overridable Twig templates
(`display_selected_and_unselected_{values,keys}_{checkbox,radio}`) that you can
copy into your theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
Setup happens entirely on your field's display, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Structure → Content
types → *(your type)* → Manage display** (or the equivalent Manage display tab on
any fieldable entity).

## How to use it

1. Make sure the entity has a **List (text)**, **List (float)** or **List
   (integer)** field with a set of allowed values defined.
2. Go to that entity's **Manage display** tab.
3. For your list field, open the **Format** dropdown and choose either **Display
   selected and unselected values** (to show the human‑readable labels) or
   **Display selected and unselected keys** (to show the stored keys).
4. Click **Save**.

The field now renders all of its allowed options — as radios if the field holds a
single value, or as checkboxes if it holds multiple — with the selected ones
marked. To customize the HTML, override the module's Twig templates in your theme.
