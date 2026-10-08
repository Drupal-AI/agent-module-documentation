<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ISPIM Drush commands

Service: `ispim.preview_image.commands` (`Drupal\ispim\Commands\PreviewImageCommands`), injected with `entity_type.manager`, `entity_field.manager`, and `file.repository`.

It creates `ispim_preview_image` entities from files. `createFile()` reads a **local, operator-supplied** path with `file_get_contents($pathName)` and stores it through `file.repository->writeData()` into the field's configured `uri_scheme://file_directory/`. Because the path is a CLI argument (not web request input), there is no SSRF/traversal exposure from anonymous users — but treat the command as privileged (it can read any file the PHP user can read).

Run `drush list` after enabling the module to see the exact command name and options, or inspect the `#[CLI\Command]` attributes in `src/Commands/PreviewImageCommands.php`.
