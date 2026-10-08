# Announcement Modal — manual setup guide

**Announcement Modal** (`announcement_modal`) shows a single site‑wide
announcement to your visitors as a modal (a pop‑up overlay). You write the
announcement once in an admin form, switch it on, and every visitor sees it when
a page loads — handy for a temporary notice such as scheduled maintenance, a
promotion, or a policy update.

There is one announcement at a time and one place to edit it. The module stores
the announcement text and an on/off toggle in configuration, and ships a small
CSS/JS library that opens and closes the modal in the browser. It also provides a
**block** so you can decide where on the page the modal is rendered.

Because the content is written by an administrator, treat whatever markup you
enter as trusted — it is shown to everyone as‑is. The module adds no public
pages of its own beyond the admin settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — write the announcement, toggle it on,
   and place the block.

## Where it lives in the admin menu

The settings form is at **Configuration → Announcement Modal**
(`/admin/config/announcement_modal`). It requires the *Administer site
configuration* permission, and the module also provides an *Administer
announcement modal configuration* permission so you can delegate managing the
notice to editors without giving them full site‑configuration access.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the settings form, enter your announcement, and switch it on.
3. Place the **Announcement** block in a region (for example the header or
   content area) from **Structure → Block layout** so the modal actually renders.

The settings page is marked "no cache", so edits appear immediately. You can turn
the announcement off again from the same form without removing the block.
