# Popup Lite — manual setup guide

**Popup Lite** (`popup_lite`) is a lightweight popup/modal system for Drupal built on the
**iziModal** JavaScript library. It provides a custom "PopupLite" content entity so each popup
is managed like any other content — with revisions and translations — and rendered as a modern,
animated modal dialog. It's a low‑overhead way to show messages, promotions, or embedded
content without pulling in a heavy framework.

Each popup can carry an admin title, custom HTML for the header and body, optional media from
the Media Library (image, audio, or video), call‑to‑action links, and even external content
loaded in an iframe. You control its appearance (width, fullscreen mode, header colour,
overlay behaviour, background‑scroll locking, custom CSS classes), when it opens (on page
load, on exit intent, or on a manual trigger you point at a CSS selector), an auto‑open delay,
cookie‑based frequency capping, and the paths where it should or shouldn't appear. A
free‑form **Modal settings (JSON)** field lets you pass any iziModal option directly for
advanced tuning.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

Popup Lite has no single "settings" page; you create and configure each popup on its own
entity form. See "How to use it" below.

## Where it lives in the admin menu

Create and manage popups at **`/admin/content/popup-lite`** (**Content → Popup Lite**). Click
**Add Popup** to create a new one.

## How to use it

1. Go to **`/admin/content/popup-lite`** and click **Add Popup**.
2. Give it an administrative **title** and add the **content** — HTML for the header and body,
   any **media** from the Media Library, and **CTA links**.
3. Set the **layout & appearance** — width, fullscreen mode, header colour, overlay display
   and click‑to‑close behaviour, background‑scroll locking, and any custom CSS classes.
4. Choose a **trigger**: `on_load` (with an optional auto‑open delay), `before_exit`, or
   `manual`. For a manual trigger, enter a **CSS selector or ID** (for example `#my-button` or
   `.open-popup`) — your own markup or JavaScript then opens the popup by interacting with that
   element.
5. Set **cookie control** for frequency capping and define the **visibility** paths where the
   popup should be shown or hidden.
6. Optionally fine‑tune the modal with the **Modal settings (JSON)** field, which accepts any
   iziModal option.

Once saved, popups with `on_load` or `before_exit` triggers appear automatically according to
their rules; manual‑trigger popups wait for their configured element to be activated.

Developers can extend Popup Lite with new templates via `hook_popup_lite_template_alter()` and
custom targeting logic — see the module's `popup_lite.api.php` for the available hooks.
