# Entity Group Field — manual setup guide

**Entity Group Field** (`entitygroupfield`) lets editors set which groups a piece
of content belongs to directly from that content's own add/edit form. Normally the
[Group](https://www.drupal.org/project/group) module makes you create content
through its separate "Add content" flow to attach it to a group; this module adds a
computed **Groups** field so the same choice can be made inline while you edit a
node, a user, or any other entity that participates in groups.

The field is "computed", which means you never create it by hand on the *Manage
fields* screen — the module attaches it automatically to every entity type that has
a Group relation. For example, users always get it (through group memberships), and
nodes get it once a group-node relation is installed. Out of the box the field sits
in the *hidden* region, so nothing changes on your forms until you deliberately turn
it on for a bundle.

You turn it on per bundle from the entity's **Manage form display** page by choosing
one of two widgets — **Group select** (a dropdown, the default) or **Group
autocomplete** (better when you have many groups) — and you can optionally show the
group on the rendered page by adding a formatter on **Manage display**. There is no
central settings page; everything is configured per bundle.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the required Group module.

## Where it lives in the admin menu

Entity Group Field has **no settings page of its own**. You work with it on each
entity type's display configuration:

- **Manage form display** — e.g. **Structure → Content types → *(a type)* → Manage
  form display** (`/admin/structure/types/manage/<type>/form-display`), or for users
  **Configuration → People → Account settings → Manage form display**.
- **Manage display** — the matching *Manage display* tab, if you also want the group
  shown on the rendered entity.

## How to use it

1. Make sure the [Group](https://www.drupal.org/project/group) module is set up and
   the entity type you care about has a group relation (users always qualify; for
   nodes you need a group-node relation installed).
2. Go to that entity's **Manage form display** page. You'll see a **Groups** row that
   is currently in the *Disabled* / hidden region.
3. Drag it into the enabled area and pick a widget:
   - **Group select** (`entitygroupfield_select_widget`) — a dropdown of the groups
     the editor is allowed to use. This is the default.
   - **Group autocomplete** (`entitygroupfield_autocomplete_widget`) — a type-ahead
     box, better when there are many groups to choose from.
4. Open the widget's settings (the gear icon) to adjust:
   - **Label** and **Help text** shown to editors.
   - **Multiple** — allow the entity to belong to several groups (on by default);
     turn it off to limit the entity to a single group.
   - **Required** — force editors to place the content in at least one group.
5. Save. Now when someone edits that content, they can add or remove its groups right
   on the edit form.
6. (Optional) On **Manage display**, enable the **Groups** field and choose a
   formatter to show the parent group on the rendered entity:
   - **Parent group label** (default) — shows the group's name, optionally linked to
     the group.
   - **Parent group rendered entity** — renders the whole group in a chosen view mode.
   - **Parent group ID** — outputs just the group's ID, handy for theming or
     integrations.

To hide the field again, drag the **Groups** row back into the *Disabled* region on
Manage form display; it returns to the hidden region and stops appearing on the form.
