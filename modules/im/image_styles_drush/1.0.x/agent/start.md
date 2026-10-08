<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Styles Drush (image_styles_drush) — agent index

**Drush commands to create, list and modify image styles and their effects from the command line.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11 · **Depends on:** image · **Package:** Media
- **Command file:** `ImageCommands` (`src/Commands/ImageCommands.php`) + `ImageService`; registered via `drush.services.yml`.
- **Commands:** `image-styles:list` (isl), `:create` (isc), `:delete` (isd), `:add-effect` (isae), `:delete-effect` (isde), `:effects` (ise), `:params` (isp).
- **Security:** CLI-only; no routes, web forms or permissions. Effect JSON parameters are not validated (operator can break rendering) but there is no web-facing surface. No findings.

See [drush/commands.md](drush/commands.md)
