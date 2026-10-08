# Simple WYSIWYG — manual setup guide

**Simple WYSIWYG** (`simple_wysiwyg`) adds a minimal rich-text toolbar to plain
string and text fields, giving editors basic formatting — bold, italic, underline,
strikethrough, superscript and subscript — plus a source-view toggle, without pulling
in a full editor like CKEditor.

It works by supplying a field **widget** and a field **formatter** for `string`,
`string_long`, `text` and `text_long` fields. The widget renders an ordinary
textfield or textarea and then, using the browser's `contenteditable` attribute plus
a tiny bit of JavaScript, decorates it with a formatting toolbar. Because it leans on
`contenteditable` rather than a heavy JS editor, it does not slow down page load. You
choose per field which buttons are visible, which HTML tags are allowed, whether the
input is single-line or multiline, and an optional maximum length. The formatter then
renders the stored value on display.

There is no central settings page — everything is configured on each field instance
through Drupal's **Manage form display** and **Manage display** screens. The module
has no dependencies beyond core.

This guide is written for a **human** setting the fields up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Simple WYSIWYG is applied per field, not from a settings page:

1. Go to **Structure → [entity type] → [bundle] → Manage form display**.
2. For a `string`, `string_long`, `text` or `text_long` field, choose the **Simple
   WYSIWYG** widget, then click its gear icon to pick the visible buttons, the
   allowed tags, single-line vs multiline, and a maximum length.
3. Go to **Manage display** and choose the **Simple WYSIWYG** formatter so the stored
   markup renders on the page.

