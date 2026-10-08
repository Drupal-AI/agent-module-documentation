# Liveblog — manual setup guide

**Liveblog** (`liveblog`) is a live‑blogging platform for Drupal, distributed by
Thunder and used by publishers for the live coverage of events. A liveblog is a
`liveblog` node — a lead article at the top — followed by a stream of individual
`liveblog_post` entries that update automatically for readers. Posts can carry
different kinds of content (text, image, and so on), can be tagged with a
highlights taxonomy, and can even carry a location via Google Maps.

New posts reach readers in real time through a pluggable **notification channel**.
The bundled Pusher integration pushes new and updated posts over Pusher's socket
service; when no push channel is configured, the front end falls back to polling a
lightweight JSON endpoint. Because the read side is designed for public live blogs,
the data structure works well behind CDNs like Akamai.

A couple of exposure details worth understanding up front, since this is public‑
facing content:

- The public post‑list endpoint (`/liveblog/{node}/posts`) is reachable by
  anonymous readers by design, and it returns **only published posts** — the query
  hard‑codes a published filter and runs an access check, and it 404s for anything
  that isn't a liveblog node.
- There is a low‑severity edge case: that endpoint doesn't separately re‑check the
  *parent* node's own view access or published state before listing its published
  posts, so published posts attached to an unpublished or access‑restricted
  liveblog node could still be enumerated. Keep this in mind if you draft liveblogs
  privately before launch.
- Creating, editing, and deleting posts is permission‑gated — there is no
  unauthenticated write path.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies
   with Composer, and enable the Pusher submodule if you want real‑time push.
2. [Configuration](configuration/index.md) — choose a notification channel, enter
   your Pusher credentials, set permissions, and start posting.

## Where it lives in the admin menu

Liveblog's settings live at **Configuration → Content authoring → Liveblog**
(`/admin/config/content/liveblog`), gated by the **administer liveblog settings**
permission. This is where you select the notification channel and enter its API
keys. Liveblogs themselves are created as content (a `liveblog` node type), and
posts are managed through AJAX‑driven forms on the liveblog.

## How to use it

1. Enable Liveblog (and the Pusher submodule if you want real‑time delivery).
2. At **Configuration → Content authoring → Liveblog**, choose the notification
   channel and enter its credentials.
3. Grant the liveblog post permissions to your editorial roles.
4. Create a **Liveblog** node, then add `liveblog_post` entries — they stream to
   readers automatically (via Pusher, or by polling as a fallback).
