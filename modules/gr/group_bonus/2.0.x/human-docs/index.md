# Group Bonus — manual setup guide

**Group Bonus** (`group_bonus`) adds a collection of small convenience features on
top of the [Group](https://www.drupal.org/project/group) module. It doesn't change
how Group decides who can do what — access still follows Group's own
membership and permission model — it simply smooths a few rough edges in the
day‑to‑day experience of working with groups and group content.

The bonus features it provides are:

- **Redirect back to the content after saving.** When you save a group‑content
  form for a node, you are returned to the node itself rather than to a group
  admin listing.
- **Group names in Linkit.** If you use the Linkit module, its autocomplete also
  shows the name of the group, so you can tell similarly named items apart.
- **A "group" tab on content.** A helper tab is added to nodes (for example
  `/node/{node}/group`) so you can quickly find the group a piece of content
  belongs to.

Because everything here builds on Group, you need a working Group setup first —
group types, group content plugins, and memberships all come from the Group
module. Group Bonus just layers these conveniences on top.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group.

There is **no dedicated settings form** for this module (`configure` is null).
Its features take effect automatically once the module is enabled — there is
nothing you must configure. It does provide its own permission(s), which you
grant at **People → Permissions** in the usual way.

## Where it lives in the admin menu

Group Bonus adds no central admin page of its own. Its effects appear in context:
the redirect happens when you save group content, the group name shows up in
Linkit autocompletes, and the "group" tab appears on nodes that belong to a
group. Manage Group itself from **Groups** and **Administration → Groups**, and
grant this module's permission at **People → Permissions**.
