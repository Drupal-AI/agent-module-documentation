# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- These **core modules**, all of which ship with Drupal and are enabled as
  dependencies automatically:
  - **Link** (`link`)
  - **Menu Link Content** (`menu_link_content`)
  - **Menu UI** (`menu_ui`)
  - **Node** (`node`)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

Note that the project's Composer name differs from the module's machine name — the
package is `drupal/multimenuui`:

```bash
composer require drupal/multimenuui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multimenuui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `multi_menu_ui`:

```bash
drush en multi_menu_ui -y
```

Drupal enables the Link, Menu Link Content, Menu UI, and Node dependencies at the
same time.

## Verify it worked

Edit any content type at **Structure → Content types → *(type)* → Edit**. Under
**Menu settings** you should now see an **Enable additional menu links** option.
Tick it, save, then add a node of that type — the **Menu settings** sidebar should
show an **Add another menu link** button. See "How to use it" on the
[overview page](../index.md).
