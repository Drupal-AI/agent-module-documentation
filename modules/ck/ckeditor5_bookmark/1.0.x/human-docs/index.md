# CKEditor 5 Bookmark — manual setup guide

**CKEditor 5 Bookmark** (`ckeditor5_bookmark`) switches on the native **Bookmark**
(anchor) button that already ships inside Drupal core's CKEditor 5 but is left
turned off. With it enabled, editors can drop named anchor points into rich‑text
content straight from the toolbar — the modern replacement for the old CKEditor 4
"anchor" workflow — so you can build in‑page "jump to" links, tables of contents,
and skip‑to‑section targets without editing the HTML source by hand.

Under the hood there is almost nothing to the module: it has no PHP code, no
services, no permissions, and no settings of its own. Drupal core 10.4 / 11.1
bundles the CKEditor 5 bookmark plugin but never registers it as a toolbar item;
this module supplies that missing registration and, importantly, whitelists the
`<a id>` element so your bookmark anchors survive text‑format filtering instead of
being stripped out. It depends on core's **CKEditor 5** module.

Because it is pure glue, there is no settings page. You "configure" it the same way
you configure any CKEditor button — by dragging it into the toolbar of the text
formats where you want it. That per‑format step is described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You enable the button per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors** and edit
   a CKEditor 5–based format, for example **Full HTML**.
3. In the toolbar configurator, drag the **Bookmark** icon from *Available buttons*
   up into the *Active toolbar*.
4. Click **Save configuration**. Editors using that format now see a Bookmark
   button; clicking it lets them insert, edit, or remove a named anchor
   (`<a id="…">`) through CKEditor's own dialog.

Enable the button only on the formats that actually need it (for example your
long‑form article format) to keep other toolbars uncluttered. When you add the
button, the module automatically allows the `<a id>` element in that format, so the
*Limit allowed HTML tags* filter won't remove your anchors. Other links — menus,
fields, or a table of contents — can then point at those anchors with a normal
`#id` fragment.
