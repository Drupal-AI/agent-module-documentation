# Contact Author — manual setup guide

**Contact Author** (`contact_author`) provides a block containing a link that
opens the **personal contact form of the current node's author**. Place the block
on your content, and readers viewing a page get a "Contact author" link — clicking
it opens the author's contact form in an off-canvas dialog so they can send the
author a message.

The problem it solves is letting readers reach the person who wrote what they're
reading, without you having to expose anyone's email address. It leans entirely on
Drupal core's personal contact form: the module simply provides the link and the
dialog. It depends only on core's **Contact** module.

This module is thoughtfully built with privacy in mind. The recipient is worked
out **server-side from the node's owner**, not from anything in the request, so
the link can't be pointed at an arbitrary address. The author's **email is never
placed in the page markup** — the link carries only a user id, and core sends the
message. And the actual sending is handled by core's personal contact form, which
enforces the `access user contact forms` permission, each user's own opt-in to
having a contact form, and core's hourly flood control — so this adds no spam or
open-relay path of its own. The link only appears when the author has an email
address on file (and has a reachable personal contact form).

There is no settings form. You set it up by granting a permission and placing the
block, both described below. The module also ships a `contact-author.html.twig`
template you can override in your theme to style the link or change the width of
the off-canvas dialog.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
set it up by granting a permission and placing a block, as described below.

## Where it lives in the admin menu

Contact Author adds no admin settings page. You work in two standard core places:
**People → Permissions** (`/admin/people/permissions`) to allow personal contact
forms, and **Structure → Block layout** (`/admin/structure/block`) to place the
"Contact author" block.

## How to use it

1. **Allow personal contact forms.** At **People → Permissions**
   (`/admin/people/permissions`), grant the **Use users' personal contact forms**
   permission to the roles you want to be able to send messages. Authors must also
   have their own personal contact form enabled for the link to appear.
2. **Place the block.** At **Structure → Block layout**
   (`/admin/structure/block`), pick the region you want and click **Place block**.
   Find the **Contact author** block and place it.
3. **Set the label.** The block title becomes the text of the link, so enter a
   label such as "Contact author". Typically you'll **uncheck "Display title"** so
   only the link shows, then save the block and save the block layout.

Once placed, a reader viewing a node whose author has an email address and an
enabled personal contact form will see the link; clicking it opens the author's
contact form in an off-canvas dialog. To restyle the link or resize the dialog,
override the `contact-author.html.twig` template in your theme.
