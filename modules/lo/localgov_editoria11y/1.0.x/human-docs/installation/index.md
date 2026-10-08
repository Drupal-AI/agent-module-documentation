# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Editoria11y** module (`editoria11y`) — installing this module pulls it in
  and enabling this module also enables Editoria11y.
- A **LocalGov Drupal** site is the intended context, since the configuration
  targets the **LocalGov Editor** role.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_editoria11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Editoria11y and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_editoria11y -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_editoria11y -y
```

Enabling it also enables Editoria11y and applies the LocalGov permission setup
(Editoria11y granted to the LocalGov Editor role only).

## Verify it worked

Log in as a user with the **LocalGov Editor** role and open a content page — the
Editoria11y accessibility checker should appear and flag any issues. Under **People
→ Permissions**, confirm that the Editoria11y permissions are granted to the
LocalGov Editor role and not to the others.
