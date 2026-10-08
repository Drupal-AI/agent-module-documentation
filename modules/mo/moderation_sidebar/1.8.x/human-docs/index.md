# Moderation Sidebar — manual setup guide

**Moderation Sidebar** (`moderation_sidebar`) gives editors a fast, lightweight
way to moderate content without leaving the page they are looking at. Once
enabled, it adds a **Tasks** button to the Drupal toolbar. Click it while
viewing any moderated content and an off‑canvas panel slides in from the side of
the screen showing the item's current moderation state, who last changed it and
when, and a set of one‑click action buttons.

From that panel an editor can publish a draft, move content along its workflow
(for example Draft → Needs Review → Published), discard a draft, jump between the
live version and the latest pending draft, or edit, delete and translate the
item — all without opening the full edit form. The toolbar button itself doubles
as a status indicator: its label reflects the current state, and it shows
"Draft available" on a published page that has a newer unpublished revision
waiting.

The module builds directly on core's **Content Moderation**, so it works with any
workflow you have already set up and only offers the transitions a given user is
actually allowed to make. It adds nothing to your content until you turn it on,
and everything it does respects the normal edit, delete and view permissions of
the content in question.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Content Moderation.
2. [Configuration](configuration/index.md) — the optional settings form for
   hiding specific workflow transitions from the sidebar.

## Where it lives in the admin menu

There is no central page you need to visit to use Moderation Sidebar — it appears
as the **Tasks** tab in the toolbar whenever you view a moderated item. Its one
small settings form sits at **Configuration → User interface → Moderation
Sidebar** (`/admin/config/user-interface/moderation-sidebar`).

## How to use it

1. Make sure Content Moderation is set up and a workflow is applied to the content
   type (or other entity type) you want to moderate.
2. Give the relevant roles the **Use moderation sidebar** permission (see
   [Installation](installation/index.md)).
3. As one of those users, browse to a piece of moderated content on the front end
   and click the **Tasks** button in the toolbar. The sidebar opens with the
   available actions.
4. Use the buttons to change state, view the draft or live version, or edit,
   delete and translate the item. Each state change creates a new revision with a
   log message (you can write your own by ticking the log‑message option).
