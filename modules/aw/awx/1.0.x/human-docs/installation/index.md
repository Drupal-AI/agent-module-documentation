# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A reachable **AWX or Ansible Tower** instance and an **API token** for a user
  allowed to launch the job templates you want to trigger.

There are no other module dependencies listed. Note the release is **1.0.0‑alpha3**
— an early alpha, so test before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/awx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/awx -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en awx -y
```

After enabling, configure the AWX endpoint and API token in the module's
settings — and store that token as an environment variable, never in committed
config. See [How to use it](../index.md#how-to-use-it) on the overview page.
