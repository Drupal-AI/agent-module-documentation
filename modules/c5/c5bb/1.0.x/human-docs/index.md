# CKEditor 5 Bootstrap Buttons — manual setup guide

**CKEditor 5 Bootstrap Buttons** (`c5bb`) adds a **Bootstrap Buttons** toolbar button
to CKEditor 5, so editors can turn a link into a styled, Bootstrap-style button — a
call-to-action like `btn btn-primary` — without hand-editing HTML source. You decide,
per text format, which class options editors get to choose from (size, style, colour,
and any custom groups you define), and optionally give them an icon picker
(Glyphicon / Font Awesome) for the button.

It ships a single CKEditor 5 plugin and depends only on core's **CKEditor 5** module.
There are no permissions and no Drush commands. Because it's a CKEditor plugin, there
is **no separate site-wide settings page** — you enable and configure it per text
format, in the same place you build any CKEditor 5 toolbar.

One honest caveat worth flagging: **the module does not ship Bootstrap's button
CSS.** It injects a small stylesheet so the buttons *preview* correctly inside the
editor, but the actual button styling on the front end has to come from your theme
(or a Bootstrap base). If your theme already uses Bootstrap button classes, the
buttons editors create will just work; if not, you'll need to provide the matching
CSS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enabling the toolbar button on a text
   format and its three settings (Class Selectors, Text Class, Show Icon Settings).

## Where it lives in the admin menu

There's no page of its own. You add the **Bootstrap Buttons** button to a format's
CKEditor 5 toolbar at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and its settings appear as a vertical tab under the
toolbar there.

## How to use it

Enable the module, then on a text format that uses CKEditor 5, drag the **Bootstrap
Buttons** item into the active toolbar and set up the class options editors can pick
from. After that, editors select a link in the editor, click the Bootstrap Buttons
button, and choose a size/style/colour (and icon) to style it. See
[Configuration](configuration/index.md) for the details.
