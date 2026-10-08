<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **User** and **System** modules, which are part of core and
  already enabled on any standard site.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/api_tester -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_tester -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_tester -y
```

## Next steps

Grant the tool's permissions under **People → Permissions** — **`use api tester`**
to the developers who will use it, and **`administer api tester`** to whoever
manages it. Keep both restricted to trusted developers, since the tool can send
arbitrary requests. Then use it as described in the [main guide](../index.md).
