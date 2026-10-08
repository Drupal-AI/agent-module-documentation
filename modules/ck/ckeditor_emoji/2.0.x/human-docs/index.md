# CKEditor(5) Emoji — manual setup guide

**CKEditor(5) Emoji** (`ckeditor_emoji`) adds an **Emoji** button to the CKEditor 5
rich-text toolbar. Click it and a picker opens with a search box, a category strip,
and a scrollable grid of emoji — pick one and it drops into your text at the
cursor. It gives content authors a familiar emoji-picker experience right inside
Drupal's editor, so they can add 😀, ⭐, ✅ or 🚀 without copy-pasting from another
app or hunting for Unicode code points.

The module is deliberately tiny. It is a self-contained CKEditor 5 JavaScript
plugin with **no PHP** — no settings form, no permissions, no configuration object.
Its only footprint on your site is the toolbar button it contributes, which you
switch on per text format. It depends only on Drupal core's **CKEditor 5** module,
and it works exclusively with CKEditor 5 (it is the modern successor to the old
CKEditor 4 "Emoji" module).

Because the picker inserts each emoji as a plain **Unicode character** — not custom
markup — you don't need to change any text-format filters or allowed HTML tags. The
emoji is simply text, so it renders anywhere the browser and operating-system font
support it, and removing the button later is as easy as dragging it out of the
toolbar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You turn the button on where you configure
text editors: **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

Adding the Emoji button to a text format is the whole setup:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses **CKEditor 5** as its editor
   (for example *Full HTML*). If a format is still on CKEditor 4 or has no editor,
   the emoji button won't be available for it — this module is CKEditor 5 only.
3. In the editor configuration, find the 🙂 **Emoji** button in **Available
   buttons** and drag it into the **Active toolbar** where you want it (you can drop
   it inside a toolbar group if you like).
4. Click **Save configuration**.

Anyone who edits content with that text format now sees the Emoji button. Clicking
it opens the picker, which offers:

- A **search box** — type a name like "heart" or "rocket" to filter the grid.
- A **category strip** — Smileys & People, Animals & Nature, Food & Drink,
  Activity, Travel & Places, Objects, Symbols, and Flags, plus an "All" view.
- A **grid of emoji** with the hovered emoji's name shown below.

Selecting an emoji inserts it as normal text at your cursor. To remove the feature
from a format later, just drag the Emoji button out of the active toolbar and save.

A couple of things worth knowing:

- **No permission is involved.** The button is available to anyone who can use the
  text format — there is nothing extra to grant.
- **No allowed-tags change is needed.** Since the emoji is plain Unicode text, it
  works even on restrictive formats without editing their HTML filter.
