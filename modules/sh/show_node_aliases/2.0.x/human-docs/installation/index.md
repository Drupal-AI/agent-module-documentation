# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Path** module (`path`) enabled — this is the only dependency, and Drupal
  enables it automatically when you turn on Show Node Aliases.
- To use the inline Edit/Delete links, an account needs core's **Administer URL
  aliases** permission. The module defines no permission of its own.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/show_node_aliases -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/show_node_aliases -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en show_node_aliases -y
```

That's the whole setup — there is nothing to configure. Edit any node that has URL
aliases and the **Existing Aliases** list appears on the form.

## Grant the permission (optional)

To give editors inline Edit/Delete links for each alias, grant them the core
**Administer URL aliases** permission at **People → Permissions**
(`/admin/people/permissions`). Users without it still see the read-only alias list.
