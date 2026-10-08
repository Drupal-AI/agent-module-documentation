# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **SparkPost account** and an **API key** scoped to sending mail — this is what
  the module authenticates with.
- To keep your outgoing mail routed correctly you will typically use Drupal's
  **Mail System** setup so that SparkPost becomes the mail backend (historically
  this module pairs with the Mail System module).

There are no additional PHP or library requirements for the current release beyond
what Composer installs.

## Install with Composer

From the project root:

```bash
composer require drupal/sparkpost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in any required
libraries and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sparkpost -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sparkpost -y
```

> **This release is an alpha.** Because this module handles every transactional
> email your site sends, test it thoroughly on staging before switching production
> mail over to it.

## Store your API key safely

Before configuring the module, put your SparkPost API key in an environment
variable and reference it through a **Key** entity rather than pasting it into
exported configuration. The key can send mail as your domain and read your
delivery data, so treat it as a live secret and scope it to sending only.

## Verify it worked

Log in as an administrator and visit **Configuration → Web services → Sparkpost**
(`/admin/config/services/sparkpost`). If the settings form loads, the module is
installed. Continue to [Configuration](../configuration/index.md) to enter your
key and send a test message.
