# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A **Mailchimp account and API key**.
- The module uses Mailchimp's official PHP marketing library, which Composer pulls
  in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/mailchimp_marketing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the Mailchimp PHP library) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailchimp_marketing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailchimp_marketing -y
```

## Submodule — enable if you need it

Mailchimp marketing ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Subscribe (content type)** | `mailchimp_marketing_subscribe_ct` | Content-type-based subscription — tie Mailchimp subscription to a content type. |

Enable it only if you need that behaviour:

```bash
drush en mailchimp_marketing_subscribe_ct -y
```

## Verify it worked

Log in as an administrator and open the settings page (the
`mailchimp_marketing.admin` route, under **Configuration**). Enter your API key,
save, and confirm the module can see your Mailchimp audiences. See
[Configuration](../configuration/index.md) for the details.
