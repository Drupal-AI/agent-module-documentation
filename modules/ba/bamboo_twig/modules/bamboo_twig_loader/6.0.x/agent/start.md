<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig - Loaders — agent index

The richest submodule: Twig functions to **load** and **render** Drupal things from a template —
entities, revisions, fields, blocks, regions, forms, menus, views, images. Submodule of **bamboo_twig**.

- **Every load_* / render_* function with signatures, defaults and gotchas** → [theming/loader.md](theming/loader.md)

Services `bamboo_twig_loader.twig.loader` (load_*) and `bamboo_twig_loader.twig.render` (render_*).
Enable: `drush en bamboo_twig_loader -y`.
