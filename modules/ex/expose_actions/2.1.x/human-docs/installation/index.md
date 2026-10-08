# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Actions** module (`action`) — this is the only dependency, and Drupal
  enables it automatically when you turn on Expose actions.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/expose_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/expose_actions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en expose_actions -y
```

## Verify it worked

After enabling, visit **People → Permissions** and search for "exposed action".
You should see an `access exposed action …` permission for each action available
on your site. Grant one to a role, then view an entity of the relevant type as a
user with that role — the exposed action should appear as a local action link, and
clicking it should open a confirmation form.

Next, see the "How to use it" section of the [overview](../index.md) for the full
expose-and-grant workflow.
