# Installation

## Requirements

- **Drupal 10, or 11** (`core_version_requirement: ^10||^11`).
- The **Webform** module (`webform`) — this handler is a Webform plugin, so Webform
  must be installed and enabled.
- No third-party Composer or PHP library requirements.
- A Salesforce org with **Web-to-Lead** enabled, so you have your org ID.

## Install with Composer

From the project root:

```bash
composer require drupal/sf_web2lead_webform_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Webform isn't already present, Composer will pull it in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sf_web2lead_webform_handler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sf_web2lead_webform_handler -y
```

This also ensures Webform is enabled.

## Next steps

Add the handler to a webform and map its fields to Salesforce. See
[Configuration](../configuration/index.md). Remember to add spam/bot protection to
any form that uses the handler.
