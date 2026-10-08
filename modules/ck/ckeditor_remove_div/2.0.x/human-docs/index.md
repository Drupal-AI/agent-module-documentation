# CKEditor Remove Div — manual setup guide

**CKEditor Remove Div** (`ckeditor_remove_div`) adds a "Remove Div" button to
CKEditor 5 that lets editors strip out a `<div>` wrapper around their content
without dropping into the HTML source view. Click the button and the `div`
containing the cursor (or its nearest parent `div`) is removed — and, to keep the
markup valid, its content is converted to a paragraph rather than left dangling.

The problem it solves is a small but persistent annoyance. Pasted or imported
content often arrives wrapped in extra `div` containers, and cleaning them up
traditionally means switching to Source mode and editing raw HTML by hand — tedious
and error‑prone for editors who would rather not. This button makes it a one‑click
operation from the normal editing view.

It is a straightforward content‑editing enhancement: output still passes through
the text format's filtering as usual, and it has no content or access‑control role.
It depends only on core **CKEditor 5** and works on Drupal 9, 10, and 11. Note the
module is *minimally maintained*, the current release is a release candidate
(2.0.1‑rc1), and it is **not covered by the Drupal security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   add the button to a text format's toolbar.

There is **no settings page** — the only setup is adding the button to your
CKEditor 5 toolbar, described below and in Installation.

## Where it lives in the admin menu

The module adds no admin configuration page. You add its button per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). Edit a format that uses CKEditor 5, drag the
**Remove Div** button into the toolbar, and save.

## How to use it

With the button on the toolbar, place your cursor inside a `div` in the editor and
click **Remove Div**. The wrapping `div` is removed and its contents become a
paragraph, keeping the HTML valid.
