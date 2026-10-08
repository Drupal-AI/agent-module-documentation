# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Drupal core's **Field** module (`field`) — enabled automatically as a
  dependency.

No contributed modules or external libraries are required.

> **Note:** This project's security advisory coverage is marked *not covered* by
> the Drupal Security Team.

## Install with Composer

From the project root:

```bash
composer require drupal/email_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_message -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_message -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**
and confirm that **Email message** appears in the list of available field types.
Add one, and on **Manage form display** you should see a subject textfield paired
with a formatted body area.
