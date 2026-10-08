<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR Menus (dsfr_menu) — agent index

Helper module in the **DSFR** suite (French State Design System). One admin form seeds a fixed set
of **DSFR footer/social menus** as real `menu` + `menu_link_content` entities and (optionally) places
them as `system_menu_block` blocks in the matching DSFR theme regions. No file upload, no pasted data —
every menu, label and link is **hardcoded** in the `Menus` service. Package **DSFR**. License
GPL-2.0-or-later. Core `^10 || ^11`. Version **2.1.x** (documented from a **dev checkout** — `info.yml`
has no `version:`; no `composer.json` ships).

Dependencies (from `info.yml`): core **block**, **menu_link_content**, **text**, and **dsfr_core**
(provides the `dsfr_core.tools` service used for theme/region detection). README also tells you to install
`form_options_attributes`, but it is not an `info.yml` dependency (dsfr_core pulls it in).

## What it provides

- **1 form / route** — `dsfr_menu.import` at `/admin/dsfr/import/menus`
  (`\Drupal\dsfr_menu\Form\ImportmenusForm`), `configure:` target of the module, menu tab under
  `dsfr_core.settings` (`dsfr_menu.links.menu.yml`).
- **1 permission** — `administer dsfr_menu settings` (`restrict access: false`); the only requirement on the route.
- **1 service** — `dsfr_menu.config` → `\Drupal\dsfr_menu\Menus` (holds the menu/label/region/item templates and the create logic).
- **No** config schema, `config/install`, `.module`/`.install`, Drush commands, plugins, hooks, or templates.

## Solution docs

- **The import form, the `Menus` service, routes & permissions, the created entities** →
  [api/import-and-service.md](api/import-and-service.md)
