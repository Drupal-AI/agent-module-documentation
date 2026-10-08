# CKEditor 5 Tooltip — manual setup guide

**CKEditor 5 Tooltip** (`ckeditor_tooltip`) adds an accessible **tooltip widget**
to the CKEditor 5 toolbar. An editor selects some text, clicks the **Tooltip**
button, fills in a modal dialog (built on Drupal's own modal system), and the
selection becomes a dashed-underline anchor that shows a styled popup on hover,
click, or keyboard focus — no shortcodes, no custom field types, and no external
libraries.

What makes it stand out is how much control lives inside that dialog. It ships
**ten style themes** (Dark, Light, Info, Success, Warning, Danger, Glass,
Bordered, Custom, and None), a **live preview** that updates as you type, and
per-instance control over colour, typography, size, corner radius, shadow,
opacity, trigger (hover vs click/tap), position, max width/height, entrance
animation, and show/hide delays. The tooltip content field accepts plain text or a
generous set of limited HTML (bold, italic, links, images, headings, lists, code,
blockquotes, and more), with a live character counter against a 2,000-character
limit and automatic fixing of broken tags. Editing an existing tooltip reopens the
dialog pre-populated, and a one-click **Remove Tooltip** strips it back to plain
text.

The module depends only on core's CKEditor 5 module and provides its own
permission. All the appearance and behaviour options are chosen **per tooltip** in
the dialog rather than on a central settings form — so the main setup is enabling
the plugin per text format and granting the permission, both covered in the
configuration guide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable the plugin per text format,
   grant the permission, and an overview of the per-tooltip options editors get.

## Where it lives in the admin menu

CKEditor 5 Tooltip has no central settings page. You enable it per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and grant its permission at **People →
Permissions** (`/admin/people/permissions`). Everything else is chosen per tooltip
in the editor's modal dialog.
