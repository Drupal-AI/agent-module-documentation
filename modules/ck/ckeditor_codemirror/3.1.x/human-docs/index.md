# CKEditor CodeMirror — manual setup guide

**CKEditor CodeMirror** (`ckeditor_codemirror`) upgrades CKEditor 5's **Source**
view. Normally, when an editor clicks the Source button to edit raw HTML, they get
a plain textarea. This module swaps that textarea for a **CodeMirror** editor —
giving them syntax highlighting, line numbers, bracket and tag matching, code
folding, and a search bar, so editing raw markup is far less error‑prone and much
easier to read.

It's a boon for anyone who occasionally drops into Source view to fix an embed,
inspect an iframe, or clean up pasted markup — structure becomes visible, matching
tags light up, and you can fold long blocks out of the way. You can even switch the
highlighting **mode** to CSS, SCSS, PHP, or JavaScript for formats used to edit
those kinds of snippets.

Everything is configured **per text format**, layered on top of core's Source
editing button — there's no site‑wide settings page. On each format you turn
CodeMirror on, choose the highlighting mode, and toggle nine display options
(auto‑close brackets and tags, folding, line numbers, line wrapping, bracket and
tag matching, the search bar, and active‑line highlighting). So you can give a
"Developer" format the full treatment while leaving *Basic HTML* untouched.

> **Requires two JavaScript libraries.** Unlike the icon or template plugins, this
> module needs the **CodeMirror 5** library and a small bridge library to be
> installed in your site's `libraries/` folder. It will not highlight anything
> until they're present — see [Installation](installation/index.md). (Note:
> CodeMirror **6** is not supported; it must be version 5.)

Because there's no global settings page (`configure: null`), this guide has no
separate configuration page; the "How to use it" section below covers the setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   install the two required JS libraries, and enable it.

## Where it lives in the admin menu

CKEditor CodeMirror adds **no admin page of its own**. You configure it while
editing a text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`). You can confirm the required
libraries are detected on the status report at **Reports → Status report**
(`/admin/reports/status`).

## How to use it

1. Go to **Text formats and editors** (`/admin/config/content/formats`) and
   **Configure** a format whose editor is **CKEditor 5** (for example *Full HTML*).
2. Make sure the **Source** button is in the *Active toolbar* — this is a
   prerequisite. Without it, the CodeMirror settings tab won't appear and the
   plugin won't load.
3. Open the **CodeMirror source editing** tab under the CKEditor 5 plugin settings
   and:
   - Tick **Enable CodeMirror source view syntax highlighting**.
   - Pick a **Mode** — HTML (including CSS, XML and JavaScript), HTML only, PHP,
     JavaScript only, CSS, or SCSS.
   - Adjust the **additional settings** checkboxes (line numbers, folding, line
     wrapping, bracket/tag matching, search bar, active‑line highlight, auto‑close
     brackets and tags). Turn off any you find distracting for a minimal view.
4. **Save configuration**.

Now, when an editor using that format clicks the **Source** button, they get the
highlighted CodeMirror editor instead of a plain textarea.
