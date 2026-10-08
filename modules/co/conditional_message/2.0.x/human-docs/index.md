# Conditional Message — manual setup guide

**Conditional Message** (`conditional_message`) displays a custom message banner
anywhere on the page, shown or hidden according to conditions you choose — user
role, path, content type, once-per-session, and a user-dismiss (close) button.
It's designed for quick, flexible notices: inviting logged-out users to register,
announcing an event or maintenance window, promoting a product, showing a cookie
notice, or alerting editors to something that needs attention.

Each message is an entity you create and manage from an admin listing. You set the
message text (HTML is allowed), a background and font colour, and a position (top
or bottom of the page or a specific DOM element), then enable the conditions that
decide when it appears. The messages are **translatable** and can be published or
unpublished without deleting them.

A nice design touch: the conditions are checked in the browser via a small AJAX
call, so the module works well with aggressive caching (Drupal cache, Memcache, or
Varnish). Session and dismiss state live in the browser's `localStorage`; path and
content-type checks run client-side; role checks are verified server-side through a
read-only JSON endpoint. The module depends on core's **Node** module and has no
third-party dependencies.

One transparency note: the read-only endpoint that powers the role check returns
the configured paths, roles, and content types of *published* messages to whoever
can view the page (anonymous visitors by default). That's display metadata meant
to reach the browser anyway, but it's worth knowing you shouldn't treat a message's
targeting rules as secret.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create messages and set their text,
   colours, position, and conditions.

## Where it lives in the admin menu

Manage all your messages at **Content → Conditional message**
(`/admin/content/conditional-message`). Creating, editing, and deleting messages
is gated by dedicated permissions, so you can let editors manage messages without
granting full site administration.
