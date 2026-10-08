# Menu Export — manual setup guide

**Menu Export** (`menu_export`) moves menu links between Drupal sites. Drupal's
configuration management already syncs menu *containers* (the "Main navigation" and
"Footer" menus themselves), but it does **not** carry the individual links inside
them when those links were created by hand in the UI. Menu Export fills that gap so
you can deploy navigation changes from dev to production the same way you deploy the
rest of your configuration.

The idea is simple: you pick which menus to export on an admin form, and the module
serializes every content menu link (`menu_link_content` entity) in those menus into
a configuration object. Because the links now live in config, a normal
`drush config:export` and deploy carries them along to the target site. On the
target you run an import, and the module recreates or updates each link.

Re‑imports are safe: links are matched by their UUID, so importing again updates the
existing links in place rather than creating duplicates. If a link points at a menu
that does not exist on the target yet, the module reports it as invalid and skips it
— so make sure the menu container exists first (core config handles that). One thing
to keep in mind: Menu Export handles the **content** menu links you create in the
admin UI, not the links that modules define in code.

Everything can be driven from the admin UI or from two Drush commands, which makes
it easy to slot into a CI/CD deployment pipeline. This guide is written for a
**human** clicking through the admin UI. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (no
   dependencies).
2. [Configuration](configuration/index.md) — select menus, export and import, the
   Drush commands, the permission, and the full deploy workflow.

## Where it lives in the admin menu

Menu Export adds a section under **Structure → Menu Export**
(`/admin/config/development/menu_export`) with three tabs — **Menu List**,
**Export**, and **Import**. All of them are gated by the single **Export and import
menu links** permission.

## How to use it

On the source site, choose your menus and export; commit and deploy your config; on
the target site, import your config and then run the Menu Export import. See
[Configuration](configuration/index.md) for the step‑by‑step and the Drush pipeline.
