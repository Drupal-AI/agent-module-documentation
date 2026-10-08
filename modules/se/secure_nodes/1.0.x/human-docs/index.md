# Secure Nodes — manual setup guide

**Secure Nodes** (`secure_nodes`) prevents important content from being deleted by
accident. It adds a "protected" flag to nodes: once a node is marked protected, it is
safeguarded against deletion — including deletion through bulk operations — so critical
pages, legal documents, or archived content cannot be wiped out with a stray click.

The module gives you three things. First, a **"Protect this Node?" checkbox** appears
in the sidebar of the add/edit form for the content types you have enabled protection
on. Second, **bulk actions** — *Protect content* and *Unprotect content* — let you
apply or remove protection across many nodes at once from the content listing. Third, a
dedicated **Protected Nodes tab** sits next to the Content tab and lists every node
currently marked as protected, so you can see at a glance what is locked down.

Out of the box, protection is enabled for the **Article** content type only. You extend
it to other content types on the module's settings page. It depends on core **Views**
(used to build the Protected Nodes listing and the bulk actions) and provides its own
permissions for the protect/unprotect actions — grant those only to trusted
administrators. As with any protection layer, it is worth confirming the guard covers
the paths you care about (the edit form, the delete route, and any programmatic or API
deletions) for your particular setup.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which content types can be
   protected.

## Where it lives in the admin menu

The settings page is at **`/admin/config/content/secure_nodes`**, where you pick the
content types that support protection. The list of currently protected content lives on
the **Protected Nodes** tab, shown next to **Content** (`/admin/content`).

## How to use it

Once a content type is enabled for protection, open a node of that type for editing and
tick **"Protect this Node?"** in the sidebar, then save. To protect many nodes at once,
go to the content listing, select the nodes, and choose the **Protect content** bulk
action (use **Unprotect content** to reverse it). Protected nodes then resist deletion,
including from the *Delete content* bulk operation.
