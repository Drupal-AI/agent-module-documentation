# CKEditor5 Markdown — manual setup guide

**CKEditor5 Markdown** (`ckeditor5_markdown`) adds a **Paste Markdown** button to
the CKEditor 5 toolbar. When an editor clicks it, a dialog opens where they can
paste or type Markdown; on confirmation the Markdown is parsed and inserted into
the editor as formatted HTML. It's a deliberate, on-demand alternative to
clipboard sniffing — editors trigger the conversion intentionally rather than
having the editor guess whether pasted text is Markdown.

The module exists because CKEditor 5's built-in "Paste Markdown" auto-detection is
experimental and unreliable: it doesn't catch every Markdown construct and its
heuristics can clash with other paste plugins (Paste from Office, Paste from
Google Docs, Autoformatting). This module sidesteps all of that with an explicit
button. Conversion is done by the **marked** JavaScript library (GitHub-Flavored
Markdown enabled), which is bundled into the module's compiled asset — you do not
need to install it separately.

One important behavior to understand: **CKEditor 5 only keeps the HTML its active
plugins allow.** This module converts Markdown to HTML, but the editor will
silently drop any element that isn't permitted by your enabled plugins and
allowed-tags settings. For example, `# Heading 1` only becomes an `<h1>` if the
Heading plugin is enabled and `<h1>` is an allowed heading level. Review your
toolbar and plugin configuration so the elements you expect from your Markdown are
actually enabled.

It depends only on Drupal core's CKEditor 5, requires Drupal 10.3+ (or 11/12), and
is covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn the button on per
text format, described below.

## How to use it

First, add the button to a text format:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses CKEditor 5.
3. In the toolbar drag-and-drop area, drag the **Paste Markdown** button into your
   active toolbar.
4. Click **Save configuration**.

Then, when editing content:

1. Place the cursor where you want the content inserted.
2. Click the **Paste Markdown** button.
3. Paste or type Markdown in the dialog.
4. Click **Insert** — the Markdown is converted to HTML and inserted at the cursor.
   Press Escape or click outside the dialog to cancel.
