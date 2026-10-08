# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- No other contrib module dependencies. It integrates with the *Multiple
  Registration* module when that is present, but does not require it.

> **Heads up:** this project is minimally maintained (maintenance fixes only) and
> is not covered by Drupal's security advisory policy. Weigh that before adopting
> it on a new site.

## Install with Composer

From the project root:

```bash
composer require drupal/enforce_user_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/enforce_user_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en enforce_user_fields -y
```

## Verify it worked

1. Confirm the module is enabled on the **Extend** page (`/admin/modules`).
2. Mark at least one user account field as **required** at *Configuration →
   People → Account settings → Manage fields*.
3. Log in as a test user whose profile is missing that field — you should be
   redirected to the profile edit form and kept there until the field is
   completed.
