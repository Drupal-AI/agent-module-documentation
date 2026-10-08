<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Styles Drush adds Drush commands for building and managing Drupal image styles and their effects from the command line.

The module registers a Drush command file (`ImageCommands`) backed by an `ImageService`, exposing commands to list styles, create/delete a style, add/delete an effect on a style, list available effects, and display an effect's parameters (as JSON) — usable interactively or scripted. It leans on the core Image effect manager and image-style storage, so it works alongside Image Effects and similar modules. It is CLI-only: no routes, controllers, web forms or permissions, and access is whatever the Drush/site shell already grants.

Operationally, the README warns that effect parameter values passed as JSON are **not validated** — bad values (e.g. non-hex colors) can break rendering — so treat it as a power tool for trusted operators. Because it only runs under Drush there is no anonymous or web-facing attack surface. Typical use: script the creation of a complex image style and its chain of effects during deployment or environment setup.
---
Image Styles Drush provides Drush commands to create, list and edit image styles and effects from the CLI.
---
- List all image styles with `drush isl`.
- Create a new image style with `drush isc`.
- Delete an image style with `drush isd`.
- Add an effect to a style with `drush isae`.
- Delete an effect from a style with `drush isde`.
- List available image effects with `drush ise`.
- Show an effect's parameters (JSON) with `drush isp`.
- Build a complex style non-interactively in a deploy script.
- Use interactive mode to add effects step by step.
- Pass effect parameters as JSON (e.g. scale/crop dimensions).
- Reproduce image styles across environments via scripts.
- Automate style creation in CI/CD pipelines.
- Combine with the Image Effects module's extra effects.
- Bulk-create responsive image style variants.
- Remove obsolete styles during cleanup.
- Inspect an effect's expected parameters before adding it.
- Add a convert/scale/crop effect chain to a style.
- Set hex color parameters (`#RRGGBB`) for color effects.
- Document reproducible image-style definitions in code.
- Export the command sequence as a repeatable setup script.
