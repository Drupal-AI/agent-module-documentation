# CKEditor 5 Pre — manual setup guide

**CKEditor 5 Pre** (`ckeditor5_pre`) adds support for the `<pre>` (preformatted)
tag and makes it available as an option in CKEditor 5's **Heading** dropdown. When
you apply it to text, the editor shows basic visual styling — a monospace font and
a background — so you can see at a glance that the content is preformatted. It's a
simple way to give editors preformatted blocks without adding a separate toolbar
button.

Unlike most CKEditor plugins here, it doesn't add a button you drag onto the
toolbar — once the module is enabled, `<pre>` is added to the Heading list
automatically. It depends only on Drupal core's CKEditor 5, runs on Drupal 10 and
11, and is covered by Drupal's security advisory policy.

Two things to know. First, if a text format has **"Limit allowed HTML tags and
correct faulty HTML"** enabled (as *Basic HTML* does), you need to **re-save that
text format** once so `<pre>` is added to its allowed-tags list. Second, a
limitation: the plugin works reliably when the `<pre>` block wraps plain text or
single-level tags; wrapping multiple block-level elements or deeply nested markup
may give unexpected results.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — but you may need to re-save
your text format, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The `<pre>`
   option is added to CKEditor 5's **Heading** dropdown automatically — there is no
   toolbar button to place.
2. If the text format uses **"Limit allowed HTML tags and correct faulty HTML"**
   (for example *Basic HTML*), go to **Configuration → Content authoring → Text
   formats and editors** (`/admin/config/content/formats`), open that format, and
   click **Save configuration** once. This adds `<pre>` to the allowed-tags list so
   preformatted content survives filtering.
3. When editing content, select your text, open the **Heading** dropdown, and
   choose the preformatted option. Keep the contents to plain text or simple,
   single-level markup for reliable results.
