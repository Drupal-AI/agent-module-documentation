# Views Local Tasks — manual setup guide

**Views Local Tasks** (`views_local_tasks`) lets you turn a Views **Page**
display into a second-level menu tab — what Drupal calls a *local task* — and,
optionally, attach it as a tab under any parent page, all from the Views menu
settings. Normally, adding a tab like this requires hand-writing a
`*.links.task.yml` plugin file in a custom module. This module removes that
requirement: you configure everything in the Views UI, no code or YAML needed.

Local tasks are the row of tabs you see at the top of many admin pages (for
example the *View / Edit / Revisions* tabs on a node, or *List* on the Content
page). With this module you can add your own view as one of those tabs — a
"Recent" or "Archived" tab next to core Content, a set of report tabs grouped
under one section page, or a tab pointing at another view's page as its parent.

It works by extending the standard Views *page* display with a handful of extra
menu options: a link title for the tab, a parent to attach it under (either
another view's page or a custom route id you type in), a weight to order it among
sibling tabs, and a "Local task only" option that hides the view from the normal
menu and shows it purely as a tab. Because these options are stored right on the
view, they travel with your configuration export/import.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The extra options only appear when a Views Page display's **Menu** setting is set
to **Tab**, and the core **Menu UI** module is enabled (it provides the parent
selector). Once those conditions are met:

1. Edit a View and open a **Page** display.
2. In the **Page settings → Menu** dialog, choose **Tab** as the menu type.
3. Fill in the extra fields this module adds:

   - **Local task link title** — the text shown on the tab. **Leave this empty
     and no local task is created** — this is the on/off switch.
   - **Local task parent** — the page the tab attaches under. Pick another
     applicable view's page, or choose **Custom** to type a route id yourself.
   - **Local task custom parent route** — used only when parent is *Custom*. Type
     a route id such as `system.admin_content` (the Content page),
     `entity.media.collection` (the Media page), `comment.admin` (Comments), or a
     route from any module's `links.task.yml`.
   - **Local task weight** — a number that orders this tab among its siblings
     (default `0`).
   - **Local task only** — if checked, the view is hidden from the regular menu
     and shown *only* as a tab.

4. Save the view, then rebuild caches (`drush cr`) so Drupal picks up the new tab
   definitions.

### Gotchas

- If **Menu UI** is disabled, the extra fields don't appear and nothing is stored.
- Every local task **needs a parent** — when you choose *Custom* you must fill in
  the custom route id, or no parent is set.
- Always clear caches after changing menu/tab settings; local task definitions
  are cached.

## Where it lives in the admin menu

There is no admin settings page for this module — all configuration happens
inside the Views UI (**Structure → Views**) on each individual view's Page
display, as described above.
