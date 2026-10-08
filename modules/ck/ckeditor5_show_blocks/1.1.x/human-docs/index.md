# CKEditor 5 Show Blocks — manual setup guide

**CKEditor 5 Show Blocks** (`ckeditor5_show_blocks`) adds a "Show blocks"
toggle to CKEditor 5. When an editor turns it on, every block-level element in
the editing area is drawn with an outline and labelled with its HTML tag name in
the top-left corner of the box — so you can *see* the structure of the content
you are writing, not just how it looks.

A WYSIWYG editor is very good at hiding what content really is. A "heading" that
is actually a bold, oversized paragraph looks like a heading but is invisible to
a screen reader's heading navigation, missing from any table of contents, and
worthless to search. Empty paragraphs used as spacers, two separate lists that
look like one nested list, and a blockquote that is really just an indented
paragraph are all easy to create by accident and impossible to spot at a glance.
Show Blocks makes all of it visible in the one place it can be fixed cheaply: the
editor.

Think of it as a *view mode* rather than a setting you leave on — the outlines
take up space and distract from writing, so its value is being available the
moment structure is in question (accessibility remediation, cleaning up content
pasted from Word, checking a migrated article). It shows structure, not
correctness: it will show you that a heading is an `h3`, but whether that skips a
level from the `h1` above it is still your judgement, so it pairs naturally with
an accessibility checker rather than replacing one. The module works the moment
you enable it and add its toolbar button; there is nothing to configure. It runs
on Drupal 10 and 11 and needs only core's CKEditor 5.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You switch it on per text
format by adding its toolbar button, described below.

## How to use it

Show Blocks adds a toolbar button to CKEditor 5 that you enable per text format:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** on the format whose editor you want the button in (for
   example *Full HTML*).
3. In the CKEditor 5 toolbar configuration, drag the **Show blocks** button from
   the *Available buttons* tray up into the *Active toolbar*.
4. **Save configuration**.

Now, when you edit content with that format, click the Show blocks button to
outline and label every block-level element. Click it again to turn the outlines
back off and return to normal writing.
