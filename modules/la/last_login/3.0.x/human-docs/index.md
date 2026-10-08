# Last Login — manual setup guide

**Last Login** (`last_login`) shows the currently logged‑in user their own
*previous* login time in a small block. It is deliberately tiny: it stores the
last login time in a session variable and renders it through a **Last Login
Time** block that you place in any region. It creates no database table, adds no
configuration form, and registers no routes — it is about as lightweight as a
Drupal module gets.

The value is a gentle activity‑awareness cue. Because each person only ever sees
*their own* last login timestamp, and only after they log in again, it can help
someone notice an unexpected prior login on their account. The timestamp is shown
only to authenticated users; anonymous visitors see nothing.

Because it records and displays per‑user login activity, treat it as a (very
small) privacy surface: the information shown is the user's own, but it is still
login‑activity data. There is nothing to tune, so the only decision is where you
place the block and who can see that region.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. The
only setup is placing the block, described in "How to use it" below.

## Where it lives in the admin menu

Last Login adds no admin settings page. You use it entirely from **Structure →
Block layout** (`/admin/structure/block`), where you place the **Last Login
Time** block into a region.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and click **Place block** in the region
   where you want the timestamp to appear (a sidebar, header, or footer are
   common choices).
3. Find and place the **Last Login Time** block. Optionally restrict its
   visibility (for example, to authenticated users) using the block's standard
   visibility settings.
4. **Log out and log back in.** The value is populated from your session, so the
   block only shows a timestamp after you have logged in again at least once.
