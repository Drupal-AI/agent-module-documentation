# ProseMirror — manual setup guide

**ProseMirror** (`prosemirror`) provides a ProseMirror‑based rich‑text editor for
Drupal — a modular, extensible, fully open‑source alternative to CKEditor. Its
distinguishing feature is that it stores content as **structured data (JSON)** rather
than HTML, which makes it especially well suited to headless, decoupled, and
omnichannel publishing: a front‑end app, a native mobile app, an email template, or
digital signage can each map the structured content to its own components instead of
being handed raw HTML.

From an editor's point of view it behaves like any WYSIWYG editor, and it ships with a
default HTML renderer, so you do not have to write custom display code to use it inside
Drupal. It also includes a parser for CKEditor‑created content, so switching a text
format from CKEditor to ProseMirror translates your existing HTML into the structured
format. You can even run CKEditor and ProseMirror on the same site, on different text
formats.

Like every rich‑text editor, ProseMirror's output safety depends on the **text
format's filters**, not on the editor itself. Make sure the format you pair with
ProseMirror restricts the allowed HTML so editors cannot introduce cross‑site scripting
— exactly the same discipline you apply with CKEditor. Beyond its own permission, the
module has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. Like CKEditor, ProseMirror is
attached to a **text format** and configured there — described in "How to use it"
below.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Add or edit a text format (for example, *Full HTML* or a new *ProseMirror* format).
3. Choose **ProseMirror** as the format's **Text editor**, and configure the editor's
   elements and marks for that format.
4. In the same form, set the **allowed HTML tags** / filters so the stored output is
   sanitised for the roles that use the format.
5. Assign the format to the roles that should get the ProseMirror editor, and save.

Any body or long‑text field that offers this text format will now present the
ProseMirror editor.
