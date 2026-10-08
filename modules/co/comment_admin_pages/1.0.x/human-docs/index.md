# Comment Admin Pages — manual setup guide

**Comment Admin Pages** (`comment_admin_pages`) is a small module that renders the
comment **edit** and **delete** forms using your site's **admin theme** instead of
the front‑end theme. If your moderators do their work in the back end, this gives
them a more consistent experience: editing or deleting a comment now looks and
feels like the rest of the administration interface rather than dropping them back
into the public theme.

It's a presentation tweak, not an access‑control change. The admin‑themed forms
appear for users who have core's **View the administration theme** permission, and
the module respects your existing comment permissions — it changes *where* and
*how* the edit/delete forms render, never *who* is allowed to edit or delete
comments. It depends only on core's Comment module and works on Drupal 8.8, 9, 10,
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module works the moment you enable it.

## Where it lives in the admin menu

Comment Admin Pages adds no settings form. Once enabled, the standard comment
edit and delete forms simply render in the admin theme for users who can view the
administration theme. You reach those forms the usual way — for example from the
comment administration screen at **Content → Comments**
(`/admin/content/comment`).
