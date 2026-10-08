# CKEditor 5 Paste Filter — manual setup guide

**CKEditor 5 Paste Filter** (`ckeditor5_paste_filter`) cleans up the messy markup
that comes in when editors paste content into a CKEditor 5 field — typically from
Microsoft Word or Google Docs. It runs the pasted HTML through an ordered list of
**search‑and‑replace regular expressions** before it lands in the editor, so your
content stays clean and consistent without anyone hand‑editing the source.

Technically, the module ships a CKEditor 5 plugin that hooks into the editor's
clipboard pipeline: on every paste it takes the incoming HTML, applies each
configured filter in order, and feeds the cleaned result back into the editor.
Each filter is a JavaScript **regular expression** (the *search* field) plus a
*replace* string. You enter the pattern without delimiters — it's compiled with
the flags `gimsu` (global, ignore‑case, multiline, dot‑all, unicode) — and the
replacement can reference capture groups like `$1`.

The important thing to understand about setup: this is configured **per text
format**, not site‑wide. There's no standalone settings page. You turn it on
inside a text format's CKEditor 5 plugin settings, where a "Paste filter" tab
gives you a **Filter pasted content** checkbox and a draggable table of rules. The
module seeds about 14 sensible default filters that strip common Word/Docs cruft —
`<o:p>` tags, inline `style`/`class`/`face`/`valign` attributes, `<font>` and
`<span>` wrappers, empty `<p>`/`<b>`/`<i>` tags, `&nbsp;`‑only paragraphs, and
Word `OLE_LINK` anchors — and you can add, reorder, disable, or delete them to
suit your needs. All of it saves with the text format's editor config, so it
exports and deploys between environments. Invalid custom regexes are caught on the
client and logged to the browser console rather than breaking the paste.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** — the paste filter is set up per text
format, which is covered in "How to use it" below.

## Where it lives in the admin menu

There's no dedicated admin page. You configure the filter on a text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), inside the **CKEditor 5 plugin settings** for a
format that uses the CKEditor 5 editor.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   (or add) a text format — for example **Basic HTML**.
2. Make sure its **Text editor** is set to **CKEditor 5**.
3. Under **CKEditor 5 plugin settings**, open the **Paste filter** vertical tab.
4. Check **Filter pasted content**. (The plugin does nothing until this is on, and
   the filter table only appears once it's enabled.) When first enabled, it seeds
   the ~14 default cleanup rules.
5. Optionally manage the rules in the table:
   - **Add another filter** to create a new rule with a *search* regex and a
     *replace* string (leave *replace* empty to delete matches; use `$1`, `$2`… to
     keep capture groups).
   - **Drag** rows to change the order they run in.
   - **Uncheck** a row's Enabled box to keep a rule but skip it.
   - **Remove** a rule by clearing *both* its search and replace fields.
6. Click **Save configuration**.

> **Tip:** Because filtering is per text format, you can give different formats
> different rules — say, aggressive cleanup on an editors' format and none on an
> admin format. During a CKEditor 4 → 5 upgrade you can run this alongside the
> older CKEditor Paste Filter module.
