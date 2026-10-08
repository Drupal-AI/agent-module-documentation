<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Menu (lupus_decoupled_menu) — agent index

Submodule of **lupus_decoupled**, **hard dependency of the top-level module**. Menu API endpoints
exposing Drupal menus to the front end. Version **1.5.1**. Core `^10 || ^11`.

Structure and **access filtering** stay in Drupal (an admin link must not reach an anonymous
visitor); styling and behaviour are the front end's.

Editors keep the menu UI they already use — navigation changes stop being a front-end deployment.

**Plan caching:** a menu fetched per page render is a request per page. Cache the tree in the front
end and invalidate when menus change.