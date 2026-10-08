# View access per node — manual setup guide

**View access per node** (`vapn`) is a lightweight per-node access-control module.
On the content types you choose, every node gains a **View access per node** field
where an author picks exactly which roles are allowed to view that specific node.
If a node has one or more roles selected, only users holding one of those roles can
see it; everyone else is denied.

VAPN controls the **view** operation only — it never touches create, update or
delete. It is deliberately simple: instead of a central grants scheme, the
visibility rule travels with the content, right on the node. Leave the field empty
and VAPN stays out of the way for that node, letting core and other modules decide
access as usual. Because it works through Drupal's standard node-access hook, it
composes cleanly with other access modules (any module that forbids still wins).

Setup is two steps: pick which content types VAPN applies to on its settings form,
then set the allowed roles on individual nodes. Three permissions govern it —
`administer vapn` (reach the settings form and edit the field), `use vapn` (edit
the per-node role field), and `bypass vapn` (always allowed to view, for
admin-style roles). The only dependency is core's **Node** module.

> **Upgrading from VAPN 2.x?** Version 3 stores the allowed roles in the new `vapn`
> field. The update hook migrates the old 2.x database table and its `manage vapn
> settings` permission for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant permissions.
2. [Configuration](configuration/index.md) — enable VAPN on content types and set
   per-node view access.

## Where it lives in the admin menu

VAPN's settings form is at **Configuration → People → View access per node**
(`/admin/config/people/vapn`), where you choose which content types use per-node
view access. The per-node control appears as a **View access per node** vertical
tab on each node's edit form.
