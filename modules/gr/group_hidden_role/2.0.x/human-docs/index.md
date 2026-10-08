# Group Hidden Role — manual setup guide

**Group Hidden Role** (`group_hidden_role`) is a small extension to the
[Group](https://www.drupal.org/project/group) module that lets you hide selected
group roles from the user interface. It is handy when you use internal or
"system" group roles that members and group administrators should not see or
assign directly — keeping the visible list of roles clean and avoiding confusion.

When enabled, the module adds a **Hidden role** checkbox to the group role edit
form. Any role with that box ticked disappears from the group's member list and is
removed from the list of assignable roles when adding or editing a member. The
role still exists and still works — it just no longer clutters the UI.

One consequence worth understanding: because a hidden role cannot be picked in the
UI, **assigning it can only be done in code**, or by temporarily un-hiding the
role (unchecking *Hidden role*), assigning it, and then hiding it again. Plan for
that if you rely on hidden roles for something members should occasionally
receive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form**. You mark a role as hidden on that role's
own edit form, described under "How to use it" below.

## Where it lives in the admin menu

Group Hidden Role adds no settings page of its own. It adds a single **Hidden
role** checkbox to each **group role** edit form, reached through **Groups → Group
types → *(your group type)* → Roles** and editing a role.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the group type whose roles you want to manage: **Groups → Group types →
   *(your group type)* → Roles**.
3. Edit the role you want to conceal and tick **Hidden role**, then save.

The role is now hidden from the member list and from the assignable-roles list
when adding or editing members. To assign a hidden role, either do it in code, or
temporarily uncheck **Hidden role**, assign it, and re-check it afterwards.
