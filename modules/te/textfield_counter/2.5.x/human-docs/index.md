# Textfield Counter — manual setup guide

**Textfield Counter** (`textfield_counter`) gives Drupal's text fields and text
areas a **live character counter** that counts down as an editor types, and can
enforce a maximum length when the form is submitted. It's the classic "280
characters remaining" experience — useful for tweet-style fields, meta
descriptions, SMS bodies, or anything that has to fit a downstream limit.

It works as a set of drop-in **widget** replacements. The module ships five
widgets, each extending the matching core text widget and adding the counter, so
you simply pick one on a field's *Manage form display* screen — there is **no
global settings page** (all options live on the field's widget). Each widget shows
a running count and, by default, blocks submission when the value goes over the
limit; you can also switch to a "count only" mode that shows the counter without
enforcing it.

The five widgets cover plain text fields and text areas as well as formatted
(CKEditor) fields and the "text with summary" field, so almost any text field can
have a counter. Per field you can set the maximum length, where the counter sits
(before or after the input), whether to also block submission client-side, whether
to count the HTML markup (turn this off for rich-text/CKEditor fields), and the
wording of the counter message. Textfield Counter depends on core's **Text**
module, requires **PHP 8.1+**, has no permissions or Drush commands, and stores
everything as ordinary field-display config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including every widget
setting and the reusable trait for building your own counter widget — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page. Textfield Counter appears as widget choices on
the **Manage form display** screen of any entity with text fields — for example
**Structure → Content types → [your type] → Manage form display**.

## How to use it

1. Go to the **Manage form display** screen for the bundle whose field you want to
   add a counter to (content type, taxonomy, media, and so on).
2. Find your text field and, in the **Widget** column, choose the counter widget
   that matches its type — for example *Textfield with counter* for a plain text
   field, or *Textarea (multiple rows) with counter* for a long text or CKEditor
   field. Only the widget matching the field's type appears in the dropdown.
3. Click the widget's gear icon to open its settings and configure:
   - **Maximum number of characters** — the limit. **Set it to `0` to disable the
     counter** while keeping the widget.
   - **Counter position** — show the counter **after** (default) or **before** the
     input.
   - **Prevent submit** (`js_prevent_submit`) — also block submission in the
     browser, on top of the server-side check.
   - **Count only mode** — show the counter but never block submission; the limit
     becomes informational.
   - **Count HTML characters** — include markup/tags in the count. **Uncheck this
     for CKEditor / formatted fields** so only the visible text is counted.
   - **Textcount status message** — customize the wording, using the `@maxlength`,
     `@current_length`, and `@remaining_count` tokens. (Keep those tokens wrapped
     in their `span` classes so the live counter can update them.)
   - Plain-text field widgets also offer **Use field maxlength** to reuse the
     field's configured storage length as the limit; the summary widget adds a
     separate limit and counter for the summary.
4. Click **Update**, then **Save**.

The real enforcement happens server-side: if a submitted value exceeds the maximum
length, the form is rejected with an error — unless *count only mode* is on. Each
value of a multi-value field gets its own counter.
