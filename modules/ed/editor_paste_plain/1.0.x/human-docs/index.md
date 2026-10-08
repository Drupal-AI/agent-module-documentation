# Editor Paste Plain — manual setup guide

**Editor Paste Plain** (`editor_paste_plain`) is a small CKEditor 5 plugin that
forces everything pasted into a rich-text field to come in as **plain text** —
the same result you'd get by always pressing Ctrl+Shift+V. When it's on, HTML
markup, inline styles, fonts, colors, and other formatting from Word, Google Docs,
web pages, or marketing emails are stripped on paste, and only the text is
inserted.

You switch it on **per text format**, so you can keep it enabled on a "Basic HTML"
or comments format to keep them clean, while leaving full-formatting pastes
available on another. There is no global settings page and no permissions — it's a
single checkbox on each format's editor configuration. The plugin's JavaScript only
loads on formats where you've ticked the box, so it adds no overhead elsewhere.

Because it removes formatting at paste time rather than filtering it out on save,
it also keeps your content predictable and reduces the amount of stray markup (and
XSS surface) coming in from the clipboard.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated page. You turn the plugin on inside each text format's editor
settings at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

Enable it on any text format that uses the **CKEditor 5** editor:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on a format whose
   editor is CKEditor 5.
2. Scroll down to **CKEditor 5 plugin settings** and open the **Paste as plain
   text** tab.
3. Tick **Force pasting as plain text**.
4. Click **Save configuration**.

That's the whole setup — the plugin has no toolbar button. From then on, every
paste into that format's editor is inserted as plain text. Repeat for each format
where you want the behavior, and leave the box unticked on formats where editors
should keep rich pastes.
