# Full Screen Mode — manual setup guide

**Full Screen Mode** (`full_screen_mode`) provides a full-screen toggle button for
Drupal, giving users a distraction-free, full-screen experience. With a single
click the button switches between the normal view and full-screen mode, hiding
browser chrome so people can focus on the content.

The clever part is that the toggle is implemented as a **Drupal block**. That means
you place it in any region of your theme and control its visibility with the usual
block conditions — by page, role, content type, and so on — and you tune its
appearance from the block's own settings. It uses the browser's native Fullscreen
API, so it works in any modern browser that supports it.

The module depends on core's **Block** module. It affects the viewing experience
only; it has no content or access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no standalone settings page** — all of its options live on the
Full Screen Mode **block's** configuration, described below.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the **Full Screen Mode** block and place it in a region of your theme where
   you want the toggle button to appear.
3. On the block's settings, configure its appearance and placement:
   - **Position** — Top Right, Top Left, Bottom Right, or Bottom Left, plus the
     margin from the page edges.
   - **Button appearance** — stroke color, stroke width, and button size.
   - **Hide on Mobile** — optionally hide the button on small screens to avoid
     clutter.
   - Standard block **visibility** conditions (pages, roles, content types) to
     control where the button shows.
4. Save the block.

The toggle button then appears where you placed it, letting visitors switch between
normal and full-screen viewing. If it does not appear, check that the block is
enabled and in a visible region; if the toggle does nothing, confirm the browser
supports the Fullscreen API.
