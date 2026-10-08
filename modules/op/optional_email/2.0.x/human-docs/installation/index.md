# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies, and no extra PHP library requirements.

> **Note:** At this version the module is an alpha release (2.0.0‑alpha1). Test it on
> a non‑production environment first and confirm your registration and account‑recovery
> flows behave as you expect.

## Install with Composer

From the project root:

```bash
composer require drupal/optional_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/optional_email -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en optional_email -y
```

Enabling the module makes the email field optional on the registration form
immediately.

## Verify it worked

Visit the registration form at `/user/register` as an anonymous visitor. The email
field should no longer be marked required, and you should be able to submit the form
without entering an email address. Then review **People → Permissions**
(`/admin/people/permissions`) to grant the module's permission to the roles that
need it. Remember that accounts created without an email cannot use email‑based
password reset — make sure those users have an alternative recovery path.
