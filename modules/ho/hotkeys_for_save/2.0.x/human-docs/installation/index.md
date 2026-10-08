<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`) — works on Drupal 9, 10,
  and 11.
- No contributed-module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/hotkeys_for_save -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hotkeys_for_save -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hotkeys_for_save -y
```

On install, the **Use hotkeys for save** permission is granted to the
administrator role, so admins can use Ctrl+S / Cmd+S right away. There is no
settings form.

## Grant the permission to other roles

To let another role use the shortcut, add the permission at **People →
Permissions**, or from Drush:

```bash
drush role:perm:add editor 'use hotkeys for save'
```

> Grant this permission only to trusted editors and admins — it suppresses the
> browser's native Ctrl+S ("Save As") behavior, so it is not appropriate for
> ordinary users.

This module has no submodules.
