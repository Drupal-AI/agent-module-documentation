# Configuration

All of the module's settings live on one form at **Configuration → Content
authoring → Exclude Node Title** (`/admin/config/content/exclude-node-title`). You
need the *Administer exclude node title* permission to open it.

## Site‑wide options

At the top of the form are two choices that apply across the whole site:

- **Remove node title from search pages** — when ticked, node titles are also
  stripped from core Search results and the search index. (This checkbox is only
  available when the core Search module is enabled.)
- **Type of rendering** — how the title disappears:
  - **Remove text** *(default)* — empties the title's text so it is gone from the
    page.
  - **Hidden class** — keeps the title in the markup but adds a `visually-hidden`
    class, so it stays available to screen readers and search engines while being
    invisible on screen. This is the better choice for accessibility and SEO.

## Per content type

Below that, the form lists each of your content types. For every one you set two
things:

- **Exclude mode** — a select with three options:
  - **None** *(default)* — never hide the title for this content type.
  - **All nodes** — hide the title on every node of this type (in the view modes you
    check below).
  - **User defined nodes** — hide nothing automatically, but add an "Exclude title
    from display" checkbox to the node edit form so editors decide case by case.
- **View modes** — a set of checkboxes for the view modes the hiding should apply
  to: Full content, Teaser, RSS, the search modes, and a special **Node form** mode
  (which controls the title on the edit form itself). These checkboxes are hidden
  while the exclude mode is set to None, and appear once you choose All or User
  defined.

So, for example, to hide the title on Article teasers but keep it on the full page,
set Article's mode to **All nodes** and tick only the **Teaser** view mode.

## The per‑node checkbox (User defined mode)

When a content type is set to **User defined nodes**, editors with the right
permission see an **Exclude title from display** checkbox on that type's node edit
form:

- Users with *Exclude any node title* see it on every node.
- Users with *Exclude own node title* see it only on nodes they own.

Ticking it and saving hides that individual node's title; unticking it shows it
again. These per‑node choices are stored in Drupal's State system (keyed by node
ID), separate from the main configuration.

## Saving and deploying

Click **Save configuration** to apply; the module clears caches on save so changes
show immediately. The content‑type, view‑mode and render‑type settings are stored
as configuration (`exclude_node_title.settings`), so they export and deploy between
environments with `drush config:export` / `config:import`. Note that the per‑node
list (from User defined mode) lives in State rather than configuration, so it does
not move with a config export.
