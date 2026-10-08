# Notification System — manual setup guide

**Notification System** (`notification_system`) is a framework rather than a
finished feature. It defines what a "notification" is, provides a **plugin type**
so any module can supply notifications from its own event source, lets you bundle
notification types into named **groups**, and ships a **block** that shows the
current user their unread items. Think of it as the plumbing behind a
"notification center" or a bell dropdown — you (or the modules you install)
decide what actually flows through it.

The abstraction is the point. It does not matter where notifications live: they
can sit in the Drupal database, come from an external application, or be
generated on the fly. A provider plugin knows how to list notifications for an
account and — if it opts in — how to mark one read. A `Notification` carries a
provider, id, type, title, body, link, a sticky flag, a timestamp, and a
priority so urgent items sort first. Administrators map providers into groups,
and the block renders them in one of two display modes: **simple** (a dropdown)
or **bundled** (grouped by category), fetched over AJAX or rendered inline.

Because it is a base module, **you need at least one provider for anything to
appear** — either one you write (implement `NotificationProviderInterface` or
extend `NotificationProviderPluginBase`) or one supplied by another module. An
optional `notification_dispatch` submodule concept exists in the project for
sending gathered notifications out through "dispatchers" (email, web push, and so
on); note that web push relies on the `web_push_api` module, which at the time of
writing may need patches on some Drupal versions.

The module depends only on core's **User** module and declares no permissions of
its own. It is safe by design in the ways that matter: the visitor‑facing routes
are always scoped to the current user, so no one can read or mark another
account's notifications through them, and notification titles and bodies are
escaped on output by the Twig templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — map providers into notification
   groups and place the notification block.

## Where it lives in the admin menu

There is no single top‑level settings page (`configure` is null). The main
admin screen is the group‑mapping form at **`/admin/structure/notification-group/mapping`**
(requires *Administer site configuration*), where you wire providers to groups.
The user‑facing display is a block you place through **Structure → Block layout**.

## A note on two routes

Two routes are worth knowing about if you build on the module. The page at
`/notification-system/example` is a **debug table** of the current user's
notifications; it stays reachable in production, is harmless, but is not
something to link users to. And `/notification-system/read/{providerId}/{notificationId}`
marks a notification read on a GET request.
