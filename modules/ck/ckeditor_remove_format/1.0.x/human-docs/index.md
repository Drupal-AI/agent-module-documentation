# CKEditor Remove Format — manual setup guide

**CKEditor Remove Format** (`ckeditor_remove_format`) provides a single **text-format
filter** called **Remove Format Filter**. When you enable it on a text format, it
strips **all HTML tags** out of the content when that content is rendered, leaving
plain text.

A word on expectations: despite the project name and its README (which talk about
"CKEditor 5's Remove Format plugin" and removing format "on save"), the module does
**not** add a toolbar button, ship any JavaScript, or touch the CKEditor 5 editor at
all. Everything it does is a server-side output filter that runs `strip_tags()`. It
is also coarse — it removes *every* tag, not just inline bold/italic — so enabling it
effectively flattens a format's rendered output to plain text.

The realistic use case is a text format whose output you always want reduced to plain
text (for example, a stripped-down format used for imported or pasted-in content where
you never want any markup to survive). If you only want editors to be able to clear
formatting from a selection, note that CKEditor 5 already includes its own built-in
**Remove Format** toolbar button in core — this module is not needed for that.

It is a content-rendering feature with **no access-control role**, no settings, no
dependencies, and works on Drupal 10.1 and 11. Note the project is maintained for
fixes only and is **not covered by the Drupal security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and turn on the Remove Format Filter for a text format.

There is **no separate settings page** and the filter has **no options** — setup is
simply enabling the filter on the text format(s) you want. That is covered in
Installation.

## Where it lives in the admin menu

The module adds no admin configuration page. You enable its filter per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`): edit a format and tick **Remove Format Filter** in
its **Filters** list.

## How to use it

Enable the **Remove Format Filter** on a text format. From then on, content rendered
through that format has all HTML tags removed automatically — you do not click
anything per-edit, and there is nothing to configure. Because it removes all markup,
use it only on formats whose output you genuinely want reduced to plain text, and mind
the filter order relative to other filters on the format.
