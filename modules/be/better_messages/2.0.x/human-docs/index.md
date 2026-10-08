# Better Messages — manual setup guide

**Better Messages** (`better_messages`) takes Drupal's plain status, warning, and
error messages — the ones that normally appear as a flat strip at the top of the
page after you save a form — and restyles them as animated popup ("toast")
notifications. The message box can appear centered or tucked into any corner,
fade or slide in and out, count down and auto‑close after a few seconds, and even
be dragged or resized by the visitor. It changes how those messages *look and
behave*; it does not change what they say.

Everything is driven by a single settings form, so there is no custom code or
theme work to do. You choose the position, width, animations, auto‑close timing,
and the draggable/resizable behavior in one place, and the module applies it
site‑wide. Because the drag and resize features rely on jQuery UI, Better Messages
depends on the `jquery_ui_draggable` and `jquery_ui_resizable` modules, which
Composer and Drupal pull in for you.

You can also limit *where* the popups appear. A visibility section on the settings
form uses Drupal's standard condition plugins (such as request path), so you can
show the toasts everywhere except, say, the checkout or certain admin pages. For
site builders working with blocks and conditions, the module additionally ships a
**Message type** condition so other plugins can react to whether a status,
warning, or error message is currently on screen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pull in its jQuery UI dependencies.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   position, width, animations, auto‑close, drag/resize, and page visibility.

## Where it lives in the admin menu

Once enabled, Better Messages immediately restyles the standard messages with its
shipped defaults (centered box, 400px wide, fade in and out, draggable). Its
settings form sits at **Configuration → User interface → Better Messages**
(`/admin/config/user-interface/better-messages`) and is reachable by anyone with
the **Configure Better Messages** permission.

## How to use it

There is nothing to place or embed — the module intercepts Drupal's existing
message output automatically. Enable it, then open the settings form to tune the
look and behavior. Any change you save applies the next time a message is shown,
so the quickest way to preview your settings is to trigger a message (for example,
save a piece of content) and watch how the popup appears and closes.
