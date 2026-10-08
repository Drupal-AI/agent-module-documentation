# CKEditor 5 YouTube — manual setup guide

**CKEditor 5 YouTube** (`ckeditor5_youtube`) adds a **YouTube** button to the CKEditor 5
toolbar. Content authors click it, paste a YouTube URL, and the video is embedded directly
into the rich-text body — as a responsive iframe, or as a lightweight click-to-load
`<lite-youtube>` player. No custom HTML, no fiddling with embed codes.

It is deliberately safe about what it inserts. The iframe's `src` is locked to YouTube hosts
(`youtube.com`, `www.youtube.com`, `m.youtube.com`), so authors can't use this button to drop
in an arbitrary third-party iframe — it only accepts YouTube URLs. You choose which optional
iframe attributes editors are allowed to set (things like `allowfullscreen`, `title`, width
and height, `class`, `referrerpolicy`), and a few legacy/deprecated attributes are turned off
by default. The set of allowed attributes drives both what the editor permits and what the
text format's filter lets through, so embeds survive filtering intact.

Configuration is done **per text format**, not on a global settings page — you enable the
button on whichever CKEditor 5 formats should have it, and the attribute options appear right
there. A bundled `lite-youtube` web component is attached across the site so those lightweight
players render on the front end, and responsive CSS ships with the module so embeds scale with
their container. It depends on core's **CKEditor 5** module, and has no permissions or Drush
commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

The YouTube button is enabled per text format, and that's also where you tune its settings:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and **edit** a format that uses **CKEditor 5** (for
   example *Full HTML* or a custom format).
2. In the toolbar configurator, drag the **YouTube Embed** button from *Available buttons*
   into the *Active toolbar*. Adding the button is what switches the feature on for that
   format.
3. Below the toolbar, the plugin's settings appear as a list of **optional iframe attribute**
   checkboxes:
   `align`, `frameborder`, `height`, `width`, `longdesc`, `name`, `scrolling`, `tabindex`,
   `title`, `allowfullscreen`, `referrerpolicy`, `allow`, and `class`.
   - By default, all of them are enabled **except** the deprecated ones (`align`,
     `frameborder`, `longdesc`, `scrolling`), which are labelled "(deprecated)" and left off.
   - Common ones to keep on: **allowfullscreen** (so videos can go fullscreen) and **title**
     (for accessibility). **class** is special — enabling it whitelists the module's specific
     responsive class values rather than allowing arbitrary classes.
4. **Save** the format.

The allowed-HTML for the format is managed automatically when the button is enabled, so the
`<iframe>`/`<lite-youtube>` markup is not stripped by filtering. Repeat for each format that
should offer YouTube embedding — that per-format toggle is how you decide which authors get
the button.

To embed a video, an author editing content in that format clicks the YouTube button, pastes
the video's URL, and the responsive player is inserted into the body. There is nothing to
configure globally and no permissions to grant beyond the usual "who can administer text
formats" and "who can use the format."
