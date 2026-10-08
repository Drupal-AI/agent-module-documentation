<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Export exports and imports **content** menu links (`menu_link_content` entities) between Drupal sites via configuration, filling the gap that Drupal's Configuration Management leaves — it manages menu *containers* but not the individual content links inside them.

---

You pick which menus to export on an admin form at `admin/config/development/menu_export`; the selection is saved to `menu_export.settings` (`menus`). Exporting (the Export tab, the config form's save, or `drush menu_export:export`) serializes every `menu_link_content` entity in the selected menus into the `menu_export.export_data` config object, keyed by link. Because that data now lives in config, a normal `drush config:export` / deploy carries the menu links to the target site. On the target you run the Import tab or `drush menu_export:import`, which reads `menu_export.export_data` and recreates/updates each `menu_link_content` entity (matched by UUID, so re-imports update rather than duplicate); links whose target menu does not exist are reported as invalid. All three UI routes (Menu List, Export, Import) are gated by the single `export and import menu links` permission. There is no dedicated `configure` route registered in info.yml. Note the module exports **custom/content** menu links (those created in the UI), not module-defined links declared in `*.links.menu.yml`.

---

- Move manually-created menu links from a dev site to production.
- Deploy navigation changes through the normal config export/import pipeline.
- Keep a "Main navigation" consistent across dev, staging, and prod.
- Export a footer menu's links along with the rest of your configuration.
- Re-import menu links to update them in place (matched by UUID) without duplicating.
- Script menu deployment in CI with `drush menu_export:export` before `drush config:export`.
- Script the target-side apply with `drush config:import` then `drush menu_export:import`.
- Snapshot a menu's content links into config as a backup.
- Migrate menu links between environments that Configuration Management alone won't sync.
- Select multiple menus to export at once from the admin form.
- Restrict who can export/import menus with the "export and import menu links" permission.
- Rebuild a menu on a fresh site from committed `menu_export.export_data` config.
- Transfer a custom menu created by editors into version control.
- Sync menu links as part of a feature/config-split workflow.
- Recreate a menu structure on a clone without re-entering links by hand.
- Audit which menus are marked for export via `menu_export.settings`.
- Export only the menus that are guaranteed consistent across environments (per the form's caution note).
- Update production menu links after editorial changes on a content-staging site.
- Include menu links in a repeatable site-provisioning process.
- Carry translated/weighted menu link data (full entity fields) between sites.
- Avoid the limitation that core config only manages menu containers, not their content links.
