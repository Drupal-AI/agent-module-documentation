# AI CKEditor WCAG — manual setup guide

**AI CKEditor WCAG** (`ai_ckeditor_wcag`) adds a CKEditor 5 tool that lets an
editor prompt the AI to check the content they are writing for **WCAG**
accessibility issues. WCAG (the Web Content Accessibility Guidelines) is the
standard for making web content usable by people with disabilities, and this tool
brings a quick AI review of it right into the editor.

While writing, an editor can ask for accessibility feedback and get AI comments on
things like heading structure, meaningful link text, and image alt text, plus
hints about issues such as contrast — without leaving CKEditor. It's a way to
catch common accessibility problems early, as content is authored.

The check runs through your site's configured AI provider, so it uses your
provider credentials and can incur a per‑request cost. This is a CKEditor plugin
with no settings page of its own — you enable it and add it to a text format's
toolbar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the tool to a text format.

## How to use it

1. Make sure the [AI](https://www.drupal.org/project/ai) module and **AI
   CKEditor** are installed with a working AI provider, and that CKEditor 5 is in
   use.
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a CKEditor 5 text format.
3. Add the WCAG accessibility‑check tool to that format's toolbar and save.
4. When editing content in that format, an editor runs the tool to get AI
   accessibility feedback on the current content and can act on the suggestions.

Depends on core **CKEditor 5**, the **AI** module (`ai`), and **AI CKEditor**
(`ai_ckeditor`). Works on Drupal 10.3+ and 11.
