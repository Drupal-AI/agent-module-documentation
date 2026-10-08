# CKEditor5 find and replace — manual setup guide

**CKEditor5 find and replace** (`ckeditor5_findandreplace`) adds the native
CKEditor 5 *Find and Replace* feature to Drupal's rich-text editor. Editors get a
familiar, word-processor-style panel to search text within a field and replace a
single match or all of them at once — without leaving the editor. It's ideal for
fixing a repeated typo across a long article or standardising terminology in one
pass.

This is a deliberately thin integration: it simply registers the upstream
CKEditor 5 Find-and-Replace plugin and exposes a **Find and replace** toolbar
button. There is no PHP logic, no settings form, and no permissions of its own.
Because the feature declares that it adds no new HTML elements or attributes,
turning it on never changes the markup stored in your content — it's purely an
editing convenience. All assets ship locally, so nothing is loaded from an
external CDN.

The panel supports the things you'd expect: find, replace, replace-all, "match
case", "whole words only", stepping through matches with a "X of N" counter, and
the `Ctrl+F` / `⌘F` keyboard shortcut to open it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You turn the feature on per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

The feature is enabled per **text format** by adding its toolbar button:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** on a format whose editor is **CKEditor 5** — for example
   *Full HTML*.
3. In the CKEditor 5 toolbar builder, drag the **Find and replace** button from
   *Available buttons* into one of the active toolbar rows.
4. Click **Save configuration**. (If the button doesn't appear right away, clear
   the cache with `ddev drush cr`.)

Repeat for any other formats where you want the feature. Anyone who is allowed to
use that text format gets Find and Replace in the editor — there's no separate
permission. In the editor, editors can click the button or press `Ctrl+F` / `⌘F`
to open the panel.
