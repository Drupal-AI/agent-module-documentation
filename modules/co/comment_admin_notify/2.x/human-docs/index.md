# Comment Admin Notify — manual setup guide

**Comment Admin Notify** (`comment_admin_notify`) is a lightweight tool that
emails the site administrator whenever a user posts a new comment. On a moderated
or low‑traffic site, that means you find out immediately — so you can approve a
pending comment or reply — without having to keep checking the comment
administration screen yourself.

It's a simple notification convenience with no unusual security surface. It builds
on Drupal's core Comment system and uses the [Token](https://www.drupal.org/project/token)
module for its message text. The one thing worth keeping in mind is that the
comment content is included in the notification email, so make sure notifications
go to an appropriate inbox, and be mindful of email volume if your site gets a lot
of comments. It works on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Token
   dependency) with Composer and enable it.

## Where it lives in the admin menu

Comment Admin Notify runs quietly in the background — once enabled, it sends the
notification email when a comment is created. Notifications are directed to the
site administrator; direct them to an inbox that is actually watched.
