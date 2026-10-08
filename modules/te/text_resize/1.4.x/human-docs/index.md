# Text Resize — manual setup guide

**Text Resize** (`text_resize`) gives your visitors a small on‑page control — an
"A‑" / "A+" pair of links, plus an optional reset link — that lets them make the
text on a page bigger or smaller. It is a lightweight accessibility helper: rather
than relying on browser zoom shortcuts that many people don't know about, you place
a visible widget where readers can enlarge the text with a click. The chosen size is
remembered client‑side by the module's JavaScript, so it sticks as the visitor moves
around.

The whole feature is a single block. Once the module is enabled you place the **Text
Resize** block (machine name `text_resize_block`) in any region — a header, a sidebar,
an accessibility toolbar — using the normal Block Layout screen. A short settings form
lets you decide *which* part of the page gets resized (a CSS selector, default `main`),
the smallest and largest font sizes allowed, whether to show a reset link, and whether
line height should grow along with the text.

Text Resize depends only on Drupal core's Block system — there are no third‑party
libraries, no submodules, and no Drush commands. It works on Drupal 8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — place the block and tune the resize
   settings (scope, min/max size, reset button, line height), field by field.

## Where it lives in the admin menu

Two places matter. The settings form sits at **Configuration → User interface → Text
Resize** (`/admin/config/user-interface/text_resize`), guarded by the *administer
text_resize* permission. The block itself is placed from **Structure → Block Layout**
(`/admin/structure/block`), where it appears in the block list as "Text Resize".

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Place the **Text Resize** block in a visible region via Block Layout.
3. Optionally open the settings form to change what gets resized and the size limits.

That's it — visitors will see the "A‑ / A+" links and can resize the text immediately.
