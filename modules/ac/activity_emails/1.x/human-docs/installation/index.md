# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12**
  (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- A **working mail system** on the site — Activity Emails sends through Drupal's
  standard mail transport (for example your SMTP setup), so notifications only
  arrive if outgoing mail is configured and working.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/activity_emails -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/activity_emails -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en activity_emails -y
```

After enabling, go to [Configuration](../configuration/index.md) to switch
notifications on and set a recipient — nothing is sent until you do.
