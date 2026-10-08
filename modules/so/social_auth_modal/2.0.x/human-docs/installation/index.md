# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Social Auth** (`social_auth`) — this module wraps it, and Composer installs it
  automatically. The 2.x line here pairs with the **4.x** line of Social Auth.
- At least one configured Social Auth provider (Google, Facebook, Microsoft, etc.)
  for the modal to have something to open.

There are no third-party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_modal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_modal -y
```

The Composer package name (`drupal/social_auth_modal`) and the module machine name
(`social_auth_modal`) match. There is no configuration step.

## Verify it worked

With a Social Auth provider already set up, log out and open the login page. Click
a social login button — it should open the provider's sign-in page in a modal
pop-up rather than redirecting the whole page. After you authenticate, the modal
closes and the page reloads with you signed in.
