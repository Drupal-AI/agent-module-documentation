# Login Dialog Hotkey — manual setup guide

**Login Dialog Hotkey** (`login_dialog_hotkey`) gives anonymous visitors a
keyboard shortcut that pops open the login form in a dialog — either a **modal** in
the middle of the page or an **off‑canvas** panel sliding in from the side —
without navigating away to `/user/login`. The default shortcut is
**Ctrl + Meta + L**, and you can change both the key and its required modifiers.

It's a nice touch for power users and for sites that want to keep the login
experience on‑page. Once someone logs in, you can optionally redirect them to a
destination you choose. The feature is deliberately scoped to **anonymous users
only**: the key handler and its settings are attached to the page just for
not‑logged‑in visitors, so authenticated users are unaffected.

Importantly, only harmless presentation settings (the key, the modifiers, the
dialog type, and the redirect) are ever sent to the browser. The login itself
still runs through Drupal's standard `user.login` form, so all of core's normal
authentication, flood control, and CSRF protection continue to apply — this module
just changes how the form is *opened*, not how it authenticates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the hotkey, choose the dialog
   style, and configure the post‑login redirect.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Login Dialog Hotkey**
(`/admin/config/user-interface/login-dialog-hotkey`). Access to it is controlled by
the module's **Configure login dialog hotkey** permission, so you can grant it to
trusted editors as well as administrators. There is also an admin‑only preview of
the off‑canvas style at `/admin/login-dialog-hotkey/offcanvas-example`.

## How to test it

Because the shortcut only works for anonymous visitors, log out — or open your site
in a private/incognito window — and press the configured key combination. The login
dialog should appear.
