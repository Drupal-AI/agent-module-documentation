# Entityqueue Form Widget — manual setup guide

**Entityqueue Form Widget** (`entityqueue_form_widget`) is a small convenience
add-on for the **Entityqueue** module. Entityqueue lets you build hand-curated
lists of content — a "Featured" list, a homepage carousel, "Top stories" — but
normally an editor has to leave the content they're editing and go to a separate
Entityqueue admin screen to add or remove an item. This module brings that
control to where editors already are: it adds an **Entityqueues settings** panel
to the sidebar of the node add/edit form, with a checkbox for each relevant
queue. Tick a box to add the node to that queue, untick it to remove — all in the
same save as the rest of your edits.

The panel is smart about what it shows. A queue's checkbox only appears if that
queue targets the node's content type, and only if the editor has permission to
manage that queue (using Entityqueue's own permissions). Each checkbox also shows
how full the queue is — for example "3 out of 5 items" — and disables itself when
a fixed-size queue is already full. Unpublished drafts are kept out of queues
until they're published (with support for Scheduler's scheduled-publish dates).

This is a **zero-configuration** module: there's no settings form, no permissions
of its own, and nothing to switch on. The widget simply appears on node forms
once you have at least one matching entityqueue. It requires the Entityqueue
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no menu items and has no settings page. It works on the content
add/edit forms themselves — the **Entityqueues settings** panel appears in the
right-hand sidebar (the "advanced" area, alongside authoring information and
similar) when you edit a node.

## How to use it

1. **Set up a queue first.** In Entityqueue (**Structure → Entityqueues**,
   `/admin/structure/entityqueue`), create a queue that targets the **node**
   entity type, and either allow all bundles or include the content type you
   care about. The widget only appears when at least one queue matches the node
   you're editing.
2. **Edit a node.** Open any node of that content type for editing. In the
   right-hand sidebar you'll see an **Entityqueues settings** panel.
3. **Check or uncheck queues.** Each matching queue you have permission to manage
   shows as a checkbox, labeled with the queue name and its current fill (for
   example "Featured (3 out of 5 items)"). Tick to add the node to that queue,
   untick to remove it. A full fixed-size queue's checkbox is disabled unless the
   node is already in it.
4. **Save the node.** The node is added to the checked queues and removed from
   the unchecked ones as part of the save.

A few things to know:

- **Permissions come from Entityqueue.** For a queue's checkbox to appear, the
  editor needs Entityqueue's *Update this queue* permission for that queue, or
  the *Manipulate all entityqueues* permission. This module defines no
  permissions of its own.
- **Drafts stay out of queues.** An unpublished node isn't added to a queue
  until it has a published revision (or a Scheduler publish-on date), so your
  curated lists don't surface content that isn't live.
