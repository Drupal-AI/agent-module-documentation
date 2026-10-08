# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.3** or newer (`php_requirement: 8.3`).
- Core's **User** module (enabled by default) — this is the only module
  dependency, and it is where flood control lives.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/login_attempts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_attempts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_attempts -y
```

That's the whole setup — there is no settings form. The remaining‑attempts warning
is driven by Drupal core's existing flood limits; see the notes in the
[overview](../index.md) if you want to change how many attempts are allowed or how
long a lockout lasts.

## Verify it worked

On a test account, enter the wrong password a few times on the login form. Once
you reach the warning threshold, you should see a message stating how many failed
attempts you've made and how many remain before the account is temporarily
blocked. (Use a throwaway account so you don't lock yourself out of a real one.)
