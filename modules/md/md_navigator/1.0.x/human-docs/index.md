# MD Navigator — manual setup guide

**MD Navigator** (`md_navigator`) adds a two‑panel file browser to the Drupal admin that
lets you navigate and read Markdown (`.md`) files stored anywhere in your Drupal
filesystem — without leaving the browser. Click a directory on the left to drill in, click
a file to read it rendered as clean HTML on the right. It's handy for keeping module and
theme READMEs, a project `docs/` folder, changelogs, runbooks or client handoff notes
browsable from inside Drupal instead of switching to a terminal or editor.

The sidebar shows only directories and files that actually contain Markdown, so there's no
noise from other file types. You can drill into subdirectories and step back with an Up
button, and full Markdown rendering covers headings, bold and italic, tables, code blocks
and blockquotes. A **search** box searches across all configured directories at once and
splits results into filename matches and content matches with highlighted excerpts. Access
is governed by standard Drupal permissions, so you decide which roles can browse.

You choose which directory trees the browser starts from — for example `modules/custom`,
`themes/custom`, `core/modules`, or any path relative to the Drupal root. Reading files is
all the base module does; an optional submodule adds create‑and‑edit capability.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   optionally add the editor submodule.

MD Navigator's starting directories and role access are set through its admin screen and
Drupal's permissions, described under "How to use it" below rather than in a separate
configuration page.

## How to use it

1. **Grant access.** On **People → Permissions**, give the roles that should use the
   browser the MD Navigator permission. Browsing and reading is available to any role you
   authorise.
2. **Point it at your Markdown.** Configure one or more **starting directories** — paths
   relative to the Drupal root, such as `modules/custom`, `themes/custom` or a project
   `docs/` folder. The browser will list only the directories and files under them that
   contain `.md` content.
3. **Browse and read.** Open MD Navigator from the admin, click a directory to drill in,
   the Up button to go back, and a file to read it rendered on the right.
4. **Search.** Type a term to search across every configured directory at once; results
   are grouped into filename matches and content matches with highlighted excerpts.

## Optional editing (the `md_navigator_editor` submodule)

The base module is read‑only. If you also want to **create and edit** `.md` files from the
browser — with a rich Markdown toolbar (bold, italic, headings, lists, code blocks, tables,
source view) and save changes back to the filesystem — enable the
**`md_navigator_editor`** submodule. It is powered by the separate
[MDX Editor](https://www.drupal.org/project/mdxeditor) module and is kept separate so that
sites which only need reading are not burdened with that dependency. See
[Installation](installation/index.md) for how to add it.
