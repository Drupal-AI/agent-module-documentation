<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Automatic Translation Template Discovery (atd) — agent index

Helper module that lets **custom modules/themes/profiles ship their own interface translations**. It
registers any extension that contains a `translations/` directory as a local interface-translation
project so Drupal's locale importer picks up its `.po` files.

- **Dependency:** core `locale` (only). Core `^11.1`. Package: Multilingual. License GPL-2.0-or-later.
- **Mechanism:** OOP hook class `Drupal\atd\Hook\AtdTranslationInfo` implements
  `hook_system_info_alter()` (attribute `#[Hook('system_info_alter')]`). For every extension with a
  `translations/` dir it sets `interface translation project` = extension machine name and
  `interface translation server pattern` = `<path>/translations/%project.%language.po`.
- **Provides:** no routes, no permissions, no config/schema, no services, no entities, no Drush
  commands, no plugin types, no libraries. Suggests `drupal/potx` for extracting `.po` templates.
- **Test-only:** `tests/modules/atd_test` (a fixture with `translations/atd_test.netl.po`) — not a
  shipped submodule.

## Solution docs
- [How it works & operating it](api/discovery.md) — the hook, the file/naming convention, install,
  and the `drush locale-check` / `locale-update` workflow.
