# Installation

## Requirements

Check DNS is deliberately minimal. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Working **outbound DNS** from your web server — the module calls PHP's
  `checkdnsrr()` to look up each domain, so the server must be able to make DNS
  queries.

There are no other module dependencies, no third-party Composer libraries, and no
PHP extension requirements beyond a standard PHP install.

## Install with Composer

From the project root:

```bash
composer require drupal/check_dns -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/check_dns -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en check_dns -y
```

That's the whole setup. The registration-form check is active immediately for the
core user registration form — there is no configuration step and no permission to
grant.

## Verify it worked

With self-registration enabled, go to `/user/register` and enter an email at a
domain that cannot resolve (for example `test@example.invalid`). Submitting should
produce the error *"Your email domain is not recognised. Please enter a valid email
id."* A real, resolvable domain should be accepted.
