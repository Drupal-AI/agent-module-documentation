# Editor Advanced Image — manual setup guide

**Editor Advanced Image** (`editor_advanced_image`) adds a CKEditor 5 plugin that
lets content authors set the `title`, `class`, and `id` HTML attributes on inline
images, and optionally applies a default CSS class to every image they insert. It
brings back — for CKEditor 5's image balloon toolbar — the kind of advanced image
control editors had in the old CKEditor 4 image dialog.

When enabled on a text format, it adds an "Editor Advanced Image" button to the
image balloon toolbar. An author who selects an image and clicks the button gets a
small form to edit exactly the attributes an administrator allowlisted for that
format — a `title` (tooltip / accessibility hint), one or more CSS `class` values,
and/or a unique `id` (handy for in‑page anchors and tables of contents). You can
also set a default class, such as `img-fluid` or `img-responsive`, that is applied
automatically to every newly inserted image, which is a simple way to keep
editorial images on your theme's house style.

Configuration is **per text format** — there is no separate admin page. Which
attributes are offered, whether the balloon button appears at all, and the default
class are all set on the CKEditor 5 configuration for each format, and stored in
that format's editor config so it exports and imports cleanly. Behind the scenes
the plugin declares `<img title class id>` so those attributes survive Drupal's
allowed‑HTML filtering, and it only loads when the core image plugin is enabled on
the toolbar.

This guide is written for a **human** using the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You configure it per format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), inside each CKEditor 5 format's plugin
settings.

## How to set it up on a text format

1. Make sure the format uses **CKEditor 5** and has the core **Image** button in
   its active toolbar — the advanced‑image plugin will not load without it.
2. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format.
3. Find the **Editor Advanced Image** section under the CKEditor 5 plugin
   settings and set:
   - **Enabled attributes** — tick which attributes editors may edit: **Title**,
     **CSS classes**, and/or **ID**. (Only these three are supported; the default
     is just *class*.)
   - **Default image class(es)** — a class automatically added to every newly
     inserted image (for example `img-fluid`). Leave empty for none.
   - **Disable Balloon** — tick this to hide the advanced‑image button entirely on
     this format, while still applying the default class.
4. Save the format.

You can give different formats different attribute sets — for example a full‑HTML
format that exposes all three attributes and a basic format that exposes only
`class`. Enabling an attribute also adds it to the format's allowed‑HTML tags, so
the values authors set are not stripped by the filter system.
