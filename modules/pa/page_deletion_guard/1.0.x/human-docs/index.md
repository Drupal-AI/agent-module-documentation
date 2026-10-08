# Page Deletion Guard — manual setup guide

**Page Deletion Guard** (`page_deletion_guard`) lets administrators **lock**
specific pages (nodes) so that they cannot be deleted — through the UI or the
access‑control layer — regardless of permission or role, **even an
administrator**. It is a safety guardrail for critical content: your home page,
legal pages, or an elaborate Layout Builder landing page that would be tedious or
impossible to recreate if someone deleted it by accident.

You manage the locks from a single admin page, where you search for nodes and tick
the ones you want to protect. Locked nodes are also flagged in the content overview
with a padlock (🔒) next to the title, so it is easy to see at a glance which pages
are protected. Unlocking is done from the same page — untick a node to allow it to
be deleted again.

It depends only on core **Node** and provides its own permission that controls who
can reach the lock/unlock page. Keep in mind the scope of the protection: it
guards **deletion** of the marked pages — it is a lock against mistakes, not a
replacement for proper delete permissions, and anyone who can reach the lock page
can also unlock a page and then delete it. Grant the "manage locked pages"
permission deliberately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration settings form** for this module. You choose which
pages are locked from the content‑management screen described below, and you
control access to that screen with the module's permission.

## Where it lives in the admin menu

The lock/unlock screen is at **Content → Lock pages**
(`/admin/content/lock-pages`). Access to it is gated by the module's **Manage
locked pages** permission.

## How to use it

1. Grant the **Manage locked pages** permission (under Page Deletion Guard) at
   **People → Permissions** to the roles that should be able to lock and unlock
   pages.
2. Go to `/admin/content/lock-pages`, search for the node(s) you want to protect,
   and tick them to lock. Locked pages are marked with a 🔒 in the content
   overview.
3. To allow a page to be deleted again, return to the same screen and untick it.
