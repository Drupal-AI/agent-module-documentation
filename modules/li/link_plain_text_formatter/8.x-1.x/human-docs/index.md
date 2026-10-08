# Link Plain Text Formatter — manual setup guide

**Link Plain Text Formatter** (`link_plain_text_formatter`) adds a field formatter
that renders a core Link field as **plain text** — the URL (or title) as
characters — rather than as a clickable anchor element.

Core's built‑in Link formatters always produce a link, which is exactly right for
a web page and wrong nearly everywhere else a field gets rendered. Plain‑text
email has no anchors; a CSV export wants the URL in a cell, not `<a href>`; a JSON
feed, a print stylesheet, an SMS, a QR‑code source, or an `alt` attribute all want
the string, not markup. Without a plain formatter the usual workaround is a Views
field rewrite or a template override for each case — a lot of ceremony just to
"show the text". This module adds the formatter and does exactly that one thing.

> **One point of care.** Stripping the anchor does not make a URL safe in every
> context. A `javascript:` URI is inert as text on a page but dangerous the moment
> something re‑links it, and a URL in a CSV cell beginning with `=`, `+`, `-`, or
> `@` is a spreadsheet formula‑injection vector. That escaping belongs to whatever
> *consumes* the string — but a plain‑text formatter is where those strings begin
> their journey, so keep it in mind for exports and downstream rendering.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable, and
   select the formatter.

There is **no configuration page** for this module. You choose the plain‑text
formatter per link field on **Manage display**, described below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage display**, where you pick the plain‑text Link formatter for
a link field. It is especially useful on text‑only view modes.

## How to use it

1. Enable the module.
2. Go to the **Manage display** page for a content type (or other entity) that has
   a link field — commonly on a dedicated plain‑text or export view mode.
3. In the **Format** column for that link field, choose the plain‑text Link
   formatter and save.

The link now renders as plain text (the URL, or the title where present) instead
of a clickable anchor.
