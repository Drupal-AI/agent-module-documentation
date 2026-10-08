# CKEditor Break Tag — manual setup guide

**CKEditor Break Tag** (`ckeditor_breaktag`) adds a small button to the CKEditor 5
toolbar that inserts a line break (`<br>`) into your text. Sometimes you want a
paragraph to break onto a new line *without* starting a whole new paragraph — an
address block, a short verse, a signature line. Pressing Enter in the editor
normally creates a new paragraph; this module gives editors a deliberate way to
add a soft line break instead, either by clicking the button or with the keyboard
shortcut **Shift + Enter** (CKEditor 5's built-in soft-break keystroke).

It is a lightweight authoring convenience. It depends only on Drupal core's
CKEditor 5, works on Drupal 10, 11, and 12, and has no settings page of its own.
The one thing to keep in mind is the text format: because the button inserts a
`<br>` tag, the format's "Allowed HTML tags" filter must permit `<br>` or the
filter will strip the break when the content is saved and displayed. Most default
formats already allow it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn the button on
per text format, described under "How to use it" below.

## How to use it

Break Tag adds a toolbar button that you enable for each text format where you
want it:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses CKEditor 5 (for example *Full
   HTML* or *Basic HTML*).
3. In the CKEditor 5 toolbar configuration, drag the **BreakTag** button from the
   *Available buttons* tray up into the *Active toolbar*.
4. Make sure the format's **Allowed HTML tags** include `<br>` so the break
   survives filtering.
5. Click **Save configuration**.

When editing content in that format, click the BreakTag button (or press
**Shift + Enter**) to drop a line break at the cursor.
