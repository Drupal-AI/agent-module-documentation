# CKEditor Color Button — manual setup guide

**CKEditor Color Button** (`colorbutton`) adds the third-party CKEditor **Color
Button** plugin to Drupal, giving editors toolbar buttons to apply **text color** and
**background color** from the WYSIWYG editor. Internally it registers the `TextColor`
and `BGColor` toolbar buttons for Drupal's editor and lets you restrict editors to a
curated list of colors.

> **Important — this is a CKEditor 4 module.** The plugin targets CKEditor 4, which
> was removed from Drupal core in Drupal 10. It applies only to sites still running
> the contributed CKEditor 4 editor (`core_version_requirement: ^9.3 || ^10`). It is
> **not** for the CKEditor 5 that ships with modern Drupal.

Two setup details are specific to this module. First, the actual JavaScript is **not
bundled** — you download the upstream CKEditor Color Button add-on (at least version
4.5.6) and place it in your site's libraries folder at
`/libraries/colorbutton/plugin.js`; the module implements a status-report check
(`hook_requirements()`) that warns you if the library is missing. Second, it requires
the **Panel Button** module (`panelbutton`), which provides the shared floating-panel
UI the color picker uses.

Configuration is **per text format** through the CKEditor toolbar builder: you drag
the Text Color and/or Background Color buttons into the toolbar, and a settings pane
lets you supply a comma-separated list of allowed hex colors (leave it blank to use
the plugin defaults) and how many colors appear per row. One caveat to know: both
buttons emit inline `style` attributes on `<span>` tags, so they only work in text
formats where "Limit allowed HTML tags" is off, or where `<span style>` is explicitly
allowed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — download the library, install with
   Composer, and enable it with Panel Button.

Configuration is done **per text format** on the CKEditor toolbar (there is no
separate module settings page) — described in "How to use it" below.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a **CKEditor 4** text format.
2. In the toolbar configuration, drag the **Text Color** and/or **Background Color**
   buttons from the available buttons into your active toolbar.
3. In the button's settings pane, optionally enter a **comma-separated list of hex
   colors** to limit editors to an approved palette (leave blank for the plugin's
   defaults) and set the **colors per row**.
4. Make sure this format does **not** strip inline styles — either turn off "Limit
   allowed HTML tags" or explicitly allow `<span style>` — otherwise the colors will
   be filtered out of saved content.
5. Save the format. Editors using it will now see the color buttons in the toolbar.
