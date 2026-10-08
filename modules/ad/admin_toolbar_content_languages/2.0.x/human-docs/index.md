# Administration Toolbar - Content languages — manual setup guide

**Administration Toolbar - Content languages** (`admin_toolbar_content_languages`)
adds a **language dropdown** to the Admin Toolbar so editors on a multilingual site
can start creating content in a specific language straight from the toolbar. For
content types that default to the current language, it lists the available languages
as menu items — so instead of creating content and then switching language, an editor
can pick the target language up front from the toolbar's "add content" area.

It is a convenience for multilingual content creation and nothing more: it respects
your existing content‑creation permissions (editors only see what they may create)
and has no access‑control role of its own. It builds on Admin Toolbar and its Tools
submodule, adding the language menu items into the expanded toolbar menus they
provide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, and
   enable it alongside Admin Toolbar and Admin Toolbar Tools.

## Where it lives in the admin menu

There is no settings form. Once enabled, the language dropdown appears in the Admin
Toolbar's content/"add content" area automatically for the content types it applies
to.

## How to use it

1. Make sure Admin Toolbar and Admin Toolbar Tools are enabled, then enable this
   module (see [Installation](installation/index.md)).
2. In the Admin Toolbar, open the "add content" area. For content types that default
   to the current language, you'll see a dropdown of the available languages.
3. Pick a language to start creating content in that language directly.

This speeds up multilingual editing; the languages shown come from the site's
configured languages, and what an editor can create still follows their normal
content‑creation permissions.
