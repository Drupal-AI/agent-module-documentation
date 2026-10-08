# Installation

## Requirements

- **Drupal 10, 11 or 12** (`core_version_requirement: ^10 || ^11`, and the
  project's supported core range extends up to Drupal 12).
- No other module dependencies, and no additional PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/spaces_enforced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/spaces_enforced -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spaces_enforced -y
```

That is all it takes — the space-in-username rule applies to new registrations
immediately. If you want to change the required character or the number of times
it must appear, adjust the module's rule to suit your site.

## Verify it worked

Go to the user registration form and try to register an account with a
single-word username (no space). It should be rejected, while a username
containing a space is accepted.
