# Embed — manual setup guide

**Embed** (`embed`) is a low-level *framework* that lets other modules add
**embed buttons** to the CKEditor toolbar, so content authors can drop rich
objects — entities, media, tweets, and the like — straight into formatted text.
On its own it provides no ready-made embeds you can click. Instead it defines the
shared plumbing that modules such as **Entity Embed** and **Media** build on:
an `embed_button` configuration entity (an icon, an embed *type*, and its
settings) that shows up as a button in a text format's toolbar and opens a dialog
for choosing what to insert.

Because it is purely a framework, Embed is almost always installed as a
**dependency of another module** rather than used by itself. This guide is written
for a **human** clicking through the admin UI: it shows you how to install Embed,
find the Embed buttons screen, and understand what an embed button entity holds so
you can add one and wire it into an editor. If you are looking for terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Embed buttons list under Configuration → Content authoring](images/buttons.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Content authoring → Embed
buttons** (`/admin/config/content/embed`). That page has two tabs:

- **List** (`/admin/config/content/embed`) — every embed button defined on the
  site, with an **+ Add embed button** button.
- **Settings** (`/admin/config/content/embed/settings`) — the file scheme and
  upload directory used to store button icons.

## Contents

1. [Installation](installation/index.md) — install Embed with Composer and enable
   it (usually alongside a consumer module like Entity Embed).
2. [Configuration](configuration/index.md) — the Embed buttons list, what an embed
   button entity holds, how to add one, and how to enable it in a text format's
   CKEditor 5 toolbar.
