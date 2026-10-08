# Content Moderation Bulk State Change — manual setup guide

**Content Moderation Bulk State Change** (`content_moderation_bulk_state_change`)
adds a **bulk action** for moving many pieces of content through their editorial
workflow at once. On a site using core **Content Moderation** and **Workflows**,
editors normally transition each item through its states one at a time. This module
lets an editor select multiple **nodes** — for example in the content admin listing —
and move them to one target moderation state in a single operation, which makes
publishing or archiving a batch of content far quicker.

Access to the operation is controlled by the module's own **"Update entity moderation
states in bulk"** permission, and the action is offered per node according to that
node's edit (update) access. On the confirm form the selected nodes must all share the
same workflow and current state, and the target-state dropdown lists the transitions
defined from that current state. A settings form toggles whether each change creates a
new revision.

It builds directly on core **Workflows** and **Content Moderation**, which are its
only dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form and the permissions
   that govern the bulk action.

## How to use it

After installation, a bulk action is available on content views. Open your content
admin listing, tick the nodes you want to move, choose the "Change workflow stage"
bulk action, then on the confirm form pick the target state and confirm. The dropdown
offers the states reachable by a transition from the selected content's current state.
