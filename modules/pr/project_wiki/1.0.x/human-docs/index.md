# Project Wiki — manual setup guide

**Project Wiki** (`project_wiki`) gives your Drupal project an editable, in-site
**wiki** — a place to document a larger project's structure and functionality so
the knowledge survives even after the details fade from memory. You (and whoever
you grant access) create, edit, and delete wiki entries through Drupal's UI, and
the Project Wiki list page lets you search and filter across all entries.

An important thing to know up front: the **base module on its own does not let you
create or edit wiki content** — it provides the list page and the permissions
framework. To actually author entries you enable one or both submodules:

- **Project Wiki Entity Content** — create and manage wiki entries as content
  entities through Drupal's UI, with manageable fields and displays.
- **Project Wiki Markdown Content** — provide wiki content from Markdown files
  shipped in a submodule, which you can update remotely without editing content on
  each site. (A "Project Wiki Markdown Content Example" module documents how to
  build your own Markdown submodule.)

Wiki pages are user-editable content, governed by the module's permissions — so
gate editing appropriately and be mindful that entries are authored by people.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   List.js library), enable the module, and choose your content submodule.

The base module has no central settings form. Content and permission setup is
covered under "How to use it" below; the Markdown submodule adds a small settings
page, also noted there.

## Where it lives in the admin menu

Once enabled, the **Project Wiki list page** (where you view all entries) is
reachable from the Admin Toolbar. Permissions for Project Wiki and its submodules
are at **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. **Set permissions.** At **People → Permissions**, decide who can view and who
   can edit the wiki (and its submodules).
2. **Enable a content submodule.** Remember the base module can't create content
   on its own:
   - Enable **Project Wiki Entity Content** to author entries in the UI. Then use
     **Content → Project Wiki Entity** to create and manage entries, and
     **Structure → Manage Project Wiki Entity** to manage its fields and displays.
   - Enable **Project Wiki Markdown Content** to serve wiki content from Markdown.
     Review **Configuration → Project Wiki settings → Markdown Content Settings**
     for options around Markdown parsing and HTML escaping.
3. **Author and browse.** Create entries, then use the Project Wiki list page to
   search and filter across them.

> **Tip:** The maintainers recommend the **Gin** admin theme for the best display
> of the wiki.
