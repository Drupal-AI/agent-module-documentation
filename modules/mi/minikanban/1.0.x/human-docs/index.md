# MiniKanban — manual setup guide

**MiniKanban** (`minikanban`) is a lightweight project-management / kanban-board
tool that lives inside your Drupal site. It organises work as cards moving across
columns (to-do / doing / done), with projects, epics and tasks, rich-text
(CKEditor 5) card descriptions, file uploads, user tagging (mentions), colours,
drag-and-drop, and mail notifications. It is aimed at smaller teams that want full
control over their project-management tool — or that want it running on the very
site it helps manage.

Everything MiniKanban stores is a custom entity, which keeps it easy to extend but
also means the board is entirely self-contained: you don't wire it into content
types or Views yourself. Once enabled you configure it once, then use the board at
`/kanban`. It builds on core's Editor, CKEditor 5, Options and Views, and pulls in
a few contributed modules — **Markdown** (`markdown`) and **Color Field**
(`color_field`) — as dependencies, plus CKEditor mentions for user tagging.

Because cards are authored through a rich-text editor and can mention (and notify)
other users, treat card content the way you treat any user-authored HTML: keep the
text format's allowed tags sensible, and use MiniKanban's own permissions to gate
who can see and edit boards so notifications only reach the intended team.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install MiniKanban and its
   dependencies with Composer, and enable it.

MiniKanban has no single "settings form" documented for this version, so there is
no separate configuration chapter — the setup steps below cover what you need.

## Where it lives in the admin menu

After enabling the module, its administrative settings live at **Configuration →
Workflow → MiniKanban** (`/admin/config/workflow/minikanban`), and the board
itself is used at `/kanban`.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Visit **`/admin/config/workflow/minikanban`** to configure the board.
3. Grant the MiniKanban permissions (under **People → Permissions**) to the roles
   that should create or view boards, so cards and mention notifications stay
   within the intended team.
4. Open **`/kanban`** to start creating projects, epics, tasks and cards — drag
   cards between columns, write rich-text descriptions, attach files and tag
   teammates.
