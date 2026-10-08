# Node Keep — manual setup guide

**Node Keep** (`node_keep`) protects important content from accidental deletion. It
adds a **"Prevent this node from being deleted"** checkbox to every node; once
ticked, no one can delete that node unless they hold a specific permission. This is
the safety catch you want on a homepage, a privacy policy, a section landing page,
or any node other content references.

The protection is enforced at the access level, not just hidden in the UI: the
delete action (and the delete‑translation action) is removed from the edit form,
and deletion is blocked for anyone without the **Administer node_keep per node**
permission. Editors can still edit and update a protected node — only deletion is
reserved.

If you also run the [Pathauto](https://www.drupal.org/project/pathauto) module,
Node Keep adds a second checkbox, **"Prevent this node's alias from being
changed"**, which locks a node's URL alias against edits by unauthorized users —
handy for a section‑root node whose alias other paths are built on. You can set a
default for each checkbox per content type, so new nodes of a given type are
protected from the moment they're created.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — protecting individual nodes, setting
   per‑content‑type defaults, the global settings form, and the permissions.

## Where it lives in the admin menu

The protection checkboxes appear in a **Node keep** section in the right‑hand
sidebar of each node's edit form. Per‑content‑type defaults are set on the content
type form (**Structure → Content types → [type] → Edit**). The one global setting
is at **Configuration → Content authoring → Node Keep**
(`/admin/config/content/node-keep`).

## How to use it

To protect a single node, edit it, open the **Node keep** section in the sidebar,
tick **Prevent this node from being deleted** (and, with Pathauto, the alias
checkbox), and save. You need the right permissions to see and change these boxes —
see [Configuration](configuration/index.md) for the full walkthrough, including
setting defaults per content type.
