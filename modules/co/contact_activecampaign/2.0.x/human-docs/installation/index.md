# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Contact** module (`contact`) — provides the forms whose submissions
  are forwarded. Drupal enables it automatically as a dependency.
- The **ActiveCampaign API** module (`activecampaign_api`) — holds your account
  URL and API key and performs the API calls. Composer installs it alongside this
  module.
- An **ActiveCampaign account** with API access, plus the custom fields you want
  to receive the submitted data already created on the ActiveCampaign side.

There are no additional third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_activecampaign -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the `activecampaign_api`
dependency and updates any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_activecampaign -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_activecampaign -y
```

Drupal enables the Contact and ActiveCampaign API modules too if they aren't
already on.

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to enter your
ActiveCampaign credentials and map your fields. Once that's done, submit a test
contact form and confirm a matching contact appears in your ActiveCampaign
account. Nothing is sent until the credentials and mapping are in place.
