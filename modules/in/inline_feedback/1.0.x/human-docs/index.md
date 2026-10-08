# Inline Feedback — manual setup guide

**Inline Feedback** (`inline_feedback`) lets administrators and content editors
leave editorial comments **directly on the page**, attached to specific elements
of the content — much like the review comments you'd leave in a shared document.
Instead of emailing "the second paragraph needs a rewrite" or juggling a separate
spreadsheet of notes, a reviewer points at the exact element on a node and leaves
a comment there. A small visual marker then appears on that element, and other
authorized reviewers see it the next time they open the page.

It's a lightweight tool aimed at editorial review, approval workflows, and
collaborative site updates. To leave a comment, a permitted user uses **Ctrl+Click**
(or a long press on mobile) on any visible element of a node, which opens a small
feedback dialog; they type their note and submit, and a marker is pinned to that
element. All feedback is stored as custom entities associated with the node and is
loaded automatically — but shown **only** to users whose roles you have allowed.

Because these notes are internal editorial chatter, the module is built around
role‑based permissions: you decide which roles can create, view, and delete
feedback, and you can restyle the markers so they stand out against your content.
The interface uses Drupal's own dialog library plus a small notification library
for a modern feel, and it needs no other contributed modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which roles can use feedback
   and style the on‑page markers.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
Inline Feedback** (`/admin/config/content/inline-feedback`). That is where you set
the allowed roles and the marker appearance. The feedback itself is created and
read on your site's node pages, not in the admin area.

## How to use it

1. In [Configuration](configuration/index.md), allow the roles that should be able
   to create and view feedback (for example, *Administrator* and *Editor*).
2. Log in as a user in one of those roles and open any node page.
3. **Ctrl+Click** (or long‑press on a touch device) the element you want to
   comment on — a heading, a paragraph, an image, and so on. A feedback dialog
   opens.
4. Type your comment and submit. A small marker appears on that element, and a
   brief on‑screen notification confirms the save.
5. The next reviewer who opens the page (and has permission) sees your marker and
   can read the comment in context.
