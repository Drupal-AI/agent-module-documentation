<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Toolbar Mediteran (admin_toolbar_mediteran) — agent index

A CSS/library skin that restyles the Admin Toolbar (and the shortcut bar, user menu and Coffee
dialog) in the "Mediteran" look. Adds **no** toolbar features. Requires contrib `admin_toolbar`
(which pulls in core `toolbar`). Styling loads only for users with the core `access toolbar`
permission. Core requirement `^8 || ^9 || ^10 || ^11`; `.info.yml` reports legacy `8.x-1.18`.

**Nothing to configure** — no routes, no permissions of its own, no config, no settings form,
no PHP classes. Enable it and the skin applies.

- How the restyle works — the one library, its ten CSS files, the attachment hooks, the body
  class, overriding it, and the D8→D11 compatibility caveat →
  [theming/admin_toolbar_mediteran.md](theming/admin_toolbar_mediteran.md)
