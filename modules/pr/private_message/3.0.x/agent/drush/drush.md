<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message — Drush

Defined in `src/Drush/Commands/PrivateMessageCommands.php`.

## `private_message:prepare_uninstall` (alias `pu`)
Prepares the module for uninstallation by **deleting all private messages and private message
threads** (they cannot be recovered). It prompts for confirmation, then runs a batch via the
`private_message.uninstaller` service.

```bash
drush private_message:prepare_uninstall
# or
drush pu
```

Because the two content entity types hold data, Drupal will not let you uninstall the module
while messages/threads exist — run this first, then `drush pmu private_message`. This is the
CLI equivalent of the `/admin/config/private-message/uninstall` page.

That is the only Drush command the module ships.
