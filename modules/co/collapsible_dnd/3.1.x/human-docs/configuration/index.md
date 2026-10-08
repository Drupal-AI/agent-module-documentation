# Configuration

Collapsible DnD works everywhere out of the box — everything on this page is
**optional**. The settings let you limit which admin screens it runs on and turn
on three extra toolbar controls.

## Open the settings form

1. Log in as a user with the **"administer collapsible dnd settings"**
   permission (an administrator by default).
2. Go to **Configuration → User interface → Collapsible DnD**, or navigate
   directly to `/admin/config/user-interface/collapsible-dnd`.

## Route patterns — where it runs

The main control is a text area of **route patterns**, one per line. These are
Drupal *route names* (for example `entity.entity_form_display.node_default`), and
`*` acts as a wildcard matching any run of characters, so
`entity.entity_form_display.*` targets a whole family of routes. Blank lines and
lines beginning with `#` are ignored.

How the list is interpreted depends on one checkbox:

- **Leave the list empty** — the feature runs **everywhere** (the default).
- **List some patterns, checkbox off** *(default)* — the patterns act as an
  **exclusion** list: the feature runs everywhere *except* on matching routes.
  Use this to switch it off on a screen where it gets in the way.
- **List some patterns, "Enable only on matching routes" checked** — the patterns
  act as an **allow** list: the feature runs *only* on matching routes and nowhere
  else.

## Toolbar controls

Three checkboxes add optional buttons/tools to the toolbar of each affected
draggable table. All three are **off by default**:

- **Expand all** — adds a button that opens every collapsed sub-tree at once.
- **Collapse all** — adds a button that folds every sub-tree at once.
- **Search** — adds a per-table search box so you can filter rows by typing a
  keyword, handy on very large tables.

Turn on only the ones that add value; leaving them all off keeps the interface
minimal.

## Save

Click **Save configuration**. Changes take effect on the next page load. (These
settings live in the `collapsible_dnd.settings` config object, so they can also be
set with Drush, e.g. `drush config:set collapsible_dnd.settings expand_all true
-y`, and they export with the rest of your configuration.)
