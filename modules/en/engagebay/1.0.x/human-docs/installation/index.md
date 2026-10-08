# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 7.4 or newer**.
- Core's **CKEditor 5** (`ckeditor`) and **Filter** (`filter`) modules — enabled
  automatically as dependencies.
- An **EngageBay account** with login credentials.

> **Heads up:** this project is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/engagebay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/engagebay -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en engagebay -y
```

This also enables CKEditor and Filter if they are not already on.

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`), then
visit the EngageBay configuration form at `/engagebay/configure` and confirm it
loads. From there, continue to [Configuration](../configuration/index.md) to
connect your account and add the editor buttons.
