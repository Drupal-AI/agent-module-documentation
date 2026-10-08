<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation + Entity Workflow (navigation_plus_entity_workflow) — agent index — **DEPRECATED**

Submodule of **navigation_plus**. Package *Page Building*. Core `^10 || ^11`. Version **2.3.x**.
Depends on `navigation_plus`.

**Do not recommend, install, or carry it forward.** Its functionality was folded into the main
`navigation_plus` module.

## What is actually on disk

The submodule ships **no runtime code** — no `src/`, no routing, no services, no permissions, no
config. It contains only:

- `navigation_plus_entity_workflow.info.yml` — description, verbatim: *"Deprecated. This
  functionality has been moved into the main module so Navigation + Entity Workflow will be deleted
  soon."*
- `navigation_plus_entity_workflow.install.php` — a single update hook
  `navigation_plus_entity_workflow_update_10001()` that calls
  `module_installer->uninstall(['navigation_plus_entity_workflow'])`, i.e. on the next
  `drush updatedb` it **uninstalls itself**.

## Guidance

If it is enabled on an inherited site, run database updates (it self-uninstalls) or uninstall it
manually and rely on `navigation_plus`. Note it carries **no `lifecycle: deprecated`** info-file
key — the deprecation is stated only in the description and enforced by the update hook, so
automated lifecycle scanners will not flag it. Do not add it to a new site or a composer file.
