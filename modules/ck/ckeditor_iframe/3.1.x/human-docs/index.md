# CKEditor iFrame — manual setup guide

**CKEditor iFrame** (`ckeditor_iframe`) adds an **Iframe Embed** button to the
CKEditor 5 toolbar so editors can insert and edit `<iframe>` embeds — maps,
video players, calendars, booking widgets, dashboards — directly inside a
rich‑text field. Instead of dropping into the source‑HTML view and typing raw
markup, an editor clicks the button, fills in a small form (the iframe URL plus
whatever size/attributes you allow), and the `<iframe>` is placed into the
content.

The button is turned on **per text format**, not site‑wide, and each format
decides which iframe attributes editors may set — beyond the always‑required
`src` you can allow `width`, `height`, `title`, `allowfullscreen`, `name`,
`tabindex`, and a few legacy attributes (`align`, `frameborder`, `longdesc`,
`scrolling`) that are marked *deprecated* and left off by default. That lets you
give a trusted format (say, Full HTML) permissive iframe support while keeping
stricter formats locked down.

One convenience worth calling out: with CKEditor 5 you do **not** have to
hand‑edit the format's "Limit allowed HTML tags" string. The plugin declares its
own allowed‑elements subset, so ticking an attribute box automatically permits
that attribute through the `filter_html` filter — the editor and the allowed‑HTML
filter stay in sync on their own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

CKEditor iFrame has **no global settings page**. Everything is configured on
individual text formats at **Configuration → Content authoring → Text formats
and editors** (`/admin/config/content/formats`).

## How to use it

1. Go to `/admin/config/content/formats` and edit a format whose editor is
   **CKEditor 5** (for example, *Full HTML*).
2. In the CKEditor 5 toolbar configurator, drag the **Iframe Embed** button from
   *Available buttons* up into the active toolbar.
3. A vertical tab named **Allowed optional attributes** appears for the plugin.
   Tick the iframe attributes editors are allowed to set beyond `src` — for
   example `width`, `height`, `title`, and `allowfullscreen`. The four
   *(deprecated)* attributes (`align`, `frameborder`, `longdesc`, `scrolling`)
   are off by default; leave them off for modern, valid HTML. If you add the
   button but never open this tab, the default is every non‑deprecated attribute
   (`height`, `width`, `name`, `tabindex`, `title`, `allowfullscreen`).
4. Click **Save configuration**.

Now, when an editor uses that format, the **Iframe Embed** button is available in
the toolbar. Clicking it opens a form to enter the iframe URL (and any allowed
attributes) and inserts the `<iframe>` into the content. Because the plugin
manages the allowed‑HTML subset itself, you do not need to touch the allowed‑tags
list.

> **Legacy note:** the project also ships an older CKEditor 4 plugin for sites
> mid‑migration. On Drupal 11 with CKEditor 5, the CKEditor 5 plugin described
> above is the one in use. Only on CKEditor 4 (or with a very restrictive filter
> where you are *not* relying on the CKEditor 5 element subset) do you need to
> add `<iframe src longdesc name scrolling title align height frameborder width>`
> to the allowed tags by hand.
