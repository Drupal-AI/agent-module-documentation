# AI CKEditor CEFR — manual setup guide

**AI CKEditor CEFR** (`ai_ckeditor_cefr`) adds one tool to the AI CKEditor
integration: a button that rewrites selected text to a target **CEFR** language
level. CEFR — the Common European Framework of Reference for Languages — grades
proficiency from A1 (beginner) up to C2 (mastery), so an editor can select a
paragraph and ask the AI to rewrite it at, say, A2 or B1.

That makes it useful whenever you need content at a controlled reading level:
accessibility, plain‑language requirements, or language‑learning material. The
editor stays in CKEditor the whole time — highlight text, pick a level, and the
AI returns a rewrite.

The rewrite runs through your site's configured AI provider, so it uses your
provider credentials and can incur a per‑request cost. This module is a plugin
for AI CKEditor and has no settings page of its own — you turn it on and use it
from the editor toolbar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the tool to a text format.

## How to use it

1. Make sure the [AI](https://www.drupal.org/project/ai) module and **AI
   CKEditor** are installed with a working AI provider.
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a CKEditor‑based text format.
3. Add the CEFR / AI CKEditor tool to that format's toolbar and save.
4. When editing content in that format, an editor selects some text, chooses the
   CEFR tool, and picks a target level (A1–C2); the AI returns the text rewritten
   at that level for the editor to accept.

Depends on **AI CKEditor** (`ai_ckeditor`) and core **Taxonomy**. Works on Drupal
10.4+ and 11.
