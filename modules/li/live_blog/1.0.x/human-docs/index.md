# Live Blog — manual setup guide

**Live Blog** (`live_blog`) turns a page into a dynamic, self‑updating feed: new
posts appear for readers without anyone refreshing the browser. It's built for
live events and streams — match coverage, breaking news, product launches — where
an editor adds, updates, or deletes posts and every reader who has the page open
sees the changes appear automatically. Because updates arrive through lightweight
AJAX polling of a small endpoint, it works well behind a CDN such as Akamai or
Cloudflare.

Under the hood, the module defines a revisionable `live_blog` content entity
attached to a parent node. As editors create, update, or delete posts, a log table
records each change, and a front‑end script polls the module's endpoint to append,
replace, or remove the affected posts since the reader last checked. Post
management is gated by per‑operation permissions.

One behavior worth knowing before you launch something sensitive: the polling API
route that feeds readers is **open to anonymous requests by design** (so the live
feed works for the public), and it renders live‑blog entities without an
additional publish/entity‑access check. In practice this means content you attach
to a live blog should be content you're comfortable serving publicly. Treat this
as a low‑severity information‑disclosure consideration when planning what goes into
a live blog.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the Live Blog settings form, plus how
   to set up the Live Blog field and manage posts.

## Where it lives in the admin menu

Live Blog's settings and structure live under **Structure → Live Blog**:

- **Settings:** `/admin/structure/live-blog`
- **Add fields to Live Blog posts:** `/admin/structure/live-blog/fields`
- **List of all created Live Blogs:** `/admin/structure/live-blog/list`

## How to use it

The essential flow is: add a "Live Blog type" field to a content type, enable it
on a piece of content, then start posting.

1. Enable the module (see [Installation](installation/index.md)).
2. Use an existing content type or create a new one at **Structure → Content types
   → Add content type**.
3. On that content type, click **Add field** and add a new field of type **Live
   Blog type**, labelled for example "Live Blog status". Save it, add a helpful
   description like "Enable/Disable the status of Live Blog", and save again.
4. On the content type's **Manage display** page, hide the **Label** for that new
   field.
5. Create a piece of content of that type, tick the **Live Blog status** checkbox,
   and save.
6. You can now add, update, and delete Live Blog posts. Multiple readers can have
   the page open at once, and every post change updates for all of them
   automatically.
