# Commento Field — manual setup guide

**Commento Field** (`commento_field`) integrates
[Commento](https://commento.io/) — a lightweight, privacy‑focused third‑party
commenting service — into Drupal as a **field**. Instead of using Drupal's core
comment system, content that has this field displays an embedded Commento comment
thread, and visitors comment through Commento's own widget. It's a good fit if
you'd rather offload comment storage and moderation to Commento's hosted service
while keeping the discussion visible on your Drupal pages.

Because comments live in Commento rather than in Drupal, the widget loads
Commento's **third‑party JavaScript** from Commento's CDN
(`https://cdn.commento.io/js/commento.js`) on the pages where you place the field.
Each page's thread is identified by the content's canonical URL, so you associate
your site by registering its domain in your commento.io account — **there is no
Drupal setting for a Commento server URL, and the module does not point at a
self‑hosted Commento instance.** Comment data (including each page's URL) flows to
Commento, so review the privacy and data‑flow implications for your site and
audience before enabling it publicly. The
module provides two permissions — `toggle commento comments` (control whether the
thread shows) and `view commento comments` (see the thread) — and supports Drupal
9, 10, and 11. This release is marked *not covered* by Drupal's security advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form** — you add the field to a content type and,
optionally, adjust display options on *Manage display*, as described in "How to
use it" below.

## Where it lives in the admin menu

Commento Field adds no configuration page of its own. You work with it as a field
under **Structure → Content types → *(type)* → Manage fields**
(`/admin/structure/types/manage/*/fields`) and **Manage display**, and you review
its permissions at **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Add a **Commento** field to the content type whose pages should show a Commento
   thread (via *Manage fields*). The field itself just stores a per‑item on/off
   flag; the comment script always loads from Commento's CDN.
2. On the content type's **Manage display**, make sure the field is shown where you
   want the thread to appear. Optionally open the **Commento** formatter's settings
   to disable auto‑init, disable the default font, or hide deleted comments.
3. Grant **`view commento comments`** to the roles that should see threads, and
   **`toggle commento comments`** to those allowed to turn the thread on or off via
   the field's checkbox when editing content.
4. Register your site's domain in your **commento.io** account so Commento accepts
   comments for your pages.

Once set up, the Commento widget appears on that content and visitors comment
through it. Because this loads third‑party script and sends comment activity
(including each page's URL) to Commento, confirm your privacy notices and
data‑handling reflect that.
