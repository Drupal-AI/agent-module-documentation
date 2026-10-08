# Checkbox/Radio Multi-Columns — manual setup guide

**Checkbox/Radio Multi-Columns** (`checkbox_radio_buttons_multi_columns`) solves a
small but common layout annoyance: when a field offers many checkbox or radio
options, Drupal stacks every one of them in a single tall column, forcing editors
to scroll through a long, narrow list. This module lets you spread those options
across two, three, or more columns so a long list of choices becomes a compact,
scannable grid.

It works entirely through a field's form display settings. Once enabled, you pick
the multi-column widget on a checkboxes or radio-buttons field and choose how many
columns you want — there is no site-wide settings page to visit. It depends only
on core's **Options** module (`options`), which supplies the list field types these
widgets apply to.

This is a display-only convenience for the editing form; it does not change the
stored data, only how the options are arranged on screen while someone fills in
the form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You set it up per field on the
entity's **Manage form display** tab, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Structure → Content
types (or any fieldable entity) → *(bundle)* → Manage form display**.

## How to use it

1. Add or locate a field that uses a **List** type with allowed values (for
   example *List (text)* rendered as checkboxes or radio buttons).
2. Go to the bundle's **Manage form display** tab.
3. For that field, choose the multi-column checkbox/radio widget in the **Widget**
   column.
4. Open the widget's settings (the gear icon) and set the **number of columns**
   you want the options spread across.
5. Save. Open the entity's add/edit form and the options now flow across the
   columns you chose instead of one long list.
