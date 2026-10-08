# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Core dependencies only** — no third‑party libraries and no other contrib
  modules required.

## Install with Composer

From the project root:

```bash
composer require drupal/login_onlyemail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_onlyemail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_onlyemail -y
```

That's the entire install — there is nothing to configure.

## Verify it worked

Log out (or open a private/incognito window) and view the login form. The single
identifier field should accept an **email address only** (a username will no longer
work). Check the *"Forgot your password"* page too — it should ask for the email
address to start password recovery.

> **Reminder:** this affects the login and password‑reset forms **site‑wide**, with
> no per‑role or per‑path exemption. If some users must still log in by username,
> use a module that accepts either identifier instead. Uninstalling restores the
> stock login form.
