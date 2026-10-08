# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`), which Drupal ships and enables by default.
- The **Views Show More** module (`views_show_more`) — a contrib module used to page
  through the message listing. Composer will pull it in as a dependency.
- No PHP libraries or other third‑party Composer packages.

Note that this module is not currently covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Views Show More.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_message -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_message -y
```

Drupal will enable Views and Views Show More as needed.

## Verify it worked

After enabling, go to **People → Permissions** and confirm the Simple Message
permissions are present. Grant them to the roles that should have messaging, then log
in as a user with those permissions and confirm you can send and read private
messages. See [How to use it](../index.md#how-to-use-it) for the setup steps.
