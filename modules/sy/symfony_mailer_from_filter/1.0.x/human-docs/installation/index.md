# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Symfony Mailer** module (`symfony_mailer`) — a hard dependency that
  integrates Symfony Mailer into Drupal. Install and enable it if you have not
  already.
- No third-party PHP libraries are required.

This is an early alpha release (1.0.0-alpha1); test it outside production first.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_from_filter -W
```

The Composer package name (`drupal/symfony_mailer_from_filter`) matches the
module's machine name (`symfony_mailer_from_filter`). The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed, and pulls in Symfony Mailer if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_from_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer_from_filter -y
```

Enabling the module makes the **From filter** available to add to your Symfony
Mailer policies — it does not filter anything until you attach it to a policy.

## Next steps

Add the **From filter** to the relevant Mail policies at **Configuration →
System → Mailer** (`/admin/config/system/mailer`) and set the allowed *From*
address(es), as described under *How to use it* in the [main guide](../index.md).
