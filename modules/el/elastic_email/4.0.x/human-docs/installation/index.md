# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 | ^11`).
- The **Mailsystem** module (`mailsystem`) — this is the only module dependency,
  and Composer/Drush will bring it in for you.
- An **Elastic Email account** with an API username (your account email address)
  and an account **API Key**. You can sign up for free at
  [elasticemail.com](https://elasticemail.com); note down the API Key and username,
  which you'll paste into the settings form later.
- The Elastic Email PHP SDK, which is pulled in automatically as a Composer
  dependency of the module.

## Install with Composer

From the project root:

```bash
composer require drupal/elastic_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
(including Mailsystem and the Elastic Email SDK) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elastic_email -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elastic_email -y
```

This also enables Mailsystem if it isn't already on.

## Verify it worked

The module is installed, but it won't send anything until you enter your
credentials and point Mailsystem at it. Head to
[Configuration](../configuration/index.md) to paste your API key, wire up
Mailsystem, and send a test message. Once configured, visit the dashboard at
`/admin/config/system/elastic_email` to confirm your account and credit status
appear.
