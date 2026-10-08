<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sector Mega Menu — agent index

Two blocks (**Mega Menu Root**, **Mega Menu Body**) render a Drupal menu as a mega menu, built on `menu_block`. Provides Twig templates and a `hook_preprocess_menu` that adds `menu_link_attributes` and a current-path flag. Version **1.0.3**, core `^10.1`.

Pure theming/site-structure: no routes, no permissions, no storage, no external calls.