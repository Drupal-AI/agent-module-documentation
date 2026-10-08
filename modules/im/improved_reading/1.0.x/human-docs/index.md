# Improved reading — manual setup guide

**Improved reading** (`improved_reading`) changes how text is displayed to help
people read faster, using a method inspired by Bionic Reading. It adds a bolder
style to the leading characters of each word — the eye latches onto those first
letters and skips ahead, so reading feels quicker. The effect is applied to page
text, and visitors turn it on or off for themselves with a toggle button you place
on the site.

It is an accessibility and readability aid rather than a content feature. Because
the point is to help *readers*, you can grant the "use" permission to anonymous
users so everyone benefits, and the effect is toggleable per visitor so nobody is
forced into it.

Setting it up is a short sequence: enable the module, grant the use permission
(including to anonymous users if you want it available to everyone), turn the
feature on and adjust it in the settings form, and place the toggle button block in
a region of your theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — grant permissions, turn on and tune
   the effect, and place the toggle button block.

## Where it lives in the admin menu

Improved reading is controlled from three familiar places: its **settings form**
(under **Configuration**), the **Permissions** page at **People → Permissions**
(`/admin/people/permissions`), and the **Block layout** page at **Structure →
Block layout** (`/admin/structure/block`) where you place the toggle button.
