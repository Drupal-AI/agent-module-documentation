# BUEditor — manual setup guide

**BUEditor** (`bueditor`) is a lightweight, fully customizable text editor for
Drupal. Rather than the fixed feature set of a big WYSIWYG like CKEditor, BUEditor
lets you build your own editors, toolbars, and buttons — code snippets, HTML
templates, keyboard shortcuts — tuned to whatever markup your team writes, whether
that's HTML, Markdown, Textile, or something else. It is a good fit when you want a
fast source editor with exactly the buttons you choose, and nothing you don't.

BUEditor attaches through Drupal's core **Editor** framework, so you pick a BUEditor
instance **per text format** (the same place you would otherwise choose CKEditor). It
stores its configuration as exportable config entities: a **BUEditor Editor**
(`bueditor_editor`) holds a toolbar's item list and settings, and a **BUEditor
Button** (`bueditor_button`) defines a reusable button with a label, tooltip, CSS
class, keyboard shortcut, code to insert, and any libraries it needs. Because these
are config entities, you can move editor and button definitions between environments
like any other config.

Everything is managed from one admin section, **Configuration → Content authoring →
BUEditor** (`/admin/config/content/bueditor`), behind the trusted **Administer
BUEditor** permission. A second permission, **Access AJAX preview**, controls a live
"Preview" button that renders the editor's content through its text format. BUEditor
is also extensible in code through a `bueditor_plugin` plugin type, which is how the
bundled standard buttons and the AJAX preview button are supplied.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — creating editors and buttons,
   assigning an editor to a text format, the permissions, and the global settings.

## Where it lives in the admin menu

The admin UI is at **Configuration → Content authoring → BUEditor**
(`/admin/config/content/bueditor`) — a list of editors, a `/buttons` list of buttons,
and a `/settings` form. You attach a BUEditor to actual text areas from
**Configuration → Content authoring → Text formats and editors**.

## How to use it

Create (or tweak) a BUEditor editor and its buttons under **Configuration → Content
authoring → BUEditor**, then go to **Text formats and editors**, edit the text format
your authors use, and choose **BUEditor** as its text editor. From then on, any field
using that format shows your custom toolbar. See
[Configuration](configuration/index.md) for the full walkthrough.
