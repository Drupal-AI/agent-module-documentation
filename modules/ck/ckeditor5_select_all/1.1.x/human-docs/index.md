# CKEditor 5 Select All — manual setup guide

**CKEditor 5 Select All** (`ckeditor5_select_all`) adds a **Select All** button —
and a scoped **Ctrl/Cmd + A** shortcut — to CKEditor 5. It solves a familiar
frustration: pressing Ctrl/Cmd + A inside an editor field normally triggers the
browser's native select-all, grabbing menus, sidebars, and other fields along with
your text. This module scopes the action to the focused editor instance only, so
"select all" means all the content *in that field* and nothing else.

That makes several everyday tasks cleaner: selecting everything to replace it in
one keystroke, copying a full body field without accidentally grabbing surrounding
page elements, clearing a field in one step, or applying a style to the whole
document at once. It's also a win for keyboard-first, accessibility-focused
editing, and it gives consistent behaviour across operating systems and browsers.

It's a zero-configuration CKEditor 5 plugin — implemented as a pure YAML plugin
with no custom PHP, no settings form, and no extra libraries or build step. You
enable it and place the button on the text formats where you want it. It requires
PHP 8.1+ and Drupal 10 or 11, and CKEditor 5 is bundled with core so there's
nothing separate to install. The module is not covered by Drupal's security
advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn the button on per
text format, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to the format you want (for example *Basic HTML* or
   *Full HTML*).
3. In the CKEditor 5 toolbar drag-and-drop area, find **Select All** in *Available
   toolbar items* and drag it into your active toolbar.
4. Click **Save configuration**.

The button is immediately available to anyone who can use that text format — no
cache rebuild needed. When editing, click **Select All** (or press Ctrl + A on
Windows/Linux, Cmd + A on macOS) and everything inside that editor field is
selected, ready to copy, replace, format, or delete.
