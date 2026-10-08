# jQuery ScrollUp — manual setup guide

**jQuery ScrollUp** (`jquery_scrollup`) adds a smooth "back to top" button to your
site. As a visitor scrolls down a long page, a button appears; clicking it glides
them smoothly back to the top. It's a small, familiar navigation nicety that makes
long articles and listings much friendlier to read.

Under the hood it integrates the jQuery ScrollUp plugin (originally by Mark
Goodyear), attaching the library site‑wide so the button works on every page. You
don't have to touch any code — a single admin settings form lets you tune the
button's text or image, how far the visitor must scroll before it appears, the
scroll animation, and its appearance/theme.

The module ships with one permission that gates only the settings form; the button
itself is a purely client‑side convenience and plays no role in access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (plus the
   ScrollUp JavaScript library) and enable the module.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → User interface → jQuery
ScrollUp** (`/admin/config/user-interface/jquery_scrollup`). Reaching it requires
the **Access jQuery ScrollUp settings** permission.
