# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other contrib modules, and no third‑party Composer or PHP libraries.
- For the **email** action to work, your site must be able to send mail — confirm
  Drupal's mail system is configured and delivering.

## Install with Composer

From the project root:

```bash
composer require drupal/one_time_login_link_admin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/one_time_login_link_admin -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en one_time_login_link_admin -y
```

## Grant access carefully

The actions are gated by core's **Administer users** permission — there is no new
permission to configure. Because that permission lets a holder mint a login link
that logs them in as any account, grant it only to fully trusted staff, and
review who already has it at **People → Permissions**.

## Verify it worked

Log in as a user with **Administer users**, go to **People** (`/admin/people`),
and confirm the generate/email login‑link actions appear beside each user. Try
the email action against a test account and check the message arrives.
