# Entity Usage Delete Stop — manual setup guide

**Entity Usage Delete Stop** (`entity_usage_node_delete_stop`) is an add‑on for the
**Entity Usage** module. Entity Usage already tracks which content references which,
and can show a warning on a node's delete form when other content still links to
it. This module turns that warning into an actual **stop**: per content type, you
can prevent editors from deleting a node while it is still in use somewhere.

You switch it on per content type. When it's active for a type and a node still has
usages, the node's delete confirmation form shows an error — *"Deletion is disabled
until all usages are removed"* — and its delete button is greyed out, unless the
current user holds a special skip permission.

It's important to understand the boundary: this is a **confirmation‑form guard**,
an editorial safety net, not entity‑level access control. It blocks the "delete"
button that editors click, but it does not stop programmatic deletions — Drush,
Views Bulk Operations, migrations, REST/JSON:API calls, or custom code can still
delete the node. Treat it as a guard rail for humans, not as referential‑integrity
enforcement.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (it needs the Entity Usage module) and enable it.

## How to use it

### Check the precondition first

The whole feature only works where Entity Usage would already show its delete
warning for nodes. Two things must be true:

1. **`node`** must be listed in Entity Usage's *delete warning* setting
   (`entity_usage.settings: delete_warning_message_entity_types`). You can check it
   with `drush cget entity_usage.settings delete_warning_message_entity_types`.
2. Entity Usage must actually render its warning on the delete form.

If those aren't in place, the checkbox described below won't even appear, and the
stop won't apply.

### Turn it on for a content type

Edit the content type (**Structure → Content types → *your type* → Edit**). With
the precondition met, you'll see an **Entity Usage Node Delete Settings** group
containing one checkbox — **Do not allow deletion of used nodes of this type**.
Tick it and save. The setting is stored with the content type's configuration, so
it exports with your site config.

### Let trusted editors override

Grant the **Skip node delete stop** permission to any role that should be allowed
to delete used nodes anyway — the stop is skipped for those users.

## Where it lives in the admin menu

There is no standalone settings page. The single switch lives on each **content
type's edit form** (*Structure → Content types → … → Edit*), in the *Entity Usage
Node Delete Settings* section. The override is the *Skip node delete stop*
permission on *People → Permissions*.
