# Field Group Layout — manual setup guide

**Field Group Layout** (`field_group_layout`) extends the **Field Group** module
with a new group formatter called **Layouts**. It lets a field group use any
Layout Discovery / Layout API layout — one column, two column, three column, and so
on — and place its child fields into that layout's regions. In effect it brings
multi-column arrangements to both the entity **edit form** (Manage form display) and
the rendered **display** (Manage display), without needing Layout Builder.

When you set a field group's format to **Layouts**, its settings gain a "Select a
layout" dropdown populated from all the layouts your site knows about (core's
column layouts plus any provided by a theme or module). Choosing a layout exposes
its regions as sub-groups you drag fields into. If you later change the layout, the
module automatically remaps your fields into the new layout's regions.

This is a site-building tool aimed at organizing fields into columns — for example
putting a group of address fields side by side, or building a "sidebar + main"
arrangement inside a single field group. It defers to Layout Builder where that is
enabled on a display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including its
   Field Group dependency) and enable the module.

## Where it lives in the admin menu

There is no dedicated settings page. You use it inside the **Field UI**, on a
bundle's *Manage form display* or *Manage display* tab (for example *Structure →
Content types → (your type) → Manage form display*), when configuring a field
group.

## How to use it

1. On **Manage form display** or **Manage display** for a bundle, add a field group
   (via the Field Group module) or edit an existing one.
2. Set the group's **Format** to **Layouts** and open its settings.
3. In **Select a layout**, choose a layout — for example one column, two column, or
   `threecol_25_50_25`, plus any layout your theme or other modules provide.
4. Save. The layout's regions appear as targets; drag each child field into the
   region you want it in. The region rows are locked (non-draggable) to keep the
   structure intact.

If you change the selected layout later, the module remaps your existing fields into
the new layout's regions and drops any regions that no longer exist. The layout
choice and the field-to-region mapping are stored in the entity display's
third-party settings, so they export cleanly with your configuration. The module also
provides a simple **Default** (fieldset) formatter with open / description /
required-fields options. Note that on a display where **Layout Builder** is enabled,
Field Group Layout steps aside and defers to Layout Builder.
