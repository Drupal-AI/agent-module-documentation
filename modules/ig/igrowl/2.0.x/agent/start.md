<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# iGrowl — agent index

Wraps the **iGrowl** JS notification library and adds a Drupal **Ajax command** for growl/toast notifications. Version **2.0.0**. Core `^9 || ^10`.

- `igrowl.libraries.yml` registers the library; `src/Ajax/GrowlCommand.php` is the dispatchable Ajax command.
- No routes/permissions/config. Front-end helper — callers must not pass untrusted markup into notification text.
